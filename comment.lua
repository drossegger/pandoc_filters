function Str(elem)
  if string.sub(elem.text,1,1)=='%' then
    return pandoc.RawInline('latex',elem.text)
  end
end

