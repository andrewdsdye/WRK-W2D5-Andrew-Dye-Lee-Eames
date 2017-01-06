class MaxIntSet

  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    store[num] = false
  end

  def include?(num)
    store[num] ? true : false
  end

  private
  attr_reader :store

  def is_valid?(num)
    return false if num > store.count - 1 || num < 0
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    #find bucket, check inclusion, push into bucket
    self[num] << num unless include?(num)
  end

  def remove(num)
    #check if num's included. delete if it is
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].each do |element|
      return true if element == num
    end

    false
    #iterate over num's bucket to check if it's there
  end

  private

  def [](num)
    #allow you to directly access num's bucket
    # optional but useful; return the bucket corresponding to `num`
    remainder = num % num_buckets
    @store[remainder]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if include?(num)
    @count += 1
    self[num] << num
    resize! if count == num_buckets
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].each do |element|
      return true if element == num
    end

    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    remainder = num % num_buckets
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
