require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    each { |link| return link.val if link.key == key }
  end

  def include?(key)
    current_link = first
    until current_link == tail
      return true if current_link.key == key
      current_link = current_link.next
    end
    false
  end

  def append(key, val)
    #append relies on last, create new link and assigne key/value, point prev to
    #last, and point last's next to created link
    new_link = Link.new(key, val)

    last.next = new_link
    new_link.prev = last
    new_link.next = tail
    tail.prev = new_link
  end

  def update(key, val)
    each do |link|
      if link.key == key
        link.val = val
        return
      end
    end
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
      end
    end
  end

  def each(&prc)
    current_link = first
    until current_link == tail
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
