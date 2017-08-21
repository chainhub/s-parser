const {Parser, Grammar} = require('nearley');
const path = require('path');
const fs = require('fs');
const {inspect} = require('util');

const grammar = require('./build/grammar.js');
const parser = new Parser(Grammar.fromCompiled(grammar, {orderedChoise: true}));

let stdin;
let sourcePath = process.argv[2];

if (sourcePath) {
  stdin = fs.createReadStream(sourcePath);
}
else {
  stdin = process.stdin;
}

stdin.on('data', (chunk) => {
  const str = chunk.toString('utf8');
  try {
    parser.feed(str);
  }
  catch (err) {
    console.error("Error at character " + err.offset);
    console.error(str.slice(0, err.offset));
    process.exit(1);
  }
});

stdin.on('end' , () => {
  console.log(inspect(parser.results, {colors: true, depth: 10}));
});
