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

(module+ test
  (require (for-syntax racket/base
                       syntax/parse))
  
  (define-syntax (expression stx)
    (define exp-body
      (syntax-parse stx
        [(_ num:number) #'num]))
    #`(ann #,exp-body Expression))

  ;;; should fail with syntax error
  (check-macro-expansion-equal? #'(expression "a") 7)
  ;;; should fail with wrong result
  (check-macro-expansion-equal? #'(expression 42) 47)
  ;;; should be fine
  (check-macro-expansion-equal? #'(expression 47) 47))