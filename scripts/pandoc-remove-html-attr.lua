--via: https://stackoverflow.com/questions/53403041/pandoc-convert-markdown-to-html-without-any-html-attributes

function remove_attr (x)
  if x.attr then
    x.attr = pandoc.Attr()
    return x
  end
end

return {{Inline = remove_attr, Block = remove_attr}}
