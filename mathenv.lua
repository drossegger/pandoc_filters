local List=require 'pandoc.List'
-- local inspect=require 'inspect'
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function DefinitionList(dl)
  --if #dl.content>1 then
  --  error("Format error: Too many definitions")
  --else
  local env=List:new()
  local content
    for i,item in ipairs(dl.content) do
      local label
      local optional=''
      local tag="no"
      local counter=0
      for j,el in ipairs(item[1]) do
        if counter == 0 and el.t=='Str' then
          tag=string.lower(el.text)
          counter=counter+1
        else
          if el.t=='Math' then
            optional=optional..'$'..el.text..'$'
          end
          if el.t=='Str' and el.text~=nil then
            if string.sub(el.text,1,1)=='{' then
              label=string.sub(el.text,3,string.len(el.text)-1)
            else 
              if optional=='' then
                optional=el.text
              else
                optional=optional .. ' ' .. el.text
              end
            end
          end
        end
      end
     if optional~=nil then
       if string.sub(optional,1,1)=='(' then
         optional=string.sub(optional,2,string.len(optional)-1)
       end
     end

     content=List:new()
     local begintag
      if optional==''  then
        begintag='\\begin{'.. tag ..'}'
      else 
        begintag='\\begin{'.. tag ..'}['.. optional ..']'
      end
      if label~=nil then
        begintag=begintag .. '\\label{'.. label ..'}'
      end
      if item[2][1][1].t=='Plain' or item[2][1][1].t=='Para' then
        item[2][1][1].content:insert(1,pandoc.RawInline('latex',begintag..'\n'))
      else 
        item[2][1]:insert(1,pandoc.Plain(pandoc.RawInline('latex',begintag)))
      end
      local length=tablelength(item[2][1])
      if item[2][1][length].t=='Plain' or item[2][1][length].t=='Para' then
        item[2][1][length].content:insert(pandoc.RawInline('latex','\n\\end{'.. tag ..'}'))
      else
        item[2][1]:insert(pandoc.Plain(pandoc.RawInline('latex','\\end{'.. tag ..'}')))
      end
      -- item[2][1][1]:insert(pandoc.Plain(pandoc.RawInline('latex',begintag )))
      -- content:insert(pandoc.Plain(pandoc.RawInline('latex',begintag)))
      -- content:extend(item[2][1])
      -- content:insert(pandoc.Plain(pandoc.RawInline('latex','\\end{'.. tag ..'}')))
      env:extend(item[2][1])
    end
    return env

end

function Emph(strong)
  local env=List:new()
  if strong.content[1].text=='Proof.' then
    return pandoc.RawInline('latex','\\begin{proof}\n')
  end
  if strong.content[1].text=='QED' then
    return pandoc.RawInline('latex','\n \\end{proof}')
  end
  if strong.content[1].text=='Proof' and strong.content[2].t=='Space' then
    return pandoc.RawInline('latex','\\begin{proof}[Proof '..strong.content[3].text..']\n')
  end
end
