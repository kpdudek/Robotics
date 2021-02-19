// Generated by gencpp from file ar3/ar3_control.msg
// DO NOT EDIT!


#ifndef AR3_MESSAGE_AR3_CONTROL_H
#define AR3_MESSAGE_AR3_CONTROL_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace ar3
{
template <class ContainerAllocator>
struct ar3_control_
{
  typedef ar3_control_<ContainerAllocator> Type;

  ar3_control_()
    : home(0)
    , run(0)
    , rest(0)
    , gripper_angle(0)
    , speed(0.0)
    , joint_angles()  {
      joint_angles.assign(0.0);
  }
  ar3_control_(const ContainerAllocator& _alloc)
    : home(0)
    , run(0)
    , rest(0)
    , gripper_angle(0)
    , speed(0.0)
    , joint_angles()  {
  (void)_alloc;
      joint_angles.assign(0.0);
  }



   typedef int8_t _home_type;
  _home_type home;

   typedef int8_t _run_type;
  _run_type run;

   typedef int8_t _rest_type;
  _rest_type rest;

   typedef int8_t _gripper_angle_type;
  _gripper_angle_type gripper_angle;

   typedef double _speed_type;
  _speed_type speed;

   typedef boost::array<double, 6>  _joint_angles_type;
  _joint_angles_type joint_angles;





  typedef boost::shared_ptr< ::ar3::ar3_control_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::ar3::ar3_control_<ContainerAllocator> const> ConstPtr;

}; // struct ar3_control_

typedef ::ar3::ar3_control_<std::allocator<void> > ar3_control;

typedef boost::shared_ptr< ::ar3::ar3_control > ar3_controlPtr;
typedef boost::shared_ptr< ::ar3::ar3_control const> ar3_controlConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::ar3::ar3_control_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::ar3::ar3_control_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::ar3::ar3_control_<ContainerAllocator1> & lhs, const ::ar3::ar3_control_<ContainerAllocator2> & rhs)
{
  return lhs.home == rhs.home &&
    lhs.run == rhs.run &&
    lhs.rest == rhs.rest &&
    lhs.gripper_angle == rhs.gripper_angle &&
    lhs.speed == rhs.speed &&
    lhs.joint_angles == rhs.joint_angles;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::ar3::ar3_control_<ContainerAllocator1> & lhs, const ::ar3::ar3_control_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace ar3

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::ar3::ar3_control_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::ar3::ar3_control_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::ar3::ar3_control_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::ar3::ar3_control_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::ar3::ar3_control_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::ar3::ar3_control_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::ar3::ar3_control_<ContainerAllocator> >
{
  static const char* value()
  {
    return "208a9b5e1d8eccf1fe39655639adaa71";
  }

  static const char* value(const ::ar3::ar3_control_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x208a9b5e1d8eccf1ULL;
  static const uint64_t static_value2 = 0xfe39655639adaa71ULL;
};

template<class ContainerAllocator>
struct DataType< ::ar3::ar3_control_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ar3/ar3_control";
  }

  static const char* value(const ::ar3::ar3_control_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::ar3::ar3_control_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int8 home\n"
"int8 run\n"
"int8 rest\n"
"\n"
"int8 gripper_angle\n"
"float64 speed\n"
"\n"
"float64[6] joint_angles\n"
"\n"
;
  }

  static const char* value(const ::ar3::ar3_control_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::ar3::ar3_control_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.home);
      stream.next(m.run);
      stream.next(m.rest);
      stream.next(m.gripper_angle);
      stream.next(m.speed);
      stream.next(m.joint_angles);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ar3_control_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::ar3::ar3_control_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::ar3::ar3_control_<ContainerAllocator>& v)
  {
    s << indent << "home: ";
    Printer<int8_t>::stream(s, indent + "  ", v.home);
    s << indent << "run: ";
    Printer<int8_t>::stream(s, indent + "  ", v.run);
    s << indent << "rest: ";
    Printer<int8_t>::stream(s, indent + "  ", v.rest);
    s << indent << "gripper_angle: ";
    Printer<int8_t>::stream(s, indent + "  ", v.gripper_angle);
    s << indent << "speed: ";
    Printer<double>::stream(s, indent + "  ", v.speed);
    s << indent << "joint_angles[]" << std::endl;
    for (size_t i = 0; i < v.joint_angles.size(); ++i)
    {
      s << indent << "  joint_angles[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.joint_angles[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // AR3_MESSAGE_AR3_CONTROL_H