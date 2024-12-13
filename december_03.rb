#!/usr/bin/env ruby


class December03
  @@test_input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

  def self.call
    text = File.read('data/dec03.txt')
    sum_of_multiples = self.search(text)
    puts "sum: #{sum_of_multiples}"
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
end

December03.()
