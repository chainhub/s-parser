@{%
  function token(id, value, location) {
    return {id, value, location};
  }

  function nth(n) {
    return (item) => item[n];
  }

  function toToken(id, ...args) {
    let fn;
    if (typeof args[0] === 'number') {
      let n = args[0];
      fn = (data) => data[n];
    }
    else {
      fn = args[0];
    }

    return (data, loc) => token(id, fn(data), loc);
  }

  function join(n) {
    return (data) => data[n].join('');
  }

  const tokens = {
    program: toToken('program', 1),
    statement: toToken('statement', (data) => [
      data[2],
      ...data[3].map(nth(1)),
    ]),
    list: toToken('list', (data) => [
      data[2],
      ...data[3].map(nth(1)),
    ]),
    command: toToken('command', 0),
    id: toToken('id', 0),
    string: toToken('string', 1),
    number: toToken('number', (data) => parseInt(data[0], 10)),
    float: toToken('float', (data) => parseFloat(data[0] + '.' + data[2], 10)),
  };
%}

main -> _ statement _ {% tokens.program %}

statement -> "(" _ command (__ argument):* _ ")" {% tokens.statement %}

NL ->
  "\r\n"
  | "\r"
  | "\n"

_ -> space
  | (space comment):+ space

__ -> ws:+
  | (ws:+ comment):+ space

space -> ws:*

comment -> ";" [^\r\n]:+ NL

ws -> " " | NL

command -> word {% tokens.command %}

argument -> primitive {% id %}
  | statement {% id %}
  | list {% id %}
  | id {% id %}

primitive ->
  float  {% id %}
  | number {% id %}
  | string {% id %}

list ->
  "[" _ "]" {% toToken('list', () => []) %}
  | "[" _ argument (__ argument):* _ "]" {% tokens.list %}

number -> digits {% tokens.number %}

float -> digits "." digits {% tokens.float %}

digits -> digit:+ {% join(0) %}

digit -> [0-9]

string -> "\"" _string "\"" {% tokens.string %}

_string ->
	null {% () => "" %}
	| _string _stringchar {% (d) => d[0] + d[1] %}

_stringchar ->
	[^\\"] {% id %}
	| "\\" [^] {% (d) => JSON.parse("\"" + d[0] + d[1] + "\"") %}

id -> word {% ([value], loc) => {
    switch (value) {
      case 'true':
        return token('bool', true, loc);
      case 'false':
        return token('bool', false, loc);
      default:
        return token('id', value, loc);
    }
} %}

word -> (letter|special) symbol:* {% (data) => data[0] + data[1].join('') %}


symbol -> letter {% id %}
  | digit {% id %}
  | special {% id %}

letter -> [A-Za-z]

special
  -> "+"
  |  "-"
  |  "/"
  |  "*"
  |  "%"
  |  "^"
  |  "@"
  |  "#"
  |  "$"
  |  "?"
  |  "="
  |  "!"
  |  ">"
  |  "<"
  |  ":"
  |  "."
