#!/usr/bin/env ruby
require_relative 'data/lists'

class LocationFinder
  include ::Lists

  def self.calculate_distance(listA = nil, listB = nil, debug: false)
    listA ||= [3, 4, 2, 1, 3, 3]
    listB ||= [4, 3, 5, 3, 9, 3]

    return -1 if listA.length != listB.length

    puts "nb locations to process: #{listA.length}"

    distance_between = []
    nb_processed = 1

    loop do
      minA = listA.min
      minB = listB.min
      puts minA if debug
      puts minB if debug

      distance = delta(minA, minB)
      puts distance if debug

      distance_between << distance

      listA.delete_at(listA.index(minA))
      listB.delete_at(listB.index(minB))

      break if (listA.length == 0 && listB.length == 0)

      nb_processed+= 1

      puts 'next' if debug
    end

    puts "processed: #{nb_processed}"
    puts "The total distance is: #{ distance_between.sum}"
  end

  def self.delta(a,b)
    (a-b).abs
  end

  def self.scan(listA = nil, listB = nil, debug: false)
    listA ||= [3, 4, 2, 1, 3, 3]
    listB ||= [4, 3, 5, 3, 9, 3]
    counts = {}

    listA.each do |a|
      puts "scanning for #{a}" if debug

      loop do
        # find first occurence of value in list A
        index = listB.index(a)
        break if index == nil || listB.length == 0

        # init or increment the count
        if counts[a]
          counts[a] +=1
        else
          counts[a] = 1
        end

        listB.delete_at(index)
      end
      puts "count #{counts[a]}" if debug
    end

    similarity_score = self.similarity(listA, counts)

    puts "similarity_score: #{similarity_score}"
  end

  def self.similarity(listA, counts)
    sum = 0

    listA.each do |a|
      next if !counts[a]
      sum += (a * counts[a])
    end

    sum
  end
end

# # 01/01 Puzzle 1
# LocationFinder.calculate_distance(Lists.list_a, Lists.list_b, debug: false)

# 01/01 Puzzle 2
LocationFinder.scan(Lists.list_a, Lists.list_b, debug: false)

# This time, you'll need to figure out exactly how often each number from the left list appears in the right list.
#Calculate a total similarity score by adding up each number in the left list after multiplying it by the number of times that number appears in the right list.
