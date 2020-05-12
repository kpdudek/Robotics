; Auto-generated. Do not edit!


(cl:in-package ar3-msg)


;//! \htmlinclude ar3_Feedback.msg.html

(cl:defclass <ar3_Feedback> (roslisp-msg-protocol:ros-message)
  ((eStop
    :reader eStop
    :initarg :eStop
    :type cl:fixnum
    :initform 0)
   (homed
    :reader homed
    :initarg :homed
    :type cl:fixnum
    :initform 0)
   (resting
    :reader resting
    :initarg :resting
    :type cl:fixnum
    :initform 0)
   (running
    :reader running
    :initarg :running
    :type cl:fixnum
    :initform 0)
   (gripper_closed
    :reader gripper_closed
    :initarg :gripper_closed
    :type cl:fixnum
    :initform 0)
   (encoder_pulses
    :reader encoder_pulses
    :initarg :encoder_pulses
    :type (cl:vector cl:integer)
   :initform (cl:make-array 6 :element-type 'cl:integer :initial-element 0))
   (joint_angles
    :reader joint_angles
    :initarg :joint_angles
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0))
   (setpoint_angles
    :reader setpoint_angles
    :initarg :setpoint_angles
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass ar3_Feedback (<ar3_Feedback>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ar3_Feedback>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ar3_Feedback)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ar3-msg:<ar3_Feedback> is deprecated: use ar3-msg:ar3_Feedback instead.")))

(cl:ensure-generic-function 'eStop-val :lambda-list '(m))
(cl:defmethod eStop-val ((m <ar3_Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ar3-msg:eStop-val is deprecated.  Use ar3-msg:eStop instead.")
  (eStop m))

(cl:ensure-generic-function 'homed-val :lambda-list '(m))
(cl:defmethod homed-val ((m <ar3_Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ar3-msg:homed-val is deprecated.  Use ar3-msg:homed instead.")
  (homed m))

(cl:ensure-generic-function 'resting-val :lambda-list '(m))
(cl:defmethod resting-val ((m <ar3_Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ar3-msg:resting-val is deprecated.  Use ar3-msg:resting instead.")
  (resting m))

(cl:ensure-generic-function 'running-val :lambda-list '(m))
(cl:defmethod running-val ((m <ar3_Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ar3-msg:running-val is deprecated.  Use ar3-msg:running instead.")
  (running m))

(cl:ensure-generic-function 'gripper_closed-val :lambda-list '(m))
(cl:defmethod gripper_closed-val ((m <ar3_Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ar3-msg:gripper_closed-val is deprecated.  Use ar3-msg:gripper_closed instead.")
  (gripper_closed m))

(cl:ensure-generic-function 'encoder_pulses-val :lambda-list '(m))
(cl:defmethod encoder_pulses-val ((m <ar3_Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ar3-msg:encoder_pulses-val is deprecated.  Use ar3-msg:encoder_pulses instead.")
  (encoder_pulses m))

(cl:ensure-generic-function 'joint_angles-val :lambda-list '(m))
(cl:defmethod joint_angles-val ((m <ar3_Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ar3-msg:joint_angles-val is deprecated.  Use ar3-msg:joint_angles instead.")
  (joint_angles m))

(cl:ensure-generic-function 'setpoint_angles-val :lambda-list '(m))
(cl:defmethod setpoint_angles-val ((m <ar3_Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ar3-msg:setpoint_angles-val is deprecated.  Use ar3-msg:setpoint_angles instead.")
  (setpoint_angles m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ar3_Feedback>) ostream)
  "Serializes a message object of type '<ar3_Feedback>"
  (cl:let* ((signed (cl:slot-value msg 'eStop)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'homed)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'resting)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'running)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'gripper_closed)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    ))
   (cl:slot-value msg 'encoder_pulses))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'joint_angles))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'setpoint_angles))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ar3_Feedback>) istream)
  "Deserializes a message object of type '<ar3_Feedback>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'eStop) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'homed) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'resting) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'running) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gripper_closed) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  (cl:setf (cl:slot-value msg 'encoder_pulses) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'encoder_pulses)))
    (cl:dotimes (i 6)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))))
  (cl:setf (cl:slot-value msg 'joint_angles) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'joint_angles)))
    (cl:dotimes (i 6)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'setpoint_angles) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'setpoint_angles)))
    (cl:dotimes (i 6)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ar3_Feedback>)))
  "Returns string type for a message object of type '<ar3_Feedback>"
  "ar3/ar3_Feedback")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ar3_Feedback)))
  "Returns string type for a message object of type 'ar3_Feedback"
  "ar3/ar3_Feedback")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ar3_Feedback>)))
  "Returns md5sum for a message object of type '<ar3_Feedback>"
  "89d9497c396e2b4e5491efb4741ef6f1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ar3_Feedback)))
  "Returns md5sum for a message object of type 'ar3_Feedback"
  "89d9497c396e2b4e5491efb4741ef6f1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ar3_Feedback>)))
  "Returns full string definition for message of type '<ar3_Feedback>"
  (cl:format cl:nil "int8 eStop~%int8 homed~%int8 resting~%int8 running~%int8 gripper_closed~%~%int64[6] encoder_pulses~%float64[6] joint_angles~%float64[6] setpoint_angles~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ar3_Feedback)))
  "Returns full string definition for message of type 'ar3_Feedback"
  (cl:format cl:nil "int8 eStop~%int8 homed~%int8 resting~%int8 running~%int8 gripper_closed~%~%int64[6] encoder_pulses~%float64[6] joint_angles~%float64[6] setpoint_angles~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ar3_Feedback>))
  (cl:+ 0
     1
     1
     1
     1
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'encoder_pulses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'joint_angles) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'setpoint_angles) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ar3_Feedback>))
  "Converts a ROS message object to a list"
  (cl:list 'ar3_Feedback
    (cl:cons ':eStop (eStop msg))
    (cl:cons ':homed (homed msg))
    (cl:cons ':resting (resting msg))
    (cl:cons ':running (running msg))
    (cl:cons ':gripper_closed (gripper_closed msg))
    (cl:cons ':encoder_pulses (encoder_pulses msg))
    (cl:cons ':joint_angles (joint_angles msg))
    (cl:cons ':setpoint_angles (setpoint_angles msg))
))
