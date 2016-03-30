# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def self.group(challenges)
  result = {depth: 0, stack: [{}]}
  lines = challenges.lines.map { |line| [line[/^ */].length/2, line.strip] }

  until lines.empty?
    depth, line = lines.shift
    while depth < result[:depth]
      result[:depth] -= 1
      result[:stack].pop
    end
    new_challenge = (result[:stack].last[line] ||= {})
    result[:stack].push(new_challenge)
    result[:depth] += 1
  end

  result[:stack].first
end


def self.seed(groups, parent)
  groups.each do |name, children|
    if children.empty?
      parent.children_challenges.build name: name
    else
      seed children, parent.children_categories.build(name: name)
    end
  end
  parent
end

test_output = <<-CHALLENGES
aside
  can be called on an object
  gives the block the object I called it on
  returns the object I called it on
  when called without a block
    raises a LocalJumpError, saying that no block was given

block challenges
  best_advice returns the first element from an array where the block returns true
    [1,5,2] which is odd?
    [1,5,2] which is a multiple of 5
    [1,5,2] which is even?
    [1,5,2] which is 8?
    [1,5,2] i like everything!
    [1,5,2] i hate everything!

blinked_list_unshift
  receives some data and a proc
  the return value
    is a new Proc
    the proc returns the data if I call it with :data
    the proc returns the link if I call it with :link
    raises an ArgumentError if given a value other than :data or :link
    bigger example

block_and_forth_forever
  receives a block, and calls it
  calls it with a block
  the block it passes receives another block and calls it
  it returns whatever the block returns
  does this indefinitely deep

block_and_forth
  receives a block, and calls it
  calls it with a block
  the block it passes doubles whatever it receives
  it returns whatever the block returns
  more sophisticated :)

block challenges
  block_to_proc
    receives a block and returns it
    this allows you to call it later
    does not call the block

block challenges
  call_twice calls the block two times
  call_thrice calls the block three times

Do
  gets initialized with a block
  if
    calls the initialize-block if invoked with a truthy value
    does not call the initialize-block if invoked with a falsy value
  unless
    calls the initialize-block if invoked with a falsy value
    does not call the initialize-block if invoked with a truthy value
  while
    calls the initialize-block for as long as the while-block returns a truthy value
  until
    calls the initialize-block for as long as the while block returns a falsy value

OnCount
  gets initialized with a count, which can be asked for later
  defaults the count to 0
  does not allow the outside world to modify the count
  turning it on and off (this will be used by the callback later)
    starts out in an on state
    can be turned off and on
    can be turned on and off conveniently
    can be turned on
  count!
    when turned on
      increments the count
      a block can be given to initialize, which will be called upon incrementing, this is called a "callback"
      returns itself
    when turned off
      increments the count
      does not call the callback when turned off
      returns itself
    when turned off and then back on
      increments the count
      a block can be given to initialized, which will be called upon incrementing, this is called a "callback"
      returns itself

PubSub
  lets code subscribe to named events
  raises a LocalJumpError when subscribe is called without a block
  calls the subscriber whenever the event is published
  allows multiple subscribers and calls them all when the event is published
  does not call the subscriber when some other event is published
  allows multiple event types to be subscribed to
  doesn't blow up when publishing without a subscriber
  allows the publisher to pass a value to all the subscribers

PubSubSimple
  lets code subscribe to events
  raises a LocalJumpError when subscribe is called without a block
  calls the subscriber whenever publish is invoked
  can replace the subscriber with a different subscriber
  doesn't blow up when publishing without a subscriber
  allows the publisher to pass a value to the subscriber

block challenges
  wrap
    receives a value and returns a block
    when you call the returned block, you get the value you passed in

block challenges
  yield_first
    when the array is empty, does nothing
    when the array is not empty, it calls the block with the first item from an array
    doesn't get confused by an array with nil in it vs an empty array

block challenges
  yield_two calls the block with both items from an array
  yield_three calls the block with three items from an array
  yield_four calls the block with four items from an array
  yield_five calls the block with five items from an array
  yield_six calls the block with six items from an array
  yield_seven calls the block with seven items from an array
  yield_eight calls the block with eight items from an array
  yield_nine calls the block with nine items from an array
  yield_ten calls the block with ten items from an array

block challenges
  yield_with_each iterates over the array using only #each and calls the block with every element
    no elements
    one element
    two elements
    100 elements

block challenges
  yield_with_while_loop iterates over the array using only #length and #[] and calls the block with every element
    no elements
    one element
    two elements
    100 elements

general recursion
  fib
    returns 0 when given 0
    returns 1 when given 1
    returns 1 when given 2
    returns 2 when given 3
    returns 3 when given 4
    returns 5 when given 5
    returns 8 when given 6
    returns 13 when given 7
    returns 21 when given 8
    returns 34 when given 9
    returns 55 when given 10
    returns 89 when given 11
    returns 144 when given 12
    returns 233 when given 13
    returns 377 when given 14
    returns 610 when given 15
    returns 987 when given 16
    returns 1597 when given 17
    returns 2584 when given 18
    returns 4181 when given 19

general recursion
  spiral_access
    does not call the block when there is nothing to iterate over
    1 by 1
    2 by 2
    3 by 3
    the example
    6 by 6
    chars instead of ints
    2 by 3
    3 by 2

general recursion
  two_to_the
    returns 1 when given 0
    returns 2 when given 1
    returns 4 when given 2
    returns 8 when given 3
    returns 16 when given 4
    returns 32 when given 5
    returns 64 when given 6
    returns 128 when given 7
    returns 256 when given 8
    returns 512 when given 9
    returns 1024 when given 10
    returns 2048 when given 11
    returns 4096 when given 12
    returns 8192 when given 13
    returns 16384 when given 14
    returns 32768 when given 15
    returns 65536 when given 16
    returns 131072 when given 17
    returns 262144 when given 18
    returns 524288 when given 19

Render::HTML
  is a module so that we can include it to gain access to its methods, without putting them on Object
  #html
    sets an html doctype
    has a highest level element of html
    has a head within the html
    has a body
    can be given a title to add
    defaults the title to "untitled"
    can be given text to place within the body
    defaults the body to empty
  #paragraph
    renders a paragraph tag
    places the text within the paragraph
    defaults the paragraph text to empty
  #header
    returns an h at the specified level
    defaults the level to 1
    raises an ArgumentError if the level is not 1, 2, 3, 4, 5, or 6
    renders the text
    defaults the text to an empty string
  #italics
    returns an em tag
    renders the text
    defaults the text to an empty string
  #bold
    returns a strong tag
    renders the text
    defaults the text to an empty string
  #link
    returns an a tag
    renders the text
    defaults the text to an empty string
    accepts a location to link to
    defaults the location to a hash (empty document fragment)
  #image
    returns an img tag
    accepts a source
    defaults the source to an empty string
    puts nothing inside the image
  #preserve_formatting
    returns a pre tag
    places the text within the pre tag
    defaults the text to empty
  #block
    returns a div
    renders the text within the div
    defaults the text to empty
    accepts an array of classes that it adds to the div with spaces separating the elements
    does not add classes when none are provided
  #inline
    returns a span
    renders the text within the span
    defaults the text to empty
    accepts an array of classes that it adds to the source
    does not add classes when it is not told to
  #list
    returns an ordered list when told to be ordered
    returns an unordered list when told to not be ordered
    returns an unordered list when not told whether it should be ordered
    accepts a collection of items to place in li tags within the list
    adds no items, by default
  acceptance test
    can create some reasonably useful html

StringInput
  closing
    close_read
      returns nil
    closed_read?
      returns whether close_read has been called
    close_write
      returns nil
    closed_write?
      returns whether close_write has been called
    close
      returns nil
      closes the read end and write end
    closed?
      is false when only the read end is closed
      is false when only the write end is closed
      is true when both read and write are closed
      which is the case when #close has been called
    when the read end is closed
      #gets raises IOError
      #read raises IOError
      #getc raises IOError
      #eof? raises IOError

StringInput
  iterating / collections
    each_char
      receives a block and calls it once for each char of the input
      returns the input object
      consumes the input
      is affected by modifications to the input that occur during iteration
    each_line
      receives a block and calls it once for each line of the input
      returns the input object
      consumes the input
      is affected by modifications to the input that occur during iteration
    each -- a shorthand for each_line
      receives a block and calls it once for each line of the input
      returns the input object
      consumes the input
      is affected by modifications to the input that occur during iteration
    readlines
      returns an array of the lines of input

StringInput
  reading input
    gets
      consumes and returns the input until it finds a newline
      consumes to the end of the input, if there is no newline
      returns nil when there is no more input
      considers a newline all by itself to be a line
      does all of these together
      only considers the newline and end-of-input as line-ends
    read
      consumes the rest of the input
      returns an empty string when there is no input
      returns an empty string when there is no more input
    getc
      consumes the next character of input
      returns nil when there is no more input
    eof? (end of "file")
      returns whether it is out of input
      considers any unconsumed characters, including newlines to be input
      works with gets
      works with read
      works with getc
    all of these together
      they are all consuming the same input, so they all work together

StringInputOutput
  closing
    close_read
      returns nil
    closed_read?
      returns whether close_read has been called
    close_write
      returns nil
    closed_write?
      returns whether close_write has been called
    close
      returns nil
      closes the read end and write end
    closed?
      is false when only the read end is closed
      is false when only the write end is closed
      is true when both read and write are closed
      which is the case when #close has been called
    when the read end is closed
      #gets raises IOError
      #read raises IOError
      #getc raises IOError
      #eof? raises IOError

StringInputOutput
  closing
    close_read
      returns nil
    closed_read?
      returns whether close_read has been called
    close_write
      returns nil
    closed_write?
      returns whether close_write has been called
    close
      returns nil
      closes the read end and write end
    closed?
      is false when only the read end is closed
      is false when only the write end is closed
      is true when both read and write are closed
      which is the case when #close has been called
    when the read end is closed
      #print raises IOError
      #puts raises IOError
      #write raises IOError
      #<< raises IOError
      #printf raises IOError

StringInputOutput
  iterating / collections
    each_char
      receives a block and calls it once for each char of the input
      returns the input object
      consumes the input
      is affected by modifications to the input that occur during iteration
    each_line
      receives a block and calls it once for each line of the input
      returns the input object
      consumes the input
      is affected by modifications to the input that occur during iteration
    each -- a shorthand for each_line
      receives a block and calls it once for each line of the input
      returns the input object
      consumes the input
      is affected by modifications to the input that occur during iteration
    readlines
      returns an array of the lines of input

StringInputOutput
  reading input
    gets
      consumes and returns the input until it finds a newline
      consumes to the end of the input, if there is no newline
      returns nil when there is no more input
      considers a newline all by itself to be a line
      does all of these together
      only considers the newline and end-of-input as line-ends
    read
      consumes the rest of the input
      returns an empty string when there is no input
      returns an empty string when there is no more input
    getc
      consumes the next character of input
      returns nil when there is no more input
    eof? (end of "file")
      returns whether it is out of input
      considers any unconsumed characters, including newlines to be input
      works with gets
      works with read
      works with getc
    all of these together
      they are all consuming the same input, so they all work together

StringInputOutput
  #string
    lets me see what was printed
  writing output
    #print
      returns nil
      prints into an internal string
      can be given multiple arguments to print
      prints what its arguments return from to_s
      does not modify the input or the input's to_s
    #puts
      returns nil
      prints the argument.to_s and a newline
      does not print a newline if there is already one at the end of the thing to print
      prints an empty line if called with no arguments
      can be given multiple arguments to print
      does not modify the input or the input's to_s
    #write
      prints the string
      prints what its arguments return from to_s
      returns the number of bytes printed -- use pry to list out what strings can do and grep for things dealing with bytes
      does not modify the input or the input's to_s
    <<
      prints the string
      prints what its arguments return from to_s
      returns the object
      does not modify the input or the input's to_s
    printf -- delegate the hard work to Kernel#sprintf or String#%
      returns nil
      receives a format string, and arguments, which it formats accordingly and prints into the string

StringOutput
  closing
    close_read
      returns nil
    closed_read?
      returns whether close_read has been called
    close_write
      returns nil
    closed_write?
      returns whether close_write has been called
    close
      returns nil
      closes the read end and write end
    closed?
      is false when only the read end is closed
      is false when only the write end is closed
      is true when both read and write are closed
      which is the case when #close has been called
    when the read end is closed
      #print raises IOError
      #puts raises IOError
      #write raises IOError
      #<< raises IOError
      #printf raises IOError

StringOutput
  #string
    lets me see what was printed
  writing output
    #print
      returns nil
      prints into an internal string
      can be given multiple arguments to print
      prints what its arguments return from to_s
      does not modify the input or the input's to_s
    #puts
      returns nil
      prints the argument.to_s and a newline
      does not print a newline if there is already one at the end of the thing to print
      prints an empty line if called with no arguments
      can be given multiple arguments to print
      does not modify the input or the input's to_s
    #write
      prints the string
      prints what its arguments return from to_s
      returns the number of bytes printed -- use pry to list out what strings can do and grep for things dealing with bytes
      does not modify the input or the input's to_s
    <<
      prints the string
      prints what its arguments return from to_s
      returns the object
      does not modify the input or the input's to_s
    printf -- delegate the hard work to Kernel#sprintf or String#%
      returns nil
      receives a format string, and arguments, which it formats accordingly and prints into the string

Ooll - Object Oriented Linked List
  bootstrapping #[] and #unshift
    bracket access on an empty list returns nil
    unshift returns the list
    unshift adds an item to the front, brackets at 0 returns the item at the front
    unshift moves the item that used to be at the front to the second position, brackets at 1 returns the second position
    this continues indefinitely far out
    brackets return nil if asked for an item past the end of the list
  #shift
    returns the first item
    removes the first item
    returns nil if there are no items in the list
  #<<
    returns the list
    adds an item to the end of the list
  #pop
    returns the item at the end of the list
    returns nil if there are no items in the list
    removes the item at the end of the list
      when there is only one item
      when there are two items
      when there are many items
  #join
    returns an empty string when given an empty list
    returns its head's to_s when it only has a head
    returns each of its items to_s, concatenated, when not given a delimiter
    defaults the delimiter to an empty string
    uses an empty string as a delimiter, if the delimiter is nil
    uses the result of to_str, if the delimiter is not a string, and has a to_str method
    raises a TypeError if to_str returns something that isn't a String
    raises a TypeError of the delimiter isn't a string and doesn't have a to_str method
  #==
    returns false if compared to a non-list
    returns true if both lists are empty
    returns true if all the elements are the same
    returns false if the left list has fewer elements
    returns false if the right list has fewer elements
    returns false if any of the elements are not ==
    does not modify the lists

preparing Ooll for Iterable
  Ooll.[]
    I know how to declare methods on the singleton class
    I know how to make a method that takes an arbitrary number of arguments
    If you don't know what to do from the previous two
    is a method that can be called on Ooll directly
    is not defined on classes generally
    returns an empy list when called with no args
    returns a list with just the item in it, when given one item
    returns a list with multiple items, in order, when given multiple items
    can take an arbitrary number of args, and adds them all into the list
  each
    I know how to do declare my own each method
    does not call the block when the list is empty
    calls the block with the item when there is one item in the list
    calls the block with each of the items in the list, when there are many items in the list
    returns the list
    does not modify the list
  Iterable and Ooll
    I know what a module is and what inclusion allows
    I know there are challenges specifically for module inclusion
    I know the code for Iterable goes in the file iterable.rb
    I know my Ooll is the one that should require it
    Iterable is a module
    Iterable is included into Ooll

Iterable
  I have doen parts 1 and 2
  I'm ultimately building my own Enumerable module, for my list instead of arrays
  I'm able to define each and map for array
  to_a returns an array of the items iterated over
  find returns the first item where the block returns true
  find_all returns all the items where the block returns true
  map returns an array of elements that have been passed through the block
  all? returns true if the block returns true for each item in the array
  any? returns true if the block returns true for any item in the array
  none? returns true if the block returns false for each item in the array
  include? returns true if the item is in the collection
  each_with_object hands the block the item, and an object, and returns the object
  take returns the first available n items
  drop returns whatever items wouldn't get taken by take
  count
    returns how many items the block returns true for
    returns how many items are in the array, if no block is given
  inject
    passes an aggregate value through the block, along with each element
    can take a symbol, and call the method of that name in place of the block
    prefers the symbol to the block
  first
    returns the first item in the collection
    delegates to take, if given a number to take
  min_by
    returns the smallest element, compared by the return values from the block
    returns the first seen, when there are multiple results with the same value
  max_by
    returns the largest element, compared by the return values from the block
    returns the first seen, when there are multiple results with the same value

linked list functions
  list_at
    returns nil when asked for an item in an empty list
    returns nil when asked for an item well into an empty list
    returns nil when asked for an item past the end of a list with items in it
    returns nil when asked for an item well past the end of a list with items in it
    finds the first item when asked for index 0
    finds the first item when asked for index 1
    finds each item in a long list

linked list functions
  list_first
    returns nil for an empty list
    returns the data of the first item, when there is one item
    returns the data of the first item, when there is more than one item

linked list functions
  list_insert
    when told to insert at position 0
      adds a new node at the head
      sets that node's data to the inserted data
      sets the old head as that node's link
      returns the list
    when told to insert at a position other than 0, and there is a node there
      adds a new node at the specified index
      sets that node's data to the inserted data
      sets the node that used to be at that position as that node's link
      doesn't change the intermediate nodes
      returns the list
    when told to insert at a position other than 0, and there are not enough nodes there
      creates a head node if one does not exist
      creates all the intermediate nodes up to that position
      sets all intermediate node's data to nil
      sets the last intermediate node's link to be the new node
      sets the new node's data to the inserted data
      sets the new node's link to be nil
      adds to the end of the last node, when nodes do exist
      returns the list

linked list functions
  list_join
    when not given a delimiter
      returns an empty string when given an empty list
      returns its head's to_s when it only has a head
      returns each of its items to_s, concatenated
    when given a delimiter
      returns an empty string when given an empty list
      returns its head's to_s when it only has a head
      returns each of its items to_s, concatenated, with the delimiter concatenated between each

linked list functions
  list_last
    returns nil for an empty list
    returns the first item when there is only one
    returns the last item when there is more than one

linked list functions
  list_max
    returns nil for the empty list
    returns the first item when there is only one
    returns the item that is greater than the others, when there is more than one
      ("a" -> "b" -> "c") returns "c"
      ("a" -> "c" -> "b") returns "c"
      ("b" -> "a" -> "c") returns "c"
      ("b" -> "c" -> "a") returns "c"
      ("c" -> "b" -> "a") returns "c"
      ("c" -> "a" -> "b") returns "c"
      (100 -> 45 -> 300)  returns 300

linked list functions
  list_min
    returns nil for the empty list
    returns the first item when there is only one
    returns the item that is less than the others, when there is more than one
      ("a" -> "b" -> "c") returns "a"
      ("a" -> "c" -> "b") returns "a"
      ("b" -> "a" -> "c") returns "a"
      ("b" -> "c" -> "a") returns "a"
      ("c" -> "b" -> "a") returns "a"
      ("c" -> "a" -> "b") returns "a"
      (100 -> 45 -> 300)  returns 45
      A larger example

linked list functions
  list_shift
    returns nil when the list is empty
    returns the first item when there is an element in the list
    removes the first item from the list
    a bigger example

linked list functions
  list_size
    is 0 for an empty list
    is 1 for a list with one item
    is 2 for a list with two items
    is 3 for a list with three items
    does not care what is in the list

linked list functions
  list_unshift
    inserts an item at the head of the list
    returns the list itself

list recursion
  NilNode
    always has data of nil
    does not have a data=
    links to itself
    does not have a link=
    has a length of 0
    has a min of nil
    has a max of nil
    #first returns nil
    #last returns nil
    is empty
    returns true when asked if it is nil?
    #[] returns nil
      at 0
      at 1
      at 100
    insertion
      at 0
        returns a normal node
        with the inserted data
        whose link is a nilnode
      at 1
        returns a normal node
        with data of nil
        whose link is the same as inserting at 0
      at 3
        returns a normal node
        with data of nil
        whose link is the same as inserting at 2
  NormalNode
    has data of whatever it was initialized with
    does not have a data=
    has a link is whatever it was initialized with
    does not have a link=
    #first returns its data
    has a length of 1 more than its link's length
      one deep
      two deep
    min
      returns its data when its link is a NilNode
      returns its data when its data is less than its links data
      returns its links data when its links data is less than its data
      does not depend on its link's data for verifying correctness
    max
      returns its data when its link is a NilNode
      returns its data when its data is greater than its links data
      returns its links data when its links data is greater than its data
      does not depend on its link's data for verifying correctness
    #last
      returns its data when its link is a nil node
      returns its link's data when its link is not a nil node
      even if its link's data is nil
    #empty?
      is not empty
      even if its data is nil
    #nil?
      returns false when asked if it is nil?
      even if its data is nil
    #[]
      when asked for the data at index 0, it returns its own data
      otherwise it returns its link's result for one index lower
      a more challenging example
    insertion
      at index 0
        returns a new normal node
        the returned node has the data
        and the returned node's link is the node we called insert on
        the node we called insert on is not modified
      otherwise
        returns a normal node
        the returned node has the current node's data
        the returned node's link includes the inserted item at the correct position
        it does not modifty the node we called the insert on

modules as "mixins"... aka using include to change inheritance
  define a module named MahMixin
  MahMixin::Equality
    is not available at the toplevel
    is available from within MahMixin
    `left < right` returns true when the left object is less than the right
      returns false if the space ship operator returns zero
      returns true if the space ship operator returns a negative value
      returns false if the space ship operator returns a positive value
      raises an ArgumentError with the compared class names, if the space ship returns nil
    `left <= right` returns true when the left object is less than or equal to the right
      returns true if the space ship operator returns zero
      returns true if the space ship operator returns a negative value
      returns false if the space ship operator returns a positive value
      raises an ArgumentError if the space ship returns nil
    `left > right` returns true when the left object is greater than
      returns false if the space ship operator returns zero
      returns true if the space ship operator returns a positive value
      returns false if the space ship operator returns a negative value
      raises an ArgumentError if the space ship returns nil
    `left >= right` returns true when the left object is greater than or equal to the right
      returns true if the space ship operator returns zero
      returns true if the space ship operator returns a positive value
      returns false if the space ship operator returns a negative value
      raises an ArgumentError if the space ship returns nil
    `left == right` returns true when the left object is equal to
      returns true if the space ship operator returns zero
      returns false if the space ship operator returns a positive value
      returns false if the space ship operator returns a negative value
      returns false if the space ship returns nil
    between?
      returns false when the object is less than the first arg
      even if it is also greater than the second (makes no sense, I know)
      returns false when the object is greater than the second arg
      even if it is also less than the first (makes no sense, I know)
      returns true when the object is greater than the first and less than the second
      returns true when the object is equal to the first and less than the second
      returns true when the object is greater than the first and equal to the second
      returns true when the object is equal to both
      returns false when the object is equal to the first and greater than the second
      returns false when the object is less than the first and equal to the second
      raises an ArgumentError if the space ship returns nil for the left argument
      does not raise an error if it is ruled out by the first argument before it is compared to the second argument, even if the second argument would be nil
      raises an ArgumentError if the space ship returns nil for the right argument
    defined methods
      only defines the methods <, <=, >, >=, ==, and between?
  MahMixin::User
    is not available at the toplevel
    is available from within MahMixin
    users have a name and age
    ordering users users
      cannot be compared to a non-user
      when the left user is younger than the right user
        is ordered earlier
      when the left user is older than the right user
        is ordered later
      when the left user is the same age as the right user
        name comparisons are not case sensitive
        when the left user's name is alphabetically earlier
          is ordered earlier
        when the left user's name is alphabetically later
          is ordered later
        when all the letters match
          the one whose name is shorter is earlier
        when the names are the same length
          considers them equivalent

modules as namespaces
  define a module MahMod
  define a module MahMod::A
  define a module MahMod::B
  define a MahMod::A::C with a value of 1
  define a MahMod::B::C with a value of 2
  MahMod.find_c (you can do this as a method on the singleton class)
    finds MahMod::A::C when given MahMod::A
    finds MahMod::B::C when given MahMod::B
    finds <ArbitraryMod>::C when given <ArbitraryMod>
  MahMod::String
    is the toplevel String class
  MahMod::Dir
    is the string "These aren't the Dirs you're looking for"
    MahMod.mah_dir returns MahMod's Dir (do this without referencing MahMod)
    top_dir returns the normal Dir class
  MahMod.make_mod
    returns a module
    is an anonymous module (not assigned to a constant)
    returns a different module every time
    sets its argument as a constant named ARG (use Module#set_const)
  MahMod::List, a linked list using constants
    do what you need to do to make this example work
CHALLENGES


groups = group(test_output)
Category.create! name: 'root' do |root|
  seed(groups, root)
end
