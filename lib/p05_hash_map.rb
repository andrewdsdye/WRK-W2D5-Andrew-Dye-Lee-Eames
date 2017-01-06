require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    list_bucket = bucket(key)

    if list_bucket.include?(key)
      list_bucket.update(key, val)
    else
      list_bucket.append(key, val)
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |linked_list|
      # debugger
      linked_list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end


  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    key_vals = []
    self.each do |key, value|
      key_vals << [key, value]
    end

    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    key_vals.each do |pair|
      set(pair.first, pair.last)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    hash_value = key.hash
    remainder = hash_value % num_buckets
    @store[remainder]
  end
end
