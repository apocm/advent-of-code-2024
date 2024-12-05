#!/usr/bin/env ruby
require_relative 'data/reports'

class December02
  include Reports

  @@debug

  def self.safe_increment?(a,b)
    return false if (a-b).abs < 1
    return false if (a-b).abs > 3
    true
  end

  def self.direction(a,b)
    if (a-b) < 0
     return -1
    end
    1
  end

  def self.is_report_safe?(report, initial_direction)
    puts report if @@debug

    report.each_with_index do |level, i|

      next_level = report[i+1]
      puts "comparing #{level}, #{next_level}" if @@debug

      if self.direction(level, next_level) != initial_direction # not safe
        puts "unsafe direction" if @@debug
        return false
      end

      if !self.safe_increment?(level, next_level) # not safe
        puts "unsafe increment" if @@debug
        return false
      end

      break if i == report.length - 2 # end of comparison
    end

    true
  end

  def self.analyze(reports = nil, debug: false)
    @@debug = debug

    reports ||= [
      [7, 6, 4, 2, 1],
      [1, 2, 7, 8, 9],
      [9, 7, 6, 2, 1],
      [1, 3, 2, 4, 5],
      [8, 6, 4, 4, 1],
      [1, 3, 6, 7, 9]
    ]

    safe_reports_count = 0

    reports.each do |report|
      initial_direction = self.direction(report[0], report[1])

      safe_reports_count += 1 if self.is_report_safe?(report, initial_direction)
    end

    puts "nb safe reports: #{safe_reports_count}"
  end
end

# Puzzle 1
December02.analyze(Reports.reports, debug: false)
