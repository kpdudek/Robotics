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

class teensy_angles {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.j1_angle = null;
      this.j2_angle = null;
      this.j3_angle = null;
      this.j4_angle = null;
      this.j5_angle = null;
      this.j6_angle = null;
    }
    else {
      if (initObj.hasOwnProperty('j1_angle')) {
        this.j1_angle = initObj.j1_angle
      }
      else {
        this.j1_angle = 0.0;
      }
      if (initObj.hasOwnProperty('j2_angle')) {
        this.j2_angle = initObj.j2_angle
      }
      else {
        this.j2_angle = 0.0;
      }
      if (initObj.hasOwnProperty('j3_angle')) {
        this.j3_angle = initObj.j3_angle
      }
      else {
        this.j3_angle = 0.0;
      }
      if (initObj.hasOwnProperty('j4_angle')) {
        this.j4_angle = initObj.j4_angle
      }
      else {
        this.j4_angle = 0.0;
      }
      if (initObj.hasOwnProperty('j5_angle')) {
        this.j5_angle = initObj.j5_angle
      }
      else {
        this.j5_angle = 0.0;
      }
      if (initObj.hasOwnProperty('j6_angle')) {
        this.j6_angle = initObj.j6_angle
      }
      else {
        this.j6_angle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type teensy_angles
    // Serialize message field [j1_angle]
    bufferOffset = _serializer.float64(obj.j1_angle, buffer, bufferOffset);
    // Serialize message field [j2_angle]
    bufferOffset = _serializer.float64(obj.j2_angle, buffer, bufferOffset);
    // Serialize message field [j3_angle]
    bufferOffset = _serializer.float64(obj.j3_angle, buffer, bufferOffset);
    // Serialize message field [j4_angle]
    bufferOffset = _serializer.float64(obj.j4_angle, buffer, bufferOffset);
    // Serialize message field [j5_angle]
    bufferOffset = _serializer.float64(obj.j5_angle, buffer, bufferOffset);
    // Serialize message field [j6_angle]
    bufferOffset = _serializer.float64(obj.j6_angle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type teensy_angles
    let len;
    let data = new teensy_angles(null);
    // Deserialize message field [j1_angle]
    data.j1_angle = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [j2_angle]
    data.j2_angle = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [j3_angle]
    data.j3_angle = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [j4_angle]
    data.j4_angle = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [j5_angle]
    data.j5_angle = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [j6_angle]
    data.j6_angle = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 48;
  }

  static datatype() {
    // Returns string type for a message object
    return 'teensy/teensy_angles';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ff3325ea44ea22847dec9013538e06aa';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 j1_angle
    float64 j2_angle
    float64 j3_angle
    float64 j4_angle
    float64 j5_angle
    float64 j6_angle
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new teensy_angles(null);
    if (msg.j1_angle !== undefined) {
      resolved.j1_angle = msg.j1_angle;
    }
    else {
      resolved.j1_angle = 0.0
    }

    if (msg.j2_angle !== undefined) {
      resolved.j2_angle = msg.j2_angle;
    }
    else {
      resolved.j2_angle = 0.0
    }

    if (msg.j3_angle !== undefined) {
      resolved.j3_angle = msg.j3_angle;
    }
    else {
      resolved.j3_angle = 0.0
    }

    if (msg.j4_angle !== undefined) {
      resolved.j4_angle = msg.j4_angle;
    }
    else {
      resolved.j4_angle = 0.0
    }

    if (msg.j5_angle !== undefined) {
      resolved.j5_angle = msg.j5_angle;
    }
    else {
      resolved.j5_angle = 0.0
    }

    if (msg.j6_angle !== undefined) {
      resolved.j6_angle = msg.j6_angle;
    }
    else {
      resolved.j6_angle = 0.0
    }

    return resolved;
    }
};

module.exports = teensy_angles;
