; Auto-generated. Do not edit!


(cl:in-package teensy-msg)


;//! \htmlinclude teensy_angles.msg.html

(cl:defclass <teensy_angles> (roslisp-msg-protocol:ros-message)
  ((j1_angle
    :reader j1_angle
    :initarg :j1_angle
    :type cl:float
    :initform 0.0)
   (j2_angle
    :reader j2_angle
    :initarg :j2_angle
    :type cl:float
    :initform 0.0)
   (j3_angle
    :reader j3_angle
    :initarg :j3_angle
    :type cl:float
    :initform 0.0)
   (j4_angle
    :reader j4_angle
    :initarg :j4_angle
    :type cl:float
    :initform 0.0)
   (j5_angle
    :reader j5_angle
    :initarg :j5_angle
    :type cl:float
    :initform 0.0)
   (j6_angle
    :reader j6_angle
    :initarg :j6_angle
    :type cl:float
    :initform 0.0))
)

(cl:defclass teensy_angles (<teensy_angles>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <teensy_angles>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'teensy_angles)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name teensy-msg:<teensy_angles> is deprecated: use teensy-msg:teensy_angles instead.")))

(cl:ensure-generic-function 'j1_angle-val :lambda-list '(m))
(cl:defmethod j1_angle-val ((m <teensy_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:j1_angle-val is deprecated.  Use teensy-msg:j1_angle instead.")
  (j1_angle m))

(cl:ensure-generic-function 'j2_angle-val :lambda-list '(m))
(cl:defmethod j2_angle-val ((m <teensy_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:j2_angle-val is deprecated.  Use teensy-msg:j2_angle instead.")
  (j2_angle m))

(cl:ensure-generic-function 'j3_angle-val :lambda-list '(m))
(cl:defmethod j3_angle-val ((m <teensy_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:j3_angle-val is deprecated.  Use teensy-msg:j3_angle instead.")
  (j3_angle m))

(cl:ensure-generic-function 'j4_angle-val :lambda-list '(m))
(cl:defmethod j4_angle-val ((m <teensy_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:j4_angle-val is deprecated.  Use teensy-msg:j4_angle instead.")
  (j4_angle m))

(cl:ensure-generic-function 'j5_angle-val :lambda-list '(m))
(cl:defmethod j5_angle-val ((m <teensy_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:j5_angle-val is deprecated.  Use teensy-msg:j5_angle instead.")
  (j5_angle m))

(cl:ensure-generic-function 'j6_angle-val :lambda-list '(m))
(cl:defmethod j6_angle-val ((m <teensy_angles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:j6_angle-val is deprecated.  Use teensy-msg:j6_angle instead.")
  (j6_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <teensy_angles>) ostream)
  "Serializes a message object of type '<teensy_angles>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'j1_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'j2_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'j3_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'j4_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'j5_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'j6_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <teensy_angles>) istream)
  "Deserializes a message object of type '<teensy_angles>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j1_angle) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j2_angle) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j3_angle) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j4_angle) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j5_angle) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'j6_angle) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<teensy_angles>)))
  "Returns string type for a message object of type '<teensy_angles>"
  "teensy/teensy_angles")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'teensy_angles)))
  "Returns string type for a message object of type 'teensy_angles"
  "teensy/teensy_angles")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<teensy_angles>)))
  "Returns md5sum for a message object of type '<teensy_angles>"
  "ff3325ea44ea22847dec9013538e06aa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'teensy_angles)))
  "Returns md5sum for a message object of type 'teensy_angles"
  "ff3325ea44ea22847dec9013538e06aa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<teensy_angles>)))
  "Returns full string definition for message of type '<teensy_angles>"
  (cl:format cl:nil "float64 j1_angle~%float64 j2_angle~%float64 j3_angle~%float64 j4_angle~%float64 j5_angle~%float64 j6_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'teensy_angles)))
  "Returns full string definition for message of type 'teensy_angles"
  (cl:format cl:nil "float64 j1_angle~%float64 j2_angle~%float64 j3_angle~%float64 j4_angle~%float64 j5_angle~%float64 j6_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <teensy_angles>))
  (cl:+ 0
     8
     8
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <teensy_angles>))
  "Converts a ROS message object to a list"
  (cl:list 'teensy_angles
    (cl:cons ':j1_angle (j1_angle msg))
    (cl:cons ':j2_angle (j2_angle msg))
    (cl:cons ':j3_angle (j3_angle msg))
    (cl:cons ':j4_angle (j4_angle msg))
    (cl:cons ':j5_angle (j5_angle msg))
    (cl:cons ':j6_angle (j6_angle msg))
))
