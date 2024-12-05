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
end

LocationFinder.calculate_distance(Lists.list_a, Lists.list_b, debug: false)
