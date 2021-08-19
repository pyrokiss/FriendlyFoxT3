maze = {}

function reverse(t)
  local n = #t
  local i = 1
  while i < n do
    t[i],t[n] = t[n],t[i]
    i = i + 1
    n = n - 1
  end
end

function split_func(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function add_line(line)
  if string.find(line, "0") then
    line = string.gsub(line, "0", "0,");
  end
  if string.find(line, " ") then
    line = string.gsub(line, " ", " ,");
  end
  if string.find(line, "I") then
    line = string.gsub(line, "I", "I,");
  end
  if string.find(line, "E") then
    line = string.gsub(line, "E", "E,");
  end
  
  result = split_func(line, ",")
  table.remove(result, #result)
  return result;
end

local MazePath = "C:\\Users\\User\\Desktop\\FriendlyFoxT3\\Maze.txt"

local mf
mf = io.open(MazePath, "r")
for line in mf:lines() do
  --print(line)
  temp = add_line(line)
  --print(unpack(temp))
  table.insert(maze, temp)
end
mf:close()

for i, arr in ipairs(maze) do
  for j, k in ipairs(arr) do
    if k == "I" then
      start = {i, j}
      print("Start: ", table.unpack(start))
    end
    if k == "E" then
      finish = {i, j}
      print("Finish: ", table.unpack(finish))
    end
  end
end
if table.getn(start) < 2 then
  print("Не найдена начальная точка!")
end
if table.getn(finish) < 2 then
  print("Не найдена конечная точка!")
end


m={}
for i=1, table.getn(maze) do
  table.insert(m, {})
  for j=1, table.getn(maze[1]) do
    table.insert(m[i], 0)
  end
end

m[start[1]][start[2]] = 1

function make_step(k)
  for i=1, table.getn(m) do
    for j=1, table.getn(m[i]) do
      if m[i][j] == k then
        if i > 1 and m[i-1][j] == 0 and (maze[i-1][j] == " " or maze[i-1][j] == "E") then
          m[i-1][j] = k+1
        end
        if j > 1 and m[i][j-1] == 0 and (maze[i][j-1] == " " or maze[i][j-1] == "E") then
          m[i][j-1] = k+1
        end
        if i < (table.getn(m)) and m[i+1][j] == 0 and (maze[i+1][j] == " " or maze[i+1][j] == "E") then
          m[i+1][j] = k+1
        end
        if j < (table.getn(m[i])) and m[i][j+1] == 0 and (maze[i][j+1] == " " or maze[i][j+1] == "E") then
          m[i][j+1] = k+1
        end
       end   
    end
  end
end

k = 0
while m[finish[1]][finish[2]] == 0 do
    --print(k)
    k = k+1
    make_step(k)
end


local PathFile = "C:\\Users\\User\\Desktop\\FriendlyFoxT3\\PathFile.txt"
local pf
pf = io.open(PathFile, "w")
for i, arr in ipairs(maze) do
  table.insert(arr, "\n")
  pf:write(table.unpack(arr))
  pf:flush()
  table.remove(arr, #arr)
end
pf:write("\nStart: ",start[1],",",start[2])
pf:write("\nFinish: ",finish[1],",",finish[2])

i = finish[1]
j = finish[2]
k = m[i][j]
the_path = {{i, j}}
while k > 1 do
  if i > 0 and m[i - 1][j] == k - 1 then
    i = i - 1
    j = j
    table.insert(the_path, {i, j})
    maze[i][j] = "@"
    k = k - 1
  elseif j > 0 and m[i][j - 1] == k - 1 then
    i = i
    j = j - 1
    table.insert(the_path, {i, j})
    maze[i][j] = "@"
    k = k - 1
  elseif i < table.getn(m) - 1 and m[i + 1][j] == k - 1 then
    i = i + 1
    j = j
    table.insert(the_path, {i, j})
    maze[i][j] = "@"
    k = k - 1
  elseif j < table.getn(m[i]) - 1 and m[i][j + 1] == k - 1 then
    i = i
    j = j + 1
    table.insert(the_path, {i, j})
    maze[i][j] = "@"
    k = k - 1
  end
end

reverse(the_path)

pf:write("\nShortest way: ")
for i, arr in ipairs(the_path) do
  pf:write(" => ", arr[1],",",arr[2])
end

pf:write("\n\n")
for i, arr in ipairs(maze) do
  table.insert(arr, "\n")
  pf:write(table.unpack(arr))
  pf:flush()
  table.remove(arr, #arr)
end
pf:close()