function add_color_latex(elem, color)
  if color=='comment' then
    if elem.tag=='Span' then
      return pandoc.Span('')
    end
    if elem.tag=='Div' then
      return pandoc.Div(pandoc.Span(''))
    end
  end
  if elem.tag=='Span' then
    elem.content:insert(1,pandoc.RawInline('latex','\\color{'.. color ..'} '))
    --elem.content:insert(pandoc.RawInline('latex','}'))
  end
  if elem.tag=='Div' then
    elem.content:insert(1,pandoc.RawBlock('latex','{\\color{'.. color ..'} '))
    elem.content:insert(pandoc.RawBlock('latex','}'))
  end
  return elem
end

function Span(elem)
  return add_color_latex(elem,elem.classes[1])
end

function Div(elem)
  return add_color_latex(elem,elem.classes[1])
end
