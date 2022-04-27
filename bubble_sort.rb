def bubble_sort(array)
  (array.length - 1).times {
    (array.length).times { |i|
      if i != array.length - 1
        if array[i] > array[i + 1]
          swap = array[i + 1]
          array[i + 1] = array[i]
          array[i] = swap
        end
      end
    }
  }
  array
end

p bubble_sort([9, 6, 5, 3, 2,45,73,12,4,87,24,123,345,365])
