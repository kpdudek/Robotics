#ifndef _ROS_ar3_ar3_control_h
#define _ROS_ar3_ar3_control_h

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "ros/msg.h"

namespace ar3
{

  class ar3_control : public ros::Msg
  {
    public:
      typedef int8_t _home_type;
      _home_type home;
      typedef int8_t _run_type;
      _run_type run;
      typedef int8_t _rest_type;
      _rest_type rest;
      typedef int16_t _gripper_angle_type;
      _gripper_angle_type gripper_angle;
      typedef float _speed_type;
      _speed_type speed;
      float joint_angles[6];

    ar3_control():
      home(0),
      run(0),
      rest(0),
      gripper_angle(0),
      speed(0),
      joint_angles()
    {
    }

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      union {
        int8_t real;
        uint8_t base;
      } u_home;
      u_home.real = this->home;
      *(outbuffer + offset + 0) = (u_home.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->home);
      union {
        int8_t real;
        uint8_t base;
      } u_run;
      u_run.real = this->run;
      *(outbuffer + offset + 0) = (u_run.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->run);
      union {
        int8_t real;
        uint8_t base;
      } u_rest;
      u_rest.real = this->rest;
      *(outbuffer + offset + 0) = (u_rest.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->rest);
      union {
        int16_t real;
        uint16_t base;
      } u_gripper_angle;
      u_gripper_angle.real = this->gripper_angle;
      *(outbuffer + offset + 0) = (u_gripper_angle.base >> (8 * 0)) & 0xFF;
      *(outbuffer + offset + 1) = (u_gripper_angle.base >> (8 * 1)) & 0xFF;
      offset += sizeof(this->gripper_angle);
      offset += serializeAvrFloat64(outbuffer + offset, this->speed);
      for( uint32_t i = 0; i < 6; i++){
      offset += serializeAvrFloat64(outbuffer + offset, this->joint_angles[i]);
      }
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      union {
        int8_t real;
        uint8_t base;
      } u_home;
      u_home.base = 0;
      u_home.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->home = u_home.real;
      offset += sizeof(this->home);
      union {
        int8_t real;
        uint8_t base;
      } u_run;
      u_run.base = 0;
      u_run.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->run = u_run.real;
      offset += sizeof(this->run);
      union {
        int8_t real;
        uint8_t base;
      } u_rest;
      u_rest.base = 0;
      u_rest.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->rest = u_rest.real;
      offset += sizeof(this->rest);
      union {
        int16_t real;
        uint16_t base;
      } u_gripper_angle;
      u_gripper_angle.base = 0;
      u_gripper_angle.base |= ((uint16_t) (*(inbuffer + offset + 0))) << (8 * 0);
      u_gripper_angle.base |= ((uint16_t) (*(inbuffer + offset + 1))) << (8 * 1);
      this->gripper_angle = u_gripper_angle.real;
      offset += sizeof(this->gripper_angle);
      offset += deserializeAvrFloat64(inbuffer + offset, &(this->speed));
      for( uint32_t i = 0; i < 6; i++){
      offset += deserializeAvrFloat64(inbuffer + offset, &(this->joint_angles[i]));
      }
     return offset;
    }

    const char * getType(){ return "ar3/ar3_control"; };
    const char * getMD5(){ return "95cd580f727231397863d637f25bba03"; };

  };

}
#endif
