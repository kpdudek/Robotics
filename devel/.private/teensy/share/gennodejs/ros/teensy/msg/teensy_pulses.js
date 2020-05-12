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

class teensy_pulses {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pulses = null;
    }
    else {
      if (initObj.hasOwnProperty('pulses')) {
        this.pulses = initObj.pulses
      }
      else {
        this.pulses = new Array(6).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type teensy_pulses
    // Check that the constant length array field [pulses] has the right length
    if (obj.pulses.length !== 6) {
      throw new Error('Unable to serialize array field pulses - length must be 6')
    }
    // Serialize message field [pulses]
    bufferOffset = _arraySerializer.int16(obj.pulses, buffer, bufferOffset, 6);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type teensy_pulses
    let len;
    let data = new teensy_pulses(null);
    // Deserialize message field [pulses]
    data.pulses = _arrayDeserializer.int16(buffer, bufferOffset, 6)
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'teensy/teensy_pulses';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fb3b288c417a05835e02e94aae5e2865';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int16[6] pulses
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new teensy_pulses(null);
    if (msg.pulses !== undefined) {
      resolved.pulses = msg.pulses;
    }
    else {
      resolved.pulses = new Array(6).fill(0)
    }

    return resolved;
    }
};

module.exports = teensy_pulses;
