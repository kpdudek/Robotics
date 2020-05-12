;; Auto-generated. Do not edit!


(when (boundp 'teensy::teensy_pulses)
  (if (not (find-package "TEENSY"))
    (make-package "TEENSY"))
  (shadow 'teensy_pulses (find-package "TEENSY")))
(unless (find-package "TEENSY::TEENSY_PULSES")
  (make-package "TEENSY::TEENSY_PULSES"))

(in-package "ROS")
;;//! \htmlinclude teensy_pulses.msg.html


(defclass teensy::teensy_pulses
  :super ros::object
  :slots (_pulses ))

(defmethod teensy::teensy_pulses
  (:init
   (&key
    ((:pulses __pulses) (make-array 6 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _pulses __pulses)
   self)
  (:pulses
   (&optional __pulses)
   (if __pulses (setq _pulses __pulses)) _pulses)
  (:serialization-length
   ()
   (+
    ;; int16[6] _pulses
    (* 2    6)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16[6] _pulses
     (dotimes (i 6)
       (write-word (elt _pulses i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16[6] _pulses
   (dotimes (i (length _pulses))
     (setf (elt _pulses i) (sys::peek buf ptr- :short)) (incf ptr- 2)
     )
   ;;
   self)
  )

(setf (get teensy::teensy_pulses :md5sum-) "fb3b288c417a05835e02e94aae5e2865")
(setf (get teensy::teensy_pulses :datatype-) "teensy/teensy_pulses")
(setf (get teensy::teensy_pulses :definition-)
      "int16[6] pulses

")



(provide :teensy/teensy_pulses "fb3b288c417a05835e02e94aae5e2865")


