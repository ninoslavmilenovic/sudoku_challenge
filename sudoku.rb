require 'lib/sudoku'

Arguments = ['--check-only', '--verbose']

unless (Arguments << nil).include? ARGV[1]
  puts "Invalid argument: #{ARGV[1]}"
  exit 1
end

unless ARGV[0] && File.exist?(ARGV[0])
  puts "Usage: ruby sodoku.rb <description file> [--verbose] [--check-only]"
  exit 1
end

begin
  input = File.new(ARGV[0]).read
  soduku = Soduku.from_text(input)
rescue Soduku::ParseError => msg
  puts "Error in sudoku description file."
  puts msg
  exit 1
end

puts "Input:"
puts soduku

$iterations = 0

$verbose = true if ARGV[1] == '--verbose'
result = soduku.solve 

if result 
  if ARGV[1] == '--check-only'
    puts "A solution exists (found in #{$iterations} iterations)."
  else
    puts "Solution (found in #{$iterations} iterations): "
    puts result
  end
else
  puts "No solution is possible (confirmed after #{$iterations} iterations)."
end
