;; Auto-generated. Do not edit!


(when (boundp 'teensy::ar3_control)
  (if (not (find-package "TEENSY"))
    (make-package "TEENSY"))
  (shadow 'ar3_control (find-package "TEENSY")))
(unless (find-package "TEENSY::AR3_CONTROL")
  (make-package "TEENSY::AR3_CONTROL"))

(in-package "ROS")
;;//! \htmlinclude ar3_control.msg.html


(defclass teensy::ar3_control
  :super ros::object
  :slots (_home _run _rest _gripper_angle _speed _joint_angles ))

(defmethod teensy::ar3_control
  (:init
   (&key
    ((:home __home) 0)
    ((:run __run) 0)
    ((:rest __rest) 0)
    ((:gripper_angle __gripper_angle) 0)
    ((:speed __speed) 0.0)
    ((:joint_angles __joint_angles) (make-array 6 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _home (round __home))
   (setq _run (round __run))
   (setq _rest (round __rest))
   (setq _gripper_angle (round __gripper_angle))
   (setq _speed (float __speed))
   (setq _joint_angles __joint_angles)
   self)
  (:home
   (&optional __home)
   (if __home (setq _home __home)) _home)
  (:run
   (&optional __run)
   (if __run (setq _run __run)) _run)
  (:rest
   (&optional __rest)
   (if __rest (setq _rest __rest)) _rest)
  (:gripper_angle
   (&optional __gripper_angle)
   (if __gripper_angle (setq _gripper_angle __gripper_angle)) _gripper_angle)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:joint_angles
   (&optional __joint_angles)
   (if __joint_angles (setq _joint_angles __joint_angles)) _joint_angles)
  (:serialization-length
   ()
   (+
    ;; int8 _home
    1
    ;; int8 _run
    1
    ;; int8 _rest
    1
    ;; int8 _gripper_angle
    1
    ;; float64 _speed
    8
    ;; float64[6] _joint_angles
    (* 8    6)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _home
       (write-byte _home s)
     ;; int8 _run
       (write-byte _run s)
     ;; int8 _rest
       (write-byte _rest s)
     ;; int8 _gripper_angle
       (write-byte _gripper_angle s)
     ;; float64 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64[6] _joint_angles
     (dotimes (i 6)
       (sys::poke (elt _joint_angles i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _home
     (setq _home (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _home 127) (setq _home (- _home 256)))
   ;; int8 _run
     (setq _run (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _run 127) (setq _run (- _run 256)))
   ;; int8 _rest
     (setq _rest (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _rest 127) (setq _rest (- _rest 256)))
   ;; int8 _gripper_angle
     (setq _gripper_angle (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _gripper_angle 127) (setq _gripper_angle (- _gripper_angle 256)))
   ;; float64 _speed
     (setq _speed (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64[6] _joint_angles
   (dotimes (i (length _joint_angles))
     (setf (elt _joint_angles i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(setf (get teensy::ar3_control :md5sum-) "208a9b5e1d8eccf1fe39655639adaa71")
(setf (get teensy::ar3_control :datatype-) "teensy/ar3_control")
(setf (get teensy::ar3_control :definition-)
      "int8 home
int8 run
int8 rest

int8 gripper_angle
float64 speed

float64[6] joint_angles


")



(provide :teensy/ar3_control "208a9b5e1d8eccf1fe39655639adaa71")


