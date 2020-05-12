
(cl:in-package :asdf)

(defsystem "teensy-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ar3_control" :depends-on ("_package_ar3_control"))
    (:file "_package_ar3_control" :depends-on ("_package"))
    (:file "teensy_angles" :depends-on ("_package_teensy_angles"))
    (:file "_package_teensy_angles" :depends-on ("_package"))
    (:file "teensy_pulses" :depends-on ("_package_teensy_pulses"))
    (:file "_package_teensy_pulses" :depends-on ("_package"))
  ))