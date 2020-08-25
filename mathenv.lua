local List=require 'pandoc.List'
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
          if el.t=='Str' and el.text~=nil then
            if string.sub(el.text,1,1)=='(' then
              label=string.sub(el.text,2,string.len(el.text)-1)
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
     content=List:new()
     local begintag
      if optional==''  then
        begintag='\\begin{'.. tag ..'}'
      else 
        begintag='\\begin['.. optional ..']{'.. tag ..'}'
      end
      if label~=nil then
        begintag=begintag .. '\\label{'.. label ..'}'
      end
      content:insert(pandoc.Plain(pandoc.RawInline('latex',begintag)))
      content:extend(item[2][1])
      content:insert(pandoc.Plain(pandoc.RawInline('latex','\\end{'.. tag ..'}')))
      env:extend(content)
    end
    return env

end

