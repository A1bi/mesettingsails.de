module RandomUniqueAttribute
  extend ActiveSupport::Concern
  
  protected
  
  def set_random_unique_number(attr, digits)
    min = 10 ** (digits - 1)
    max = 10 ** digits - min
    set_attr attr do
      min + SecureRandom.random_number(max)
    end
  end
  
  def set_random_unique_token(attr, length = nil)
    length = length / 2 if length
    set_attr attr do
      SecureRandom.hex length
    end
  end
  
  def set_attr(attr, &block)
    begin
      self[attr] = block.call
    end while self.class.exists?(attr => self[attr])
  end

  module ClassMethods
    def has_random_unique_number(attr, digits)
      before_create do |record|
        record.set_random_unique_number(attr, digits)
      end
    end
    
    def has_random_unique_token(attr, length = nil)
      before_create do |record|
        record.set_random_unique_token(attr, length)
      end
    end
  end
end
