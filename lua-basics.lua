-- this is a comment
num = 22 -- this global variable represents a number
local num2 = 33 -- local variable
str1 = 'this is a string'
str2 = "and so is this"
str3 = [[ and this is a string too ]]
str4 = "string " .. "concatenation"
val = true and not false -- booleans and logical operators

if str1 == 'something' then
  print("YES")
elseif str2 ~= 'is not equal' then
  print('Maybe')
else
  print('no')
end

function printText(text)
  print(text)
  return true
end

tab1 = { 'this', 'is, 'a', 'table' } -- aka array
-- tables are both arrays and dictionaries
tab2 = { also = 'this is a table' }
tab2["new_key"] = "new value"

print(tab2["also"])

require('plugins') -- will find and execute plugins.lua file
