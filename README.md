# Pandoc Lua filters

A collection of Lua filters for pandoc. At the moment only a filter creating
environments out of description lists is supported.

## Usage

### AMSmath environments
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
        | <environmentname> {@<label>}
        | <environmentname> (<optionaltext>) {@<label>}
        | <environmentname> {@<label>} (<optionaltext>)
```
`<environmentname>` will always be transformed into lower case. `<label>` will
be used as the latex label for references and `<optionaltext>` will go into the
optional argument.

To start a proof environment simply write `_Proof._` and to end a proof environment write `_QED_`. 

#### Example
```
Theorem Kurt Gödel (secondincompleteness)

: Every recursively axiomatizable theory which extends __PA__ and proves its
own consistency is inconsistent.
```
will produce
```
\begin[Kurt Gödel]{theorem}\label{secondincompleteness}

Every recursively axiomatizable theory which extends \textbf{PA} and
proves its own consistency is inconsistent.

\end{theorem}
```
### Colored blocks and inline.
The syntax to color inline elements is
```
[<text>]{.<color>}
```
Make sure you have the color defined in your header.

To color blocks, put them in a div and add the color as a class.
```
:::::{.<color>}
<blocks>
:::::
```

#### Examples
```
This is [colored text]{.red}
```
will produce
```
This is {\color{red} colored text}
```
and 
```
::::{.blue}
This is a colored paragraph.

This is another colored paragraph. 

::::
```
will produce
```
{\color{blue}

This is a colored paragraph.

This is another colored paragraph. 

}
```
