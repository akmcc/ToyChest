#using define_method to avoid using class_eval

class MyClass

  def self.my_attr_writer(*names)
    names.each do |name|
      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
      end
    end
  end

def self.my_attr_reader(*names)
  names.each do |name|
    define_method("#{name}") do
      eval("@#{name}")
    end
  end
end

def self.my_attr_accessor(*names)
  names.each do |name|
    my_attr_reader(name)
    my_attr_writer(name)
  end
end

end


class MySubclass < MyClass
    my_attr_accessor :name, :age, :job
end
