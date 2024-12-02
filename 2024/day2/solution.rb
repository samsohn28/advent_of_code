
class RedNosedReports
  attr_reader :input
  def initialize
    @input = File.read('input.txt').lines.map(&:chomp)
  end

  def part1
    safe_reports = 0
    input.each do |line|
      report = line.split.map(&:to_i)
      safe_reports += 1 if safe_report?(report)
    end
    puts safe_reports
  end

  def part2
    safe_reports = 0
    input.each do |line|
      report = line.split.map(&:to_i)
      safe_reports += 1 if safe_report_with_dampener?(report)
    end
    puts safe_reports
  end

  def safe_report_with_dampener?(report)
    return true if safe_report?(report)

    report.each_with_index do |element, index|
      new_report = report.dup
      new_report.delete_at(index)
      return true if safe_report?(new_report)
    end
    false
  end

  def safe_report?(report)
    (ascending?(report) || descending?(report)) && within_range?(report)
  end

  def ascending?(report)
    report.sort == report
  end

  def descending?(report)
    report.sort.reverse == report
  end

  def within_range?(report)
    report.each_cons(2).all? do |a, b|
      (a - b).abs > 0 && (a - b).abs < 4
    end
  end
end

RedNosedReports.new.part1
RedNosedReports.new.part2
