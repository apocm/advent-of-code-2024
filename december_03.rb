#!/usr/bin/env ruby


class December03
  @@test_input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
  @@test_input2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

  def self.call
    text = File.read('data/dec03.txt')
    #sum_of_multiples = self.search(text)
    sum_of_multiples_instructed = self.search_with_instructions(@@test_input2, "do")
    puts "sum: #{sum_of_multiples_instructed}"
  end

  def self.search(input)
    mul_substring = input[/mul\(\d{1,3},\d{1,3}\)/]

    if mul_substring.nil?
      return 0
    end

    input.slice!(mul_substring)

    a,b = mul_substring[/(\d{1,3}),(\d{1,3})/].split(",")
    return a.to_i * b.to_i + self.search(input)
  end

  def self.search_with_instructions(input, instruction)
    puts "input: #{input}"
    puts "instruction: #{instruction}"

    mul_substring = input[/((do(?!n))|(don\'t))*(.*?)mul\(\d{1,3},\d{1,3}\)/]

    if mul_substring.nil?
      return 0
    end

    new_instruction, a, b = input.match(/(do(?!n)|don\'t)*.*?mul\((\d{1,3}),(\d{1,3})\)/).captures
    input.slice!(mul_substring)

    puts "new_instruction: #{new_instruction}"

    multiply = 0
    if (new_instruction.nil? && instruction == "do") || new_instruction == "do"
      multiply = a.to_i * b.to_i
      puts "mul(#{a}, #{b})"
    end

    return multiply + self.search_with_instructions(input, new_instruction || instruction)
  end
end

December03.()
