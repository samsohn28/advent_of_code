# frozen_string_literal: true

class ClockCircuit
  STOP_CYCLES = [20, 60, 100, 140, 180, 220].freeze

  attr_accessor :cycles, :current_signal, :current_cycle, :total_signal_strength

  def initialize
    @cycles = File.read('input.txt').split("\n")
    @current_signal = 1
    @current_cycle = 1
    @total_signal_strength = 0
  end

  def process_cycles
    cycles.each do |cycle|
      first, second = cycle.split(' ')
      case first
      when 'noop'
        update_signal_strength if stop_cycle?
        process_noop
      when 'addx'
        update_signal_strength if stop_cycle?
        process_noop
        update_signal_strength if stop_cycle?
        process_addx(second.to_i)
      end
    end
    puts @total_signal_strength
  end

  private

  def process_noop
    @current_cycle += 1
  end

  def process_addx(num)
    @current_cycle += 1
    @current_signal += num
  end

  def stop_cycle?
    STOP_CYCLES.include?(@current_cycle)
  end

  def update_signal_strength
    @total_signal_strength += @current_signal * @current_cycle
  end
end

ClockCircuit.new.process_cycles
