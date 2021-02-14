;; Auto-generated. Do not edit!


(when (boundp 'ar3::ar3_feedback)
  (if (not (find-package "AR3"))
    (make-package "AR3"))
  (shadow 'ar3_feedback (find-package "AR3")))
(unless (find-package "AR3::AR3_FEEDBACK")
  (make-package "AR3::AR3_FEEDBACK"))

(in-package "ROS")
;;//! \htmlinclude ar3_feedback.msg.html


(defclass ar3::ar3_feedback
  :super ros::object
  :slots (_eStop _homed _resting _running _gripper_angle _encoder_pulses _joint_angles _setpoint_angles ))

(defmethod ar3::ar3_feedback
  (:init
   (&key
    ((:eStop __eStop) 0)
    ((:homed __homed) 0)
    ((:resting __resting) 0)
    ((:running __running) 0)
    ((:gripper_angle __gripper_angle) 0)
    ((:encoder_pulses __encoder_pulses) (make-array 6 :initial-element 0 :element-type :integer))
    ((:joint_angles __joint_angles) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:setpoint_angles __setpoint_angles) (make-array 6 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _eStop (round __eStop))
   (setq _homed (round __homed))
   (setq _resting (round __resting))
   (setq _running (round __running))
   (setq _gripper_angle (round __gripper_angle))
   (setq _encoder_pulses __encoder_pulses)
   (setq _joint_angles __joint_angles)
   (setq _setpoint_angles __setpoint_angles)
   self)
  (:eStop
   (&optional __eStop)
   (if __eStop (setq _eStop __eStop)) _eStop)
  (:homed
   (&optional __homed)
   (if __homed (setq _homed __homed)) _homed)
  (:resting
   (&optional __resting)
   (if __resting (setq _resting __resting)) _resting)
  (:running
   (&optional __running)
   (if __running (setq _running __running)) _running)
  (:gripper_angle
   (&optional __gripper_angle)
   (if __gripper_angle (setq _gripper_angle __gripper_angle)) _gripper_angle)
  (:encoder_pulses
   (&optional __encoder_pulses)
   (if __encoder_pulses (setq _encoder_pulses __encoder_pulses)) _encoder_pulses)
  (:joint_angles
   (&optional __joint_angles)
   (if __joint_angles (setq _joint_angles __joint_angles)) _joint_angles)
  (:setpoint_angles
   (&optional __setpoint_angles)
   (if __setpoint_angles (setq _setpoint_angles __setpoint_angles)) _setpoint_angles)
  (:serialization-length
   ()
   (+
    ;; int8 _eStop
    1
    ;; int8 _homed
    1
    ;; int8 _resting
    1
    ;; int8 _running
    1
    ;; int8 _gripper_angle
    1
    ;; int64[6] _encoder_pulses
    (* 8    6)
    ;; float64[6] _joint_angles
    (* 8    6)
    ;; float64[6] _setpoint_angles
    (* 8    6)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _eStop
       (write-byte _eStop s)
     ;; int8 _homed
       (write-byte _homed s)
     ;; int8 _resting
       (write-byte _resting s)
     ;; int8 _running
       (write-byte _running s)
     ;; int8 _gripper_angle
       (write-byte _gripper_angle s)
     ;; int64[6] _encoder_pulses
     (dotimes (i 6)
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _encoder_pulses i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _encoder_pulses i)) (= (length ((elt _encoder_pulses i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _encoder_pulses i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _encoder_pulses i) . bv) 1) -1) s))
             ((and (class (elt _encoder_pulses i)) (= (length ((elt _encoder_pulses i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _encoder_pulses i) . bv) 0) s)
              (write-long (if (>= (elt _encoder_pulses i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _encoder_pulses i) s)(write-long (if (>= (elt _encoder_pulses i) 0) 0 #xffffffff) s)))
       )
     ;; float64[6] _joint_angles
     (dotimes (i 6)
       (sys::poke (elt _joint_angles i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[6] _setpoint_angles
     (dotimes (i 6)
       (sys::poke (elt _setpoint_angles i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _eStop
     (setq _eStop (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _eStop 127) (setq _eStop (- _eStop 256)))
   ;; int8 _homed
     (setq _homed (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _homed 127) (setq _homed (- _homed 256)))
   ;; int8 _resting
     (setq _resting (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _resting 127) (setq _resting (- _resting 256)))
   ;; int8 _running
     (setq _running (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _running 127) (setq _running (- _running 256)))
   ;; int8 _gripper_angle
     (setq _gripper_angle (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _gripper_angle 127) (setq _gripper_angle (- _gripper_angle 256)))
   ;; int64[6] _encoder_pulses
   (dotimes (i (length _encoder_pulses))
#+(or :alpha :irix6 :x86_64)
      (setf (elt _encoder_pulses i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _encoder_pulses i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     )
   ;; float64[6] _joint_angles
   (dotimes (i (length _joint_angles))
     (setf (elt _joint_angles i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; float64[6] _setpoint_angles
   (dotimes (i (length _setpoint_angles))
     (setf (elt _setpoint_angles i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(setf (get ar3::ar3_feedback :md5sum-) "64163ea4ea47214d9da1c0355fe48ee5")
(setf (get ar3::ar3_feedback :datatype-) "ar3/ar3_feedback")
(setf (get ar3::ar3_feedback :definition-)
      "int8 eStop
int8 homed
int8 resting
int8 running
int8 gripper_angle

int64[6] encoder_pulses
float64[6] joint_angles
float64[6] setpoint_angles




")



(provide :ar3/ar3_feedback "64163ea4ea47214d9da1c0355fe48ee5")


