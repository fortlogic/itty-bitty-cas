#lang typed/racket/base

(require (for-syntax racket/base
                     syntax/parse))

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