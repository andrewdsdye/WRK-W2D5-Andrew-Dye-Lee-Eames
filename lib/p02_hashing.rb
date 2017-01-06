class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_sum = self.first.hash
    self.drop(1).each_with_index do |element,idx|
      next_hash = (element * idx).hash
      hash_sum -= next_hash
    end

    hash_sum
  end
end

class String
  def hash
    letters = self.split("")
    letters.map { |letter| letter.ord }.hash

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
    array = []
    self.each do |key, value|
      array << (key.hash - value.hash)
    end
    array.empty? ? 0 : array.reduce(:+)
  end
end
