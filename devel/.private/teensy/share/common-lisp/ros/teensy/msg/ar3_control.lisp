; Auto-generated. Do not edit!


(cl:in-package teensy-msg)


;//! \htmlinclude ar3_control.msg.html

(cl:defclass <ar3_control> (roslisp-msg-protocol:ros-message)
  ((home
    :reader home
    :initarg :home
    :type cl:fixnum
    :initform 0)
   (run
    :reader run
    :initarg :run
    :type cl:fixnum
    :initform 0)
   (rest
    :reader rest
    :initarg :rest
    :type cl:fixnum
    :initform 0)
   (gripper_angle
    :reader gripper_angle
    :initarg :gripper_angle
    :type cl:fixnum
    :initform 0)
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0)
   (joint_angles
    :reader joint_angles
    :initarg :joint_angles
    :type (cl:vector cl:float)
   :initform (cl:make-array 6 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass ar3_control (<ar3_control>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ar3_control>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ar3_control)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name teensy-msg:<ar3_control> is deprecated: use teensy-msg:ar3_control instead.")))

(cl:ensure-generic-function 'home-val :lambda-list '(m))
(cl:defmethod home-val ((m <ar3_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:home-val is deprecated.  Use teensy-msg:home instead.")
  (home m))

(cl:ensure-generic-function 'run-val :lambda-list '(m))
(cl:defmethod run-val ((m <ar3_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:run-val is deprecated.  Use teensy-msg:run instead.")
  (run m))

(cl:ensure-generic-function 'rest-val :lambda-list '(m))
(cl:defmethod rest-val ((m <ar3_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:rest-val is deprecated.  Use teensy-msg:rest instead.")
  (rest m))

(cl:ensure-generic-function 'gripper_angle-val :lambda-list '(m))
(cl:defmethod gripper_angle-val ((m <ar3_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:gripper_angle-val is deprecated.  Use teensy-msg:gripper_angle instead.")
  (gripper_angle m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <ar3_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:speed-val is deprecated.  Use teensy-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'joint_angles-val :lambda-list '(m))
(cl:defmethod joint_angles-val ((m <ar3_control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:joint_angles-val is deprecated.  Use teensy-msg:joint_angles instead.")
  (joint_angles m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ar3_control>) ostream)
  "Serializes a message object of type '<ar3_control>"
  (cl:let* ((signed (cl:slot-value msg 'home)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'run)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'rest)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'gripper_angle)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ar3_control>) istream)
  "Deserializes a message object of type '<ar3_control>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'home) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'run) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'rest) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gripper_angle) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-double-float-bits bits)))
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ar3_control>)))
  "Returns string type for a message object of type '<ar3_control>"
  "teensy/ar3_control")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ar3_control)))
  "Returns string type for a message object of type 'ar3_control"
  "teensy/ar3_control")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ar3_control>)))
  "Returns md5sum for a message object of type '<ar3_control>"
  "208a9b5e1d8eccf1fe39655639adaa71")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ar3_control)))
  "Returns md5sum for a message object of type 'ar3_control"
  "208a9b5e1d8eccf1fe39655639adaa71")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ar3_control>)))
  "Returns full string definition for message of type '<ar3_control>"
  (cl:format cl:nil "int8 home~%int8 run~%int8 rest~%~%int8 gripper_angle~%float64 speed~%~%float64[6] joint_angles~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ar3_control)))
  "Returns full string definition for message of type 'ar3_control"
  (cl:format cl:nil "int8 home~%int8 run~%int8 rest~%~%int8 gripper_angle~%float64 speed~%~%float64[6] joint_angles~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ar3_control>))
  (cl:+ 0
     1
     1
     1
     1
     8
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'joint_angles) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ar3_control>))
  "Converts a ROS message object to a list"
  (cl:list 'ar3_control
    (cl:cons ':home (home msg))
    (cl:cons ':run (run msg))
    (cl:cons ':rest (rest msg))
    (cl:cons ':gripper_angle (gripper_angle msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':joint_angles (joint_angles msg))
))
