require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(input)
    return if include?(input)
    @count += 1
    self[input] << input
    resize! if count == num_buckets
  end

  def remove(input)
    self[input].delete(input) if include?(input)
  end

  def include?(input)
    self[input].each do |element|
      return true if element == input
    end

    false
  end

  private

  def [](input)
    # optional but useful; return the bucket corresponding to `input`
    remainder = input.hash % num_buckets
    @store[remainder]
  end

  def num_buckets
    @store.length
  end

  def resize!
    #increase size of buckets by creating new array
    elements = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    elements.each do |bucket|
      bucket.each do |element|
        self.insert(element)
      end
    end
  end
end
