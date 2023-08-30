# Blocks
# ******************************************************************************
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
def transaction_statement(transactions)
  transaction_strings = []
  transactions.each do |transaction|
    string = yield transaction
    transaction_strings << string
  end
  transaction_strings
end

transactions = [20, -20]

strings = transaction_statement(transactions) do |transaction|
  "%0.2f" % transaction
end

p strings

puts "\n"
# ------------------------------------------------------------------------------
def transaction_statement(transactions)
  transaction_strings = []
  transactions.each do |transaction|
    transaction_strings << yield(transaction)
  end
  transaction_strings
end

transactions = [21, -21]

strings = transaction_statement(transactions) do |transaction|
  "%0.2f" % transaction
end

p strings

puts "\n"
# ------------------------------------------------------------------------------
@transactions = [10, -15, 25, 30, -24, -70, 999]

def transaction_statement
  @transactions.each do |transaction|
    p yield transaction # `p` is called within our method now instead of within the block
    puts 'AFTER printing transaction'
  end
end

transaction_statement do |transaction|
  "%0.2f" % transaction
end
puts "\n"
# ------------------------------------------------------------------------------
def say_something
  yield
end

say_something do |word|
  puts "And then I said: #{word}"
end
puts "\n"
# ------------------------------------------------------------------------------
def mad_libs
  yield('cool', 'beans', 'burrito')
end

mad_libs do |adjective, noun|
  puts "I said #{adjective} #{noun}!"
end
puts "\n"
# ------------------------------------------------------------------------------
def awesome_method
  hash = {a: 'apple', b: 'banana', c: 'cookie'}

  hash.each do |key, value|
    yield key, value
  end
end

awesome_method { |key, value| puts "#{key}: #{value}" }
puts "\n"
# ------------------------------------------------------------------------------
# def simple_method
#   yield
# end

# simple_method
# puts "\n"
# ------------------------------------------------------------------------------
def maybe_block
  if block_given?
    puts 'block party'
  end

  puts 'executed regardless'
end

maybe_block
puts "\n"
maybe_block {}

puts "\n"
# ------------------------------------------------------------------------------


# Lambdas
# ******************************************************************************
my_lambda = lambda { puts 'my lambda' }

my_other_lambda = -> { puts 'hello from the other side' }

puts "\n"
# ------------------------------------------------------------------------------
my_lambda = -> { puts 'high five' }
my_lambda.call
puts "\n"

my_name = ->(name) { puts "hello #{name}" }
my_age = lambda { |age| puts "I am #{age} years old" }

my_name.call('tim')
my_age.call(78)

puts "\n"
# ------------------------------------------------------------------------------
my_name = ->(name) { puts "hello #{name}" }

my_name.call('tim')
my_name.('tim')
my_name['tim']
my_name.=== 'tim'
puts "\n"
# ------------------------------------------------------------------------------

# Procs
# ******************************************************************************
a_proc = Proc.new { puts 'this is a proc' }
a_proc.call

a_proc = proc { puts 'this is a proc' }
a_proc.call

a_proc = Proc.new { |name, age| puts "name: #{name} --- age: #{age}" }
a_proc.call('tim', 80)

puts "\n"
# ------------------------------------------------------------------------------

#               |     Block                     |      Proc                      | Lambda                     |
# Arguments:    | Does not care                 | Does not care                  | Strict                     |
# Returning:    | Returns from caller's context | Returns from caller's context  |  Returns from lambda block |
# Default args: | Supported                     | Supported                      | Supported                  | 
# Arguments: Proc = Does not care
a_proc = Proc.new { |a, b| puts "a: #{a} --- b: #{b}" }
a_proc.call('apple')
a_proc.call('cat', 'dog')
a_proc.call(['cat', 'dog'])
a_proc.call(*['cat', 'dog'])

nested_array = [[1, 2], [3, 4], [5, 6]]
p nested_array.select { |a, b| a + b > 10 }

puts "\n"

# Arguments: Lambda = Strict
a_lambda = lambda { |a, b| puts "a: #{a} --- b: #{b}" }
# a_lambda.call('apple')
# a_lambda.call('apple', 'banana', 'cake')
a_lambda.call('apple', 'banana')
# a_lambda.call(['apple', 'banana'])
a_lambda.call(*['apple', 'banana'])

puts "\n"

# Returning: Lambda = Returns from lambda block (Run in irb)
# a_lambda = -> { puts 'Returning from lambda'; return 1 }
# a_lambda.call

def my_method
  a_lambda = -> { return }
  puts 'this line will be printed'
  a_lambda.call
  puts 'this line IS reached'
end

my_method

puts "\n"

# Returning: Proc = Returns from caller's context (Run in irb = error)
# a_proc = Proc.new { return }
# a_proc.call

def my_method
  a_proc = Proc.new { return }
  puts 'this line will be printed'
  a_proc.call
  puts 'this line is never reached'
end

my_method

puts "\n"

# Default args: Proc = Supported
my_proc = Proc.new { |name='bob'| puts name }
my_proc.call

puts "\n"

# Default args: Proc = Supported
my_lambda = ->(name='r2d2') { puts name }
my_lambda.call

puts "\n"

def say_hello_and_bye
  puts 'hello'
  yield(5) if block_given?
  yield if block_given?
  puts 'bye'
end

say_hello_and_bye
# say_hello_and_bye { return }
say_hello_and_bye { |num=19| puts "num is #{num}" }

puts "\n"
# ------------------------------------------------------------------------------
# Capturing and Destructuring using Splat * and Double Splat ** operators
# Capture as Array
def print_all(*args)
  p args
end

print_all(1, 2, 3, 4, 5)

# Capture as Array
def print_all(title, *chapters)
  puts "title: #{title}"
  puts "chapters: #{chapters}"
end

print_all(1, 2, 3, 4, 5)

def testing(a, b = 1, *c, d: 1, **x)
  puts "a: #{a}"
  puts "b: #{b}"
  puts "c: #{c}"
  puts "d: #{d}"
  puts "x: #{x}"
end

testing('a', 'b', 'c', 'd', 'e', d: 2, x: 1, y: 2)

def foo(a, *b, **c)
  p [a, b, c]
end

foo(10)
foo(10, 20, 30)
foo(10, 20, 30, d: 40, e: 50)
foo(10, d: 40, e: 50)

opts = {d: 40, e: 50}
foo(10, opts, f: 60)
foo(10, **opts, f: 60)

puts "\n"
# ------------------------------------------------------------------------------
def sum(a, b)
  a + b
end

p sum(*[1, 2])
puts "\n"
# ------------------------------------------------------------------------------
