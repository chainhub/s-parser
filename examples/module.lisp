(
  ; This is an example module
  ; It exports default function print
  ; define some constants, variables and sum function
  module

  (import io "io")

  (export default (
    func
    "print" ; name optional
    void ; return type
    [
      (string msg)
    ] ; args
    (io.print msg) ; body
  ))
  ; constant string
  (export (const user0 "admin"))
  ; constant list
  (export (const numbers [1 2 3 5 7 11]))
  ; variable
  (export (let count 0))
  ; function as constant
  (export (const sum (
    func "sum" int [
      (int a) (int b)
    ]
    (return (+ a b))
  )))
)
