
(cl:in-package :asdf)

(defsystem "ar3-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ar3_control" :depends-on ("_package_ar3_control"))
    (:file "_package_ar3_control" :depends-on ("_package"))
    (:file "ar3_feedback" :depends-on ("_package_ar3_feedback"))
    (:file "_package_ar3_feedback" :depends-on ("_package"))
  ))