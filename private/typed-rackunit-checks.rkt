#lang typed/racket/base

(require/typed/provide "rackunit-checks.rkt"
                       [check-macro-expansion-equal? check-ish-ty])

(define-type check-ish-ty
  (case-lambda
    (Any Any -> Any)
    (Any Any String -> Any)))
(define-type (Predicate A) (A -> Boolean))
(define-type (Thunk A) (-> A))