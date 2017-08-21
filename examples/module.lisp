(
  module
  ; This module is about to print some message
  ; This module is about to print some message

  (import io "io")

  (export default (
    func
    print ; name
    void ; return type
    [
      (string msg)
    ] ; args
    (io.print msg) ; body
  ))

  (export (const numbers [1 2 3 5 7 11]))

  (export (const user0 "admin"))

  (export (func sum int
    [(int a) (int b)] ; args
    (return (+ a b)) ; function body
  ))
)
