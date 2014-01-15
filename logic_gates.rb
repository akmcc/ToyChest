require 'minitest/autorun'

class Binary < Struct.new(:bit)
  def inspect
    "Binary.new(#{bit})"
  end
end

#nand is the primitive
class Nand < Struct.new(:left, :right)
  def run
    if left == Binary.new(1) && right == Binary.new(1)
      Binary.new(0)
    else
      Binary.new(1)
    end
  end
end

class Not < Struct.new(:binary)
  def run
    Nand.new(binary, binary).run
  end
end

class And < Struct.new(:left, :right)
  def run
    nand = Nand.new(left, right).run
    Not.new(nand).run
  end
end

class Or < Struct.new(:left, :right)
  def run
    nand1 = Nand.new(left, left).run
    nand2 = Nand.new(right, right).run
    Nand.new(nand1, nand2).run
  end
end

class Nor < Struct.new(:left, :right)
  def run
    or1 = Or.new(left, right).run
    Not.new(or1).run
  end
end

class Xor < Struct.new(:left, :right)
  def run
    not_left = Not.new(left).run
    and1 = And.new(not_left, right).run
    not_right = Not.new(right).run
    and2 = And.new(left, not_right).run
    Or.new(and1, and2).run
  end
end

#selector decided which output is given
# if selector is 0, left is output, if selector is 1, right is output
class Multiplexor < Struct.new(:left, :right, :selector)
  def run
    not_right = Not.new(right).run
    and1 = And.new(left, not_right).run
    not_selector = Not.new(selector).run
    and2 = And.new(and1, not_selector).run
    and3 = And.new(left, right).run
    and4 = And.new(not_selector, and3).run
    not_left = Not.new(left).run
    and5 = And.new(not_left, right).run
    and6 = And.new(and5, selector).run
    and7 = And.new(left, right).run
    and8 = And.new(and7, selector).run
    or1 = Or.new(and6, and8).run
    or2 = Or.new(and2, and4).run
    Or.new(or1, or2).run
  end
end

###### tests ######

describe 'Not' do 

  it "should return 0 if binary is 1" do 
    result = Not.new(Binary.new(1)).run
    result.must_equal Binary.new(0)
  end

  it "should return 1 if binary is 0" do 
    result = Not.new(Binary.new(0)).run
    result.must_equal Binary.new(1)
  end
end

describe 'And' do 

  it "should return 0 if left is 0 and right is 0" do
    result = And.new(Binary.new(0),Binary.new(0)).run
    result.must_equal Binary.new(0)
  end

  it "should return 0 if left is 0 and right is 1" do
    result = And.new(Binary.new(0),Binary.new(1)).run
    result.must_equal Binary.new(0)
  end  

  it "should return 0 if left is 1 and right is 0" do
    result = And.new(Binary.new(1),Binary.new(0)).run
    result.must_equal Binary.new(0)
  end 

  it "should return 1 if left is 1 and right is 1" do
    result = And.new(Binary.new(1),Binary.new(1)).run
    result.must_equal Binary.new(1)
  end 
end

describe 'Or' do 

  it "should return 0 if left is 0 and right is 0" do
    result = Or.new(Binary.new(0),Binary.new(0)).run
    result.must_equal Binary.new(0)
  end

  it "should return 1 if left is 0 and right is 1" do
    result = Or.new(Binary.new(0),Binary.new(1)).run
    result.must_equal Binary.new(1)
  end  

  it "should return 1 if left is 1 and right is 0" do
    result = Or.new(Binary.new(1),Binary.new(0)).run
    result.must_equal Binary.new(1)
  end 

  it "should return 1 if left is 1 and right is 1" do
    result = Or.new(Binary.new(1),Binary.new(1)).run
    result.must_equal Binary.new(1)
  end 
end

describe 'Nand' do 

  it "should return 1 if left is 0 and right is 0" do
    result = Nand.new(Binary.new(0),Binary.new(0)).run
    result.must_equal Binary.new(1)
  end

  it "should return 1 if left is 0 and right is 1" do
    result = Nand.new(Binary.new(0),Binary.new(1)).run
    result.must_equal Binary.new(1)
  end  

  it "should return 1 if left is 1 and right is 0" do
    result = Nand.new(Binary.new(1),Binary.new(0)).run
    result.must_equal Binary.new(1)
  end 

  it "should return 0 if left is 1 and right is 1" do
    result = Nand.new(Binary.new(1),Binary.new(1)).run
    result.must_equal Binary.new(0)
  end 
end

describe 'Nor' do 

  it "should return 1 if left is 0 and right is 0" do
    result = Nor.new(Binary.new(0),Binary.new(0)).run
    result.must_equal Binary.new(1)
  end

  it "should return 0 if left is 0 and right is 1" do
    result = Nor.new(Binary.new(0),Binary.new(1)).run
    result.must_equal Binary.new(0)
  end  

  it "should return 0 if left is 1 and right is 0" do
    result = Nor.new(Binary.new(1),Binary.new(0)).run
    result.must_equal Binary.new(0)
  end 

  it "should return 0 if left is 1 and right is 1" do
    result = Nor.new(Binary.new(1),Binary.new(1)).run
    result.must_equal Binary.new(0)
  end 
end

describe 'Xor' do 

  it "should return 0 if left is 0 and right is 0" do
    result = Xor.new(Binary.new(0),Binary.new(0)).run
    result.must_equal Binary.new(0)
  end

  it "should return 1 if left is 0 and right is 1" do
    result = Xor.new(Binary.new(0),Binary.new(1)).run
    result.must_equal Binary.new(1)
  end  

  it "should return 1 if left is 1 and right is 0" do
    result = Xor.new(Binary.new(1),Binary.new(0)).run
    result.must_equal Binary.new(1)
  end 

  it "should return 0 if left is 1 and right is 1" do
    result = Xor.new(Binary.new(1),Binary.new(1)).run
    result.must_equal Binary.new(0)
  end 
end

describe 'Multiplexor' do 

  # 000 means left is zero right is zero and selector is zero
  # 101 means left is one right is zero and selector is one 
  # 100 means left is one right os zero and selector is zero
 
  it "should return 0 with 000" do
    result = Multiplexor.new(Binary.new(0), Binary.new(0), Binary.new(0)).run
    result.must_equal Binary.new(0)
  end

  it "should return 0 with 010" do
    result = Multiplexor.new(Binary.new(0), Binary.new(1), Binary.new(0)).run
    result.must_equal Binary.new(0)
  end

  it "should return 1 with 100" do
    result = Multiplexor.new(Binary.new(1), Binary.new(1), Binary.new(0)).run
    result.must_equal Binary.new(1)
  end

  it "should return 1 with 110" do
    result = Multiplexor.new(Binary.new(1), Binary.new(1), Binary.new(0)).run
    result.must_equal Binary.new(1)
  end

  it "should return 0 with 001" do
    result = Multiplexor.new(Binary.new(0), Binary.new(0), Binary.new(1)).run
    result.must_equal Binary.new(0)
  end

  it "should return 1 with 011" do
    result = Multiplexor.new(Binary.new(0), Binary.new(1), Binary.new(1)).run
    result.must_equal Binary.new(1)
  end

  it "should return 0 with 101" do
    result = Multiplexor.new(Binary.new(1), Binary.new(0), Binary.new(1)).run
    result.must_equal Binary.new(0)
  end

  it "should return 1 with 111" do
    result = Multiplexor.new(Binary.new(1), Binary.new(1), Binary.new(1)).run
    result.must_equal Binary.new(1)
  end
end