#lang racket/base

(provide check-macro-expansion-equal?)

(require rackunit
         unstable/macro-testing)

(define-binary-check (check-macro-expansion-equal? actual expected)
  (let ([actual* (with-handlers ([exn:fail:syntax?
                                  (λ (exn)
                                    (with-check-info*
                                     (list
                                      (make-check-message "Exception raised")
                                      (check-info 'exception-message (exn-message exn))
                                      (check-info 'exception exn))
                                     (lambda () (fail-check))))])
                   (convert-syntax-error (eval-syntax actual)))]
        [expected* expected])
    (when (not (equal? actual* expected*))
      (fail-check))))
