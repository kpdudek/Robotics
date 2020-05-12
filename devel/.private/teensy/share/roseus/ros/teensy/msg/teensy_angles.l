;; Auto-generated. Do not edit!


(when (boundp 'teensy::teensy_angles)
  (if (not (find-package "TEENSY"))
    (make-package "TEENSY"))
  (shadow 'teensy_angles (find-package "TEENSY")))
(unless (find-package "TEENSY::TEENSY_ANGLES")
  (make-package "TEENSY::TEENSY_ANGLES"))

(in-package "ROS")
;;//! \htmlinclude teensy_angles.msg.html


(defclass teensy::teensy_angles
  :super ros::object
  :slots (_j1_angle _j2_angle _j3_angle _j4_angle _j5_angle _j6_angle ))

(defmethod teensy::teensy_angles
  (:init
   (&key
    ((:j1_angle __j1_angle) 0.0)
    ((:j2_angle __j2_angle) 0.0)
    ((:j3_angle __j3_angle) 0.0)
    ((:j4_angle __j4_angle) 0.0)
    ((:j5_angle __j5_angle) 0.0)
    ((:j6_angle __j6_angle) 0.0)
    )
   (send-super :init)
   (setq _j1_angle (float __j1_angle))
   (setq _j2_angle (float __j2_angle))
   (setq _j3_angle (float __j3_angle))
   (setq _j4_angle (float __j4_angle))
   (setq _j5_angle (float __j5_angle))
   (setq _j6_angle (float __j6_angle))
   self)
  (:j1_angle
   (&optional __j1_angle)
   (if __j1_angle (setq _j1_angle __j1_angle)) _j1_angle)
  (:j2_angle
   (&optional __j2_angle)
   (if __j2_angle (setq _j2_angle __j2_angle)) _j2_angle)
  (:j3_angle
   (&optional __j3_angle)
   (if __j3_angle (setq _j3_angle __j3_angle)) _j3_angle)
  (:j4_angle
   (&optional __j4_angle)
   (if __j4_angle (setq _j4_angle __j4_angle)) _j4_angle)
  (:j5_angle
   (&optional __j5_angle)
   (if __j5_angle (setq _j5_angle __j5_angle)) _j5_angle)
  (:j6_angle
   (&optional __j6_angle)
   (if __j6_angle (setq _j6_angle __j6_angle)) _j6_angle)
  (:serialization-length
   ()
   (+
    ;; float64 _j1_angle
    8
    ;; float64 _j2_angle
    8
    ;; float64 _j3_angle
    8
    ;; float64 _j4_angle
    8
    ;; float64 _j5_angle
    8
    ;; float64 _j6_angle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _j1_angle
       (sys::poke _j1_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _j2_angle
       (sys::poke _j2_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _j3_angle
       (sys::poke _j3_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _j4_angle
       (sys::poke _j4_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _j5_angle
       (sys::poke _j5_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _j6_angle
       (sys::poke _j6_angle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _j1_angle
     (setq _j1_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _j2_angle
     (setq _j2_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _j3_angle
     (setq _j3_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _j4_angle
     (setq _j4_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _j5_angle
     (setq _j5_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _j6_angle
     (setq _j6_angle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get teensy::teensy_angles :md5sum-) "ff3325ea44ea22847dec9013538e06aa")
(setf (get teensy::teensy_angles :datatype-) "teensy/teensy_angles")
(setf (get teensy::teensy_angles :definition-)
      "float64 j1_angle
float64 j2_angle
float64 j3_angle
float64 j4_angle
float64 j5_angle
float64 j6_angle

")



(provide :teensy/teensy_angles "ff3325ea44ea22847dec9013538e06aa")


