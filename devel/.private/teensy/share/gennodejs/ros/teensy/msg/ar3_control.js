// Auto-generated. Do not edit!

// (in-package teensy.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ar3_control {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.home = null;
      this.run = null;
      this.rest = null;
      this.gripper_angle = null;
      this.speed = null;
      this.joint_angles = null;
    }
    else {
      if (initObj.hasOwnProperty('home')) {
        this.home = initObj.home
      }
      else {
        this.home = 0;
      }
      if (initObj.hasOwnProperty('run')) {
        this.run = initObj.run
      }
      else {
        this.run = 0;
      }
      if (initObj.hasOwnProperty('rest')) {
        this.rest = initObj.rest
      }
      else {
        this.rest = 0;
      }
      if (initObj.hasOwnProperty('gripper_angle')) {
        this.gripper_angle = initObj.gripper_angle
      }
      else {
        this.gripper_angle = 0;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('joint_angles')) {
        this.joint_angles = initObj.joint_angles
      }
      else {
        this.joint_angles = new Array(6).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ar3_control
    // Serialize message field [home]
    bufferOffset = _serializer.int8(obj.home, buffer, bufferOffset);
    // Serialize message field [run]
    bufferOffset = _serializer.int8(obj.run, buffer, bufferOffset);
    // Serialize message field [rest]
    bufferOffset = _serializer.int8(obj.rest, buffer, bufferOffset);
    // Serialize message field [gripper_angle]
    bufferOffset = _serializer.int8(obj.gripper_angle, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.float64(obj.speed, buffer, bufferOffset);
    // Check that the constant length array field [joint_angles] has the right length
    if (obj.joint_angles.length !== 6) {
      throw new Error('Unable to serialize array field joint_angles - length must be 6')
    }
    // Serialize message field [joint_angles]
    bufferOffset = _arraySerializer.float64(obj.joint_angles, buffer, bufferOffset, 6);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ar3_control
    let len;
    let data = new ar3_control(null);
    // Deserialize message field [home]
    data.home = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [run]
    data.run = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [rest]
    data.rest = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [gripper_angle]
    data.gripper_angle = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [joint_angles]
    data.joint_angles = _arrayDeserializer.float64(buffer, bufferOffset, 6)
    return data;
  }

  static getMessageSize(object) {
    return 60;
  }

  static datatype() {
    // Returns string type for a message object
    return 'teensy/ar3_control';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '208a9b5e1d8eccf1fe39655639adaa71';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int8 home
    int8 run
    int8 rest
    
    int8 gripper_angle
    float64 speed
    
    float64[6] joint_angles
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ar3_control(null);
    if (msg.home !== undefined) {
      resolved.home = msg.home;
    }
    else {
      resolved.home = 0
    }

    if (msg.run !== undefined) {
      resolved.run = msg.run;
    }
    else {
      resolved.run = 0
    }

    if (msg.rest !== undefined) {
      resolved.rest = msg.rest;
    }
    else {
      resolved.rest = 0
    }

    if (msg.gripper_angle !== undefined) {
      resolved.gripper_angle = msg.gripper_angle;
    }
    else {
      resolved.gripper_angle = 0
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.joint_angles !== undefined) {
      resolved.joint_angles = msg.joint_angles;
    }
    else {
      resolved.joint_angles = new Array(6).fill(0)
    }

    return resolved;
    }
};

module.exports = ar3_control;
