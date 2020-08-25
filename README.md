# Pandoc Lua filters

A collection of Lua filters for pandoc. At the moment only a filter creating
environments out of description lists is supported.

## Usage
Add `--lua-filter mathenv.lua` to your pandoc call and make sure `mathenv.lua`
is in your path.

The markdown format that is filtered looks like this:
```
<term>

: <body>
```
Where `<body>` contains the body of your environment and can be markdown block
or even a list of markdown blocks and `<term>` is given by the following.
```
<term> ::= <environmentname>
        | <environmentname> (<label>)
        | <environmentname> (<label>) <optionaltext>
        | <environmentname> <optionaltext>
```
`<environmentname>` will always be transformed into lower case. `<label>` will
be used as the latex label for references and `<optionaltext>` will go into the
optional argument.
### Example
```
Theorem Kurt Gödel (secondincompleteness)

: Every recursively axiomatizable theory which extends __PA__ and proves its
own consistency is inconsistent.
```
will produce
```
\begin[Kurt Gödel]{theorem}\label{thm:secondincompleteness}

Every recursively axiomatizable theory which extends \textbf{PA} and
proves its own consistency is inconsistent.

\end{theorem}
```
