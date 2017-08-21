# S-Parser

S-Parser is yet another one s-expression parser. It built for using in ChainHub VM.
It supports special features like arrays.

## Example

```
(
    module
    (export default [9 16])
    (export (const user0 "admin"))
    (export (func sum int
      [(int a) (int b)] ; args
      (return (+ a b)) ; function body
    ))
)
```

## License

MIT.
