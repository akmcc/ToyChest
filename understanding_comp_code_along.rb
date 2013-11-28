class Number < Struct.new(:value)
  def to_s #does not take OoOps into account
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    false
  end
end

class Add < Struct.new(:left, :right)  
  def to_s #does not take OoOps into account
    "#{left} + #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      Number.new(left.value + right.value)
    end

  end
end

class Multiply < Struct.new(:left, :right)
  def to_s #does not take OoOps into account
    "#{left} * #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      Multiply.new(left.reduce(environment), right)
    elsif right.reducible?
      Multiply.new(left, right.reduce(environment))
    else
      Number.new(left.value * right.value)
    end
  end
end

class Boolean < Struct.new(:value)
  
  def to_s
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end
  
  def reducible?
    false
  end
end

class LessThan < Struct.new(:left, :right)
  def to_s
    "#{left} < #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      LessThan.new(left.reduce(environment), right)
    elsif right.reducible?
      LessThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value < right.value)
    end
  end
end

class GreaterThan < Struct.new(:left, :right)
  def to_s
    "#{left} > #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if left.reducible?
      GreaterThan.new(left.reduce(environment), right)
    elsif right.reducible?
      GreaterThan.new(left, right.reduce(environment))
    else
      Boolean.new(left.value > right.value)
    end
  end
end

class Variable < Struct.new(:name) #only maps variable names onto irreducible values
  def to_s
    name.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible? #how is this reducible? can be reduced to the value/expression it represents.
    true
  end

  def reduce(environment)
    environment[name]
  end
end

class DoNothing #does not inherit from Struct because it has no attributes and Struct.new does not allow for an empty attribute list
  def to_s
    "do_nothing"
  end

  def inspect
    "<<#{self}>>"
  end

  def ==(other_statement)
    other_statement.instance_of?(DoNothing)
  end

  def reducible?
    false
  end
end

class Assign < Struct.new(:name, :expression)
  def to_s
    "#{name} = #{expression}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if expression.reducible?
      [Assign.new(name, expression.reduce(environment)), environment ]
    else
      [DoNothing.new, environment.merge({ name => expression })]
    end

  end
end

class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment) #is the self necessary?
  end

  def run
    while statement.reducible? #will continuosly loop until expression is no longer reducible
      puts "#{statement}, #{environment}"
      step
    end
    puts "#{statement}, #{environment}"
  end
end


