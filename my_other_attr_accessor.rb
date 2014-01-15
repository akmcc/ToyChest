#classes subclasses from MyClass will have access to my_attr_accessor

class MyClass

  def self.my_attr_writer(*names)
    names.each do |name|
      class_eval("def #{name}=(value); @#{name} = value; end")
    end
  end

  def self.my_attr_reader(*names)
    names.each do |name|
      class_eval("def #{name}; @#{name}; end")
    end
  end

  def self.my_attr_accessor(*names)
    names.each do |name|
      my_attr_reader(name)
      my_attr_writer(name)
    end
  end

end
