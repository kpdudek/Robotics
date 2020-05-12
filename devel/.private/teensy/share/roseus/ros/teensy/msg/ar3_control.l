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
  :slots (_home _run _rest _close_gripper _joint_angles ))

(defmethod teensy::ar3_control
  (:init
   (&key
    ((:home __home) 0)
    ((:run __run) 0)
    ((:rest __rest) 0)
    ((:close_gripper __close_gripper) 0)
    ((:joint_angles __joint_angles) (make-array 6 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _home (round __home))
   (setq _run (round __run))
   (setq _rest (round __rest))
   (setq _close_gripper (round __close_gripper))
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
  (:close_gripper
   (&optional __close_gripper)
   (if __close_gripper (setq _close_gripper __close_gripper)) _close_gripper)
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
    ;; int8 _close_gripper
    1
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
     ;; int8 _close_gripper
       (write-byte _close_gripper s)
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
   ;; int8 _close_gripper
     (setq _close_gripper (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _close_gripper 127) (setq _close_gripper (- _close_gripper 256)))
   ;; float64[6] _joint_angles
   (dotimes (i (length _joint_angles))
     (setf (elt _joint_angles i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(setf (get teensy::ar3_control :md5sum-) "9026d471c1270c3777015c75e131a561")
(setf (get teensy::ar3_control :datatype-) "teensy/ar3_control")
(setf (get teensy::ar3_control :definition-)
      "int8 home
int8 run
int8 rest
int8 close_gripper

float64[6] joint_angles


")



(provide :teensy/ar3_control "9026d471c1270c3777015c75e131a561")


