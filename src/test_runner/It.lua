return function(results, prefix, its)
  return function(name, f)
    table.insert(its, { name = prefix .. ' ' .. name, f = f })
  end
end
