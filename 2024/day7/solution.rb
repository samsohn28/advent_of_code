# frozen_string_literal: true

class BridgeRepair
  attr_reader :equations

  def initialize
    @equations = File.read('input.txt').split("\n")
  end

  def part1
    puts calculate_total_calibration
  end

  def part2
    puts calculate_total_calibration(allow_concatenation: true)
  end

  private

  # DRY method to calculate the total calibration result
  def calculate_total_calibration(allow_concatenation: false)
    total_calibration_result = 0
    equations.each do |equation|
      output, inputs = equation.split(':')
      output = output.to_i
      inputs = inputs.split.map(&:to_i)

      total_calibration_result += output if equation_possible?(inputs, output, allow_concatenation)
    end
    total_calibration_result
  end

  def equation_possible?(inputs, output, allow_concatenation, current_value = 0)
    return current_value == output if inputs.empty?

    first_input = inputs.first
    remaining_input = inputs[1..]

    possible = equation_possible?(remaining_input, output, allow_concatenation, current_value + first_input) ||
               equation_possible?(remaining_input, output, allow_concatenation, current_value * first_input)

    if allow_concatenation
      possible ||= equation_possible?(remaining_input, output, allow_concatenation, (current_value.to_s + first_input.to_s).to_i)
    end

    possible
  end
end

bridge = BridgeRepair.new
bridge.part1
bridge.part2
