// Auto-generated. Do not edit!

// (in-package ar3.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ar3_Feedback {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.eStop = null;
      this.homed = null;
      this.resting = null;
      this.running = null;
      this.gripper_closed = null;
      this.encoder_pulses = null;
      this.joint_angles = null;
      this.setpoint_angles = null;
    }
    else {
      if (initObj.hasOwnProperty('eStop')) {
        this.eStop = initObj.eStop
      }
      else {
        this.eStop = 0;
      }
      if (initObj.hasOwnProperty('homed')) {
        this.homed = initObj.homed
      }
      else {
        this.homed = 0;
      }
      if (initObj.hasOwnProperty('resting')) {
        this.resting = initObj.resting
      }
      else {
        this.resting = 0;
      }
      if (initObj.hasOwnProperty('running')) {
        this.running = initObj.running
      }
      else {
        this.running = 0;
      }
      if (initObj.hasOwnProperty('gripper_closed')) {
        this.gripper_closed = initObj.gripper_closed
      }
      else {
        this.gripper_closed = 0;
      }
      if (initObj.hasOwnProperty('encoder_pulses')) {
        this.encoder_pulses = initObj.encoder_pulses
      }
      else {
        this.encoder_pulses = new Array(6).fill(0);
      }
      if (initObj.hasOwnProperty('joint_angles')) {
        this.joint_angles = initObj.joint_angles
      }
      else {
        this.joint_angles = new Array(6).fill(0);
      }
      if (initObj.hasOwnProperty('setpoint_angles')) {
        this.setpoint_angles = initObj.setpoint_angles
      }
      else {
        this.setpoint_angles = new Array(6).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ar3_Feedback
    // Serialize message field [eStop]
    bufferOffset = _serializer.int8(obj.eStop, buffer, bufferOffset);
    // Serialize message field [homed]
    bufferOffset = _serializer.int8(obj.homed, buffer, bufferOffset);
    // Serialize message field [resting]
    bufferOffset = _serializer.int8(obj.resting, buffer, bufferOffset);
    // Serialize message field [running]
    bufferOffset = _serializer.int8(obj.running, buffer, bufferOffset);
    // Serialize message field [gripper_closed]
    bufferOffset = _serializer.int8(obj.gripper_closed, buffer, bufferOffset);
    // Check that the constant length array field [encoder_pulses] has the right length
    if (obj.encoder_pulses.length !== 6) {
      throw new Error('Unable to serialize array field encoder_pulses - length must be 6')
    }
    // Serialize message field [encoder_pulses]
    bufferOffset = _arraySerializer.int64(obj.encoder_pulses, buffer, bufferOffset, 6);
    // Check that the constant length array field [joint_angles] has the right length
    if (obj.joint_angles.length !== 6) {
      throw new Error('Unable to serialize array field joint_angles - length must be 6')
    }
    // Serialize message field [joint_angles]
    bufferOffset = _arraySerializer.float64(obj.joint_angles, buffer, bufferOffset, 6);
    // Check that the constant length array field [setpoint_angles] has the right length
    if (obj.setpoint_angles.length !== 6) {
      throw new Error('Unable to serialize array field setpoint_angles - length must be 6')
    }
    // Serialize message field [setpoint_angles]
    bufferOffset = _arraySerializer.float64(obj.setpoint_angles, buffer, bufferOffset, 6);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ar3_Feedback
    let len;
    let data = new ar3_Feedback(null);
    // Deserialize message field [eStop]
    data.eStop = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [homed]
    data.homed = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [resting]
    data.resting = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [running]
    data.running = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [gripper_closed]
    data.gripper_closed = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [encoder_pulses]
    data.encoder_pulses = _arrayDeserializer.int64(buffer, bufferOffset, 6)
    // Deserialize message field [joint_angles]
    data.joint_angles = _arrayDeserializer.float64(buffer, bufferOffset, 6)
    // Deserialize message field [setpoint_angles]
    data.setpoint_angles = _arrayDeserializer.float64(buffer, bufferOffset, 6)
    return data;
  }

  static getMessageSize(object) {
    return 149;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ar3/ar3_Feedback';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '89d9497c396e2b4e5491efb4741ef6f1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int8 eStop
    int8 homed
    int8 resting
    int8 running
    int8 gripper_closed
    
    int64[6] encoder_pulses
    float64[6] joint_angles
    float64[6] setpoint_angles
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ar3_Feedback(null);
    if (msg.eStop !== undefined) {
      resolved.eStop = msg.eStop;
    }
    else {
      resolved.eStop = 0
    }

    if (msg.homed !== undefined) {
      resolved.homed = msg.homed;
    }
    else {
      resolved.homed = 0
    }

    if (msg.resting !== undefined) {
      resolved.resting = msg.resting;
    }
    else {
      resolved.resting = 0
    }

    if (msg.running !== undefined) {
      resolved.running = msg.running;
    }
    else {
      resolved.running = 0
    }

    if (msg.gripper_closed !== undefined) {
      resolved.gripper_closed = msg.gripper_closed;
    }
    else {
      resolved.gripper_closed = 0
    }

    if (msg.encoder_pulses !== undefined) {
      resolved.encoder_pulses = msg.encoder_pulses;
    }
    else {
      resolved.encoder_pulses = new Array(6).fill(0)
    }

    if (msg.joint_angles !== undefined) {
      resolved.joint_angles = msg.joint_angles;
    }
    else {
      resolved.joint_angles = new Array(6).fill(0)
    }

    if (msg.setpoint_angles !== undefined) {
      resolved.setpoint_angles = msg.setpoint_angles;
    }
    else {
      resolved.setpoint_angles = new Array(6).fill(0)
    }

    return resolved;
    }
};

module.exports = ar3_Feedback;
