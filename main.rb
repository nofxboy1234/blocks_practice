# Get block return value?
# ------------------------------------------------------------------------------
# Single-line block
[1, 2, 3].each { |num| puts num }

# Multi-line block
[1, 2, 3].each do |num|
  puts num
end

puts "\n"
# ------------------------------------------------------------------------------
# Yield
def logger
  yield
end

logger { puts 'hello from the block' }

logger do
  p [1, 2, 3]
end

puts "\n"
# ------------------------------------------------------------------------------
def double_vision
  yield
  yield
end

double_vision { puts "How many fingers am I holding up?" }
puts "\n"
# ------------------------------------------------------------------------------
def love_language
  yield('Ruby')
  yield('Rails')
end

love_language { |lang| puts "I love #{lang}" }
puts "\n"
# ------------------------------------------------------------------------------
@transactions = [10, -15, 25, 30, -24, -70, 999]

def transaction_statement
  @transactions.each do |transaction|
    yield transaction
  end
end

transaction_statement do |transaction|
  p "%0.2f" % transaction
end
puts "\n"
# ------------------------------------------------------------------------------
def transaction_statement(transactions)
  transactions.each do |transaction|
    yield transaction
  end
end

transactions = [19, -19]

transaction_statement(transactions) do |transaction|
  p "%0.2f" % transaction
end
puts "\n"
# ------------------------------------------------------------------------------