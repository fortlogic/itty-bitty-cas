#lang typed/racket/base

(provide Expression Variable
         Unary-Operator Binary-Operator
         (struct-out unary-expression)
         (struct-out binary-expression))

(require (for-syntax racket/base
                     syntax/parse))

(module+ test
  (require typed/rackunit
           unstable/macro-testing
           "private/typed-rackunit-checks.rkt"))

(define-type Expression (U Number
                           Variable
                           unary-expression
                           binary-expression))

(define-type Variable Symbol)

(struct unary-expression ([operator : Unary-Operator]
                          [body : Expression])
  #:transparent)

(struct binary-expression ([operator : Binary-Operator]
                           [left : Expression]
                           [right : Expression])
  #:transparent)

(define-type Unary-Operator (U '-))

(define-type Binary-Operator (U '+ '*))

(define-syntax (expression stx)
  (define exp-body
    (syntax-parse stx
      [(_ num:number) #'num]))
  #`(ann #,exp-body Expression))

(module+ test
  (display "hi")
  (check-macro-expansion-equal? #'(expression "a") #;(convert-syntax-error (expression e)) 7))