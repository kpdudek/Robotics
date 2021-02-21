#ifndef _ROS_ar3_ar3_feedback_h
#define _ROS_ar3_ar3_feedback_h

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "ros/msg.h"

namespace ar3
{

  class ar3_feedback : public ros::Msg
  {
    public:
      typedef int8_t _eStop_type;
      _eStop_type eStop;
      typedef int8_t _homed_type;
      _homed_type homed;
      typedef int8_t _resting_type;
      _resting_type resting;
      typedef int8_t _running_type;
      _running_type running;
      typedef int8_t _gripper_angle_type;
      _gripper_angle_type gripper_angle;
      int64_t encoder_pulses[6];
      float joint_angles[6];
      float setpoint_angles[6];

    ar3_feedback():
      eStop(0),
      homed(0),
      resting(0),
      running(0),
      gripper_angle(0),
      encoder_pulses(),
      joint_angles(),
      setpoint_angles()
    {
    }

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      union {
        int8_t real;
        uint8_t base;
      } u_eStop;
      u_eStop.real = this->eStop;
      *(outbuffer + offset + 0) = (u_eStop.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->eStop);
      union {
        int8_t real;
        uint8_t base;
      } u_homed;
      u_homed.real = this->homed;
      *(outbuffer + offset + 0) = (u_homed.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->homed);
      union {
        int8_t real;
        uint8_t base;
      } u_resting;
      u_resting.real = this->resting;
      *(outbuffer + offset + 0) = (u_resting.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->resting);
      union {
        int8_t real;
        uint8_t base;
      } u_running;
      u_running.real = this->running;
      *(outbuffer + offset + 0) = (u_running.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->running);
      union {
        int8_t real;
        uint8_t base;
      } u_gripper_angle;
      u_gripper_angle.real = this->gripper_angle;
      *(outbuffer + offset + 0) = (u_gripper_angle.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->gripper_angle);
      for( uint32_t i = 0; i < 6; i++){
      union {
        int64_t real;
        uint64_t base;
      } u_encoder_pulsesi;
      u_encoder_pulsesi.real = this->encoder_pulses[i];
      *(outbuffer + offset + 0) = (u_encoder_pulsesi.base >> (8 * 0)) & 0xFF;
      *(outbuffer + offset + 1) = (u_encoder_pulsesi.base >> (8 * 1)) & 0xFF;
      *(outbuffer + offset + 2) = (u_encoder_pulsesi.base >> (8 * 2)) & 0xFF;
      *(outbuffer + offset + 3) = (u_encoder_pulsesi.base >> (8 * 3)) & 0xFF;
      *(outbuffer + offset + 4) = (u_encoder_pulsesi.base >> (8 * 4)) & 0xFF;
      *(outbuffer + offset + 5) = (u_encoder_pulsesi.base >> (8 * 5)) & 0xFF;
      *(outbuffer + offset + 6) = (u_encoder_pulsesi.base >> (8 * 6)) & 0xFF;
      *(outbuffer + offset + 7) = (u_encoder_pulsesi.base >> (8 * 7)) & 0xFF;
      offset += sizeof(this->encoder_pulses[i]);
      }
      for( uint32_t i = 0; i < 6; i++){
      offset += serializeAvrFloat64(outbuffer + offset, this->joint_angles[i]);
      }
      for( uint32_t i = 0; i < 6; i++){
      offset += serializeAvrFloat64(outbuffer + offset, this->setpoint_angles[i]);
      }
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      union {
        int8_t real;
        uint8_t base;
      } u_eStop;
      u_eStop.base = 0;
      u_eStop.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->eStop = u_eStop.real;
      offset += sizeof(this->eStop);
      union {
        int8_t real;
        uint8_t base;
      } u_homed;
      u_homed.base = 0;
      u_homed.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->homed = u_homed.real;
      offset += sizeof(this->homed);
      union {
        int8_t real;
        uint8_t base;
      } u_resting;
      u_resting.base = 0;
      u_resting.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->resting = u_resting.real;
      offset += sizeof(this->resting);
      union {
        int8_t real;
        uint8_t base;
      } u_running;
      u_running.base = 0;
      u_running.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->running = u_running.real;
      offset += sizeof(this->running);
      union {
        int8_t real;
        uint8_t base;
      } u_gripper_angle;
      u_gripper_angle.base = 0;
      u_gripper_angle.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->gripper_angle = u_gripper_angle.real;
      offset += sizeof(this->gripper_angle);
      for( uint32_t i = 0; i < 6; i++){
      union {
        int64_t real;
        uint64_t base;
      } u_encoder_pulsesi;
      u_encoder_pulsesi.base = 0;
      u_encoder_pulsesi.base |= ((uint64_t) (*(inbuffer + offset + 0))) << (8 * 0);
      u_encoder_pulsesi.base |= ((uint64_t) (*(inbuffer + offset + 1))) << (8 * 1);
      u_encoder_pulsesi.base |= ((uint64_t) (*(inbuffer + offset + 2))) << (8 * 2);
      u_encoder_pulsesi.base |= ((uint64_t) (*(inbuffer + offset + 3))) << (8 * 3);
      u_encoder_pulsesi.base |= ((uint64_t) (*(inbuffer + offset + 4))) << (8 * 4);
      u_encoder_pulsesi.base |= ((uint64_t) (*(inbuffer + offset + 5))) << (8 * 5);
      u_encoder_pulsesi.base |= ((uint64_t) (*(inbuffer + offset + 6))) << (8 * 6);
      u_encoder_pulsesi.base |= ((uint64_t) (*(inbuffer + offset + 7))) << (8 * 7);
      this->encoder_pulses[i] = u_encoder_pulsesi.real;
      offset += sizeof(this->encoder_pulses[i]);
      }
      for( uint32_t i = 0; i < 6; i++){
      offset += deserializeAvrFloat64(inbuffer + offset, &(this->joint_angles[i]));
      }
      for( uint32_t i = 0; i < 6; i++){
      offset += deserializeAvrFloat64(inbuffer + offset, &(this->setpoint_angles[i]));
      }
     return offset;
    }

    const char * getType(){ return "ar3/ar3_feedback"; };
    const char * getMD5(){ return "64163ea4ea47214d9da1c0355fe48ee5"; };

  };

}
#endif
