function get_roman_num(num)
  ones = {[0]="","I","II","III","IV","V","VI","VII","VIII","IX"};
  tens = {[0]="","X","XX","XXX","XL","L","LX","LXX","LXXX","XC"};
  hunds = {[0]="","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"};
  thous = {[0]="","M","MM","MMM","MMMM"};
  
  th = thous[math.floor(num/1000)];
  h = hunds[math.floor(num/100)%10];
  t = tens[math.floor(num/10)%10];
  o = ones[num%10];
  return th..h..t..o;
end

function get_arabic_num(str)
  l = {};
  total = 0;
  while str ~= "" do
    --print(str)
    --print(unpack(l))
    if string.find(str, "IV") then
      table.insert(l, 4);
      str = string.gsub(str, "IV", "", 1);
    elseif string.find(str, "IX") then
      table.insert(l, 9);
      str = string.gsub(str, "IX", "", 1);
    elseif string.find(str, "XL") then
      table.insert(l, 40);
      str = string.gsub(str, "XL", "", 1);
    elseif string.find(str, "XC") then
      table.insert(l, 90);
      str = string.gsub(str, "XC", "", 1);
    elseif string.find(str, "CD") then
      table.insert(l, 400);
      str = string.gsub(str, "CD", "", 1);
    elseif string.find(str, "CM") then
      table.insert(l, 900);
      str = string.gsub(str, "CM", "", 1);
    
    elseif string.find(str, "I") then
      table.insert(l, 1)
      str = string.gsub(str, "I", "", 1)
    elseif string.find(str, "V") then
      table.insert(l, 5)
      str = string.gsub(str, "V", "", 1)
    elseif string.find(str, "X") then
      table.insert(l, 10)
      str = string.gsub(str, "X", "", 1)
    elseif string.find(str, "L") then
      table.insert(l, 50)
      str = string.gsub(str, "L", "", 1)
    elseif string.find(str, "C") then
      table.insert(l, 100)
      str = string.gsub(str, "C", "", 1)
    elseif string.find(str, "D") then
      table.insert(l, 500)
      str = string.gsub(str, "D", "", 1)
    elseif string.find(str, "M") then
      table.insert(l, 1000)
      str = string.gsub(str, "M", "", 1)
    end;
  end;
  --print(unpack(l))
  for i,v in ipairs(l) do
    total = total + v
  end;
  return total;
end

get_roman_num(3133)

local file_r = "C:\\Users\\User\\Desktop\\FriendlyFoxT3\\roman.txt"
local fr
fr = io.open(file_r, "r")
local file_w = "C:\\Users\\User\\Desktop\\FriendlyFoxT3\\roman_out.txt"
local fw
fw = io.open(file_w, "w")
for line in fr:lines() do
  ar_num = get_arabic_num(line)
  rm_num = get_roman_num(tonumber(ar_num))
  print(line, ar_num, rm_num)
  if line ~= rm_num then
    fw:write(line.."\t"..tostring(ar_num).."\t"..rm_num.."\t".."changed".."\n")
    fw:flush()
  else
    fw:write(line.."\t"..tostring(ar_num).."\t"..rm_num.."\n")
    fw:flush()
  end
end
fw:close()
--local content = f:read("*all")
--for line in content do
  --print(tostring(line))
--end
--print(content)
fr:close()