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
    elsif (a-b) == 0
      return 0
    end
    1
  end

  def self.is_report_safe(report, initial_direction)
    report.each_with_index do |level, i|
      next_level = report[i+1]

      puts "comparing #{level}, #{next_level}" if @@debug

      is_level_safe = self.is_level_safe(initial_direction, level, next_level)

      if !is_level_safe
        puts "unsafe level" if @@debug
        return [false, i]
      end

      break if i == report.length - 2 # end of comparison
    end

    [true, 0]
  end

  def self.is_level_safe(initial_direction, level, next_level)
      direction = self.direction(level, next_level)

      if direction == 0
        puts "unsafe, not incr/decr" if @@debug
        return false
      end

      if direction != initial_direction # not safe
        puts "unsafe direction" if @@debug
        return false
      end

      if !self.safe_increment?(level, next_level) # not safe
        puts "unsafe increment" if @@debug
        return false
      end

      true
  end


  def self.get_init_direction(report)
    initial_direction = 0

    for i in 0..report.length-2 do
      initial_direction = self.direction(report[i], report[i+1])
      break if initial_direction != 0
    end

    initial_direction
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

    reports.each_with_index do |report, report_number|
      puts report.join(', ')
      puts "report #: #{report_number+1}"

      init_direction = self.get_init_direction(report)

      puts "initial direction: #{init_direction}"
      is_safe, level_index = self.is_report_safe(report, init_direction)

      if is_safe
        safe_reports_count += 1
      else
        is_safe_dampened = self.dampen_report(report)
        if is_safe_dampened
          safe_reports_count += 1
        end
      end
      break if report_number == 10 && @@debug
    end

    puts "nb safe reports: #{safe_reports_count}"
  end

  def self.dampen_report(report)
    report.each do |level|
      level_to_remove_index = report.index(level)
      dampened_report = report.dup
      dampened_report.delete_at(level_to_remove_index)
      init_direction = self.get_init_direction(dampened_report)
      is_safe, index = self.is_report_safe(dampened_report, init_direction)

      if is_safe
        return true
      end
    end

    false
  end
end

# Puzzle 1 + 2
#December02.analyze(debug: true)
December02.analyze(Reports.reports, debug: true)
