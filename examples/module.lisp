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
)
