; Auto-generated. Do not edit!


(cl:in-package teensy-msg)


;//! \htmlinclude teensy_pulses.msg.html

(cl:defclass <teensy_pulses> (roslisp-msg-protocol:ros-message)
  ((pulses
    :reader pulses
    :initarg :pulses
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 6 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass teensy_pulses (<teensy_pulses>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <teensy_pulses>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'teensy_pulses)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name teensy-msg:<teensy_pulses> is deprecated: use teensy-msg:teensy_pulses instead.")))

(cl:ensure-generic-function 'pulses-val :lambda-list '(m))
(cl:defmethod pulses-val ((m <teensy_pulses>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teensy-msg:pulses-val is deprecated.  Use teensy-msg:pulses instead.")
  (pulses m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <teensy_pulses>) ostream)
  "Serializes a message object of type '<teensy_pulses>"
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    ))
   (cl:slot-value msg 'pulses))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <teensy_pulses>) istream)
  "Deserializes a message object of type '<teensy_pulses>"
  (cl:setf (cl:slot-value msg 'pulses) (cl:make-array 6))
  (cl:let ((vals (cl:slot-value msg 'pulses)))
    (cl:dotimes (i 6)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<teensy_pulses>)))
  "Returns string type for a message object of type '<teensy_pulses>"
  "teensy/teensy_pulses")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'teensy_pulses)))
  "Returns string type for a message object of type 'teensy_pulses"
  "teensy/teensy_pulses")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<teensy_pulses>)))
  "Returns md5sum for a message object of type '<teensy_pulses>"
  "fb3b288c417a05835e02e94aae5e2865")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'teensy_pulses)))
  "Returns md5sum for a message object of type 'teensy_pulses"
  "fb3b288c417a05835e02e94aae5e2865")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<teensy_pulses>)))
  "Returns full string definition for message of type '<teensy_pulses>"
  (cl:format cl:nil "int16[6] pulses~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'teensy_pulses)))
  "Returns full string definition for message of type 'teensy_pulses"
  (cl:format cl:nil "int16[6] pulses~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <teensy_pulses>))
  (cl:+ 0
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'pulses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 2)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <teensy_pulses>))
  "Converts a ROS message object to a list"
  (cl:list 'teensy_pulses
    (cl:cons ':pulses (pulses msg))
))
