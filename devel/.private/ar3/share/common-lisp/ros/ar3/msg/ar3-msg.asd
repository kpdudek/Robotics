
(cl:in-package :asdf)

(defsystem "ar3-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ar3_Feedback" :depends-on ("_package_ar3_Feedback"))
    (:file "_package_ar3_Feedback" :depends-on ("_package"))
  ))