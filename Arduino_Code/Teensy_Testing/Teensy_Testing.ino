#include <ros.h>
#include <std_msgs/Float64.h>
#include <ar3/ar3_feedback.h>
#include <teensy/ar3_control.h>
#include <math.h>
#include <Encoder.h>
#include <Servo.h>

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  Pin definitions and Variables
//  All measuremements are in mm, all angles are in radians
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define joint1PUL 0
#define joint1DIR 1

#define joint2PUL 2
#define joint2DIR 3

#define joint3PUL 4
#define joint3DIR 5

#define joint4PUL 6
#define joint4DIR 7

#define joint5PUL 8
#define joint5DIR 9

#define joint6PUL 10
#define joint6DIR 11

#define joint1LIM 31

// E-Stop '+' pin. Must be grounded to work
#define eStopPin 32

// Good 'ol PI
float pi = 3.1415926;

// Varables used to store time both current and 'stopwatch' times
unsigned long int t_old=0, t=0, pub_freq = 500000;

// Number of pulses to rotate a joint 2*PI radians. Accounts for settings on the stepper driver and
// all mechanical ratios. Inline comments denote the parameters used in the calculation.
float pulse1Rev = 1600.0*10.0*4.0; // pulse/rev, gearbox, pulley ratio
float pulse2Rev = 3200.0*50.0; // pulse/rev, gearbox
float pulse3Rev = 1600.0*50.0; // pulse/rev, gearbox
float pulse4Rev = 1600.0*(13.0+(212.0/289.0))*2.4893; // pulse/rev, gearbox, pulley ratio
float pulse5Rev = 1.0/((8.0/1600.0)/(2.0*pi*13.675)); // pulse/rev, lead screw
float pulse6Rev = 800.0*(19.0+(38.0/187.0)); // pulse/rev, gearbox;

// Pulse width of the signal sent to the stepper driver. This time is in microsecons
// and is passed to the delay_microseconds() function. Making this value larger will
// severely affect the frequency at which the main loop runs
int pulDelay = 100; // default is 50 for max speed

// Encoder pins and classes
#define Enc1_Pin1 22 // encoder1 CLK pin
#define Enc1_Pin2 23  // encoder1 DT pin
Encoder Enc1(Enc1_Pin1, Enc1_Pin2);
long oldPosition1  = -1, newPosition1 = 0;

// Fuzzy equality to prevent jitter in the motors. This value is when the joint is 'close enough'
// to its setpoint
float angleTol = 0.0005;

// Current state of the e-stop pin. Default is True meaning no movements will not occur
int ePinValue = 1;
int limState = 0;

// Command States
int home = 0;
int run = 0;
int rest = 0;

// Gripper positions
Servo gripper_servo;
//int gripper_cmd = 0, closed_pos = 0, opened_pos = 80;
int gripper_angle = 0;

float joint_speed;

///////////////////////////////////////////////////////////////////////////
// Class declarations
///////////////////////////////////////////////////////////////////////////
class RobotJoint{
  public:
    char id[20];
    int pul_pin = -1, dir_pin = -1;
    int stopped = 1;
    int pulse = 0;
    int dir = 1;
    
    float step_size;
    int steps_to_go;
    int steps_taken = 0;
    
    unsigned int pul_delay = 0, pulse_min = 60, pulse_max = 800;
    unsigned int accel_delay = 0;
    
    float spd = 1.0;
    
    float lower_limit = -1.58, upper_limit = 1.58;

    float setpoint = 0.0, prev_setpoint = -1.0;;
    float angle = 0.0;
    float error = 0.0;

    float tolerance = 0.005;

    unsigned long int t = 0, t_prev = 0;
  
    RobotJoint(int pul_pin,int dir_pin, float step_size, char* id){
      this->pul_pin = pul_pin;
      this->dir_pin = dir_pin;
      this->step_size = step_size;
      strcpy(this->id,id);

      this->change_speed(this->spd);
    }
    
    void update_position(void){
        this->t = micros();

        if (this->prev_setpoint != this->setpoint){
          this->steps_taken = 0;
          this->prev_setpoint = this->setpoint;
        }
        
        this->error = this->setpoint - this->angle;
        this->steps_to_go = int(abs(this->error / this->step_size));

        if (this->error < -this->tolerance){
            this->dir = -1;
        }
        else if (this->error > this->tolerance){
            this->dir = 1;
        }
        else{
            return;
        }

        if (this->dir == 1){
            digitalWrite(this->dir_pin,HIGH);
        }
        else{
            digitalWrite(this->dir_pin,LOW);
        }

        if (this->steps_to_go < 1000){ // Decellerate
          this->accel_delay = int((1.0/(this->steps_to_go/20000.0)));
        }
        else if (this->steps_taken < 1000){ // Accelerate
          this->accel_delay = int((1.0/(this->steps_taken/20000.0)));
        }
        else{ // Coast at specified speed
          this->accel_delay = 0;
        }
        
        if (this->pulse && (this->t - this->t_prev)>(this->pul_delay+this->accel_delay)){
            digitalWrite(this->pul_pin,0);
            this->t_prev = this->t;
            this->pulse = 0;
            this->angle = this->angle + (this->step_size*this->dir);
        }
        else{ //if (!this->pulse && (this->t - this->t_prev)>this->pul_delay){
            digitalWrite(this->pul_pin,1);
            this->pulse = 1;
            this->steps_taken++;
        }
    }

    void change_speed(float spd){
        this->pul_delay = map(spd,0.0,1.0,this->pulse_max,this->pulse_min);
    }
};

RobotJoint joints[6] = {RobotJoint(joint1PUL,joint1DIR, (1.0/pulse1Rev)*2.0*pi, "1"),
                        RobotJoint(joint2PUL,joint2DIR, (1.0/pulse2Rev)*2.0*pi, "2"),
                        RobotJoint(joint3PUL,joint3DIR, (1.0/pulse3Rev)*2.0*pi, "3"),
                        RobotJoint(joint4PUL,joint4DIR, (1.0/pulse4Rev)*2.0*pi, "4"),
                        RobotJoint(joint5PUL,joint5DIR, (1.0/pulse5Rev)*2.0*pi, "5"),
                        RobotJoint(joint6PUL,joint6DIR, (1.0/pulse6Rev)*2.0*pi, "6")};

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ROS Definitions
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Joint 1 callback
ros::NodeHandle  nh;

void AR3ControlCallback(const teensy::ar3_control &AR3_Control_Data){
    home = AR3_Control_Data.home;
    run = AR3_Control_Data.run;
    rest = AR3_Control_Data.rest;
    
    gripper_angle = AR3_Control_Data.gripper_angle;
    joint_speed = AR3_Control_Data.speed;
    
    for (int idx=0;idx<6;idx++){
      joints[idx].setpoint = AR3_Control_Data.joint_angles[idx];
    }
    
}

ros::Subscriber<teensy::ar3_control> AR3ControlSub("/AR3/Control",& AR3ControlCallback);

ar3::ar3_feedback AR3FeedbackData;
ros::Publisher AR3FeedbackPub("/AR3/Feedback", &AR3FeedbackData);

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  Setup
////////////////////////////////////////////////////////////////////////////////////////////////////////////
void setup() {
    // Stepper Motors
    pinMode(joint1PUL,OUTPUT);
    pinMode(joint1DIR,OUTPUT);

    pinMode(joint2PUL,OUTPUT);
    pinMode(joint2DIR,OUTPUT);

    pinMode(joint3PUL,OUTPUT);
    pinMode(joint3DIR,OUTPUT);

    pinMode(joint4PUL,OUTPUT);
    pinMode(joint4DIR,OUTPUT);

    pinMode(joint5PUL,OUTPUT);
    pinMode(joint5DIR,OUTPUT);

    pinMode(joint6PUL,OUTPUT);
    pinMode(joint6DIR,OUTPUT);

    // E-Stop pin
    pinMode(eStopPin,INPUT_PULLUP);

    pinMode(joint1LIM,INPUT_PULLUP);

    gripper_servo.attach(21,500,2400);
    
    // Ros subscribers
    nh.initNode();
    nh.subscribe(AR3ControlSub);

    // Debug info
    nh.advertise(AR3FeedbackPub);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  Main Loop
////////////////////////////////////////////////////////////////////////////////////////////////////////////
void loop() {
    // Runtime parameters
    t = micros();
    ePinValue = digitalRead(eStopPin);
    newPosition1 = Enc1.read();

    // Update joint 2 angle from encoder
    if (newPosition1 != oldPosition1) {
      AR3FeedbackData.encoder_pulses[1] = int(newPosition1);
      oldPosition1 = newPosition1;
    }

    /////////////////////////////////////////////
    //  State machine
    /////////////////////////////////////////////
    
    // E-Stop state
    if (ePinValue){
        if ((t-t_old) > (pub_freq)){
            AR3FeedbackData.eStop = 1;
            AR3FeedbackData.running = 0;
    
            for (int idx=0;idx<6;idx++){
              AR3FeedbackData.joint_angles[idx] = joints[idx].angle;
            }
            
            for (int idx=0;idx<6;idx++){
              AR3FeedbackData.setpoint_angles[idx] = joints[idx].setpoint;
            }
            AR3FeedbackPub.publish(&AR3FeedbackData);
            t_old = t;
        }
    }

    // Run state
    else {
        AR3FeedbackData.eStop = 0;
        AR3FeedbackData.running = 1;

        gripper_servo.write(gripper_angle);
        

        for (int idx=0;idx<6;idx++){
          joints[idx].change_speed(joint_speed);
          joints[idx].update_position();
        }
            
        // Publish the arduinos current angle value for debugging purposes
        if ((t-t_old) > (pub_freq)){
            AR3FeedbackData.eStop = 0;
            AR3FeedbackData.running = 1;
    
            for (int idx=0;idx<6;idx++){
              AR3FeedbackData.joint_angles[idx] = joints[idx].angle;
            }
            
            for (int idx=0;idx<6;idx++){
              AR3FeedbackData.setpoint_angles[idx] = joints[idx].setpoint;
            }
            AR3FeedbackPub.publish(&AR3FeedbackData);
            t_old = t;
        }
    }
    
    // Update subscribers
    nh.spinOnce();
}


float edgeAngle(float angle1, float angle2){
    float vertex0[2] = {0.0,0.0};
    float vertex1[2];
    float vertex2[2];
    vertex1[0] = cos(angle1);
    vertex1[1] = sin(angle1);
    vertex2[0] = cos(angle2);
    vertex2[1] = sin(angle2);

    float cosine_theta = vertex1[0]*vertex2[0] + vertex1[1]*vertex2[1];
    float sine_theta = vertex1[0]*vertex2[1]- vertex1[1]*vertex2[0];
    float edge_angle = atan2(sine_theta,cosine_theta);
    return edge_angle;
}
