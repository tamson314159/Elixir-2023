list1 = [1, 2, 3]
list2 = list1
list1 = list1 ++ [4]
IO.inspect(list1)
# [1, 2, 3, 4]
IO.inspect(list2)
# [1, 2, 3]
