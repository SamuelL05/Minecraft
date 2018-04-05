local x, y, z = gps.locate()
print(x, y, z)
if not x then
  print("Failed")
else
  print(x, y, z)
end
