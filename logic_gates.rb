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
    out = Nand.new(left, right).run
    Not.new(out).run
  end
end

class Or < Struct.new(:left, :right)
  def run
    out1 = Nand.new(left, left).run
    out2 = Nand.new(right, right).run
    Nand.new(out1, out2).run
  end
end

class Nor < Struct.new(:left, :right)
  def run
    out = Or.new(left, right).run
    Not.new(out).run
  end
end

class Xor < Struct.new(:left, :right)
  def run
    out1 = Not.new(left).run
    out2 = And.new(out1, right).run
    out3 = Not.new(right).run
    out4 = And.new(left, out3).run
    Or.new(out2, out4).run
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