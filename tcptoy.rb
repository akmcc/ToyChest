require 'pry'

#this model assumes server is already in listening mode

#server
class Sender 

  attr_accessor :receipts

  def initialize
    @handshake = false
    @tcp_segments = {}
    @receipts = []
    @message = "I saw my life branching out before me like the green fig tree in the story. From the tip of every branch, like a fat purple fig, a wonderful future beckoned and winked. One f"
    
  end

  def handshake
    @handshake = true
  end

  def create_tcp_segments
    packets = split_into_packets_of(8, @message) 
    packets.each_with_index do |packet, index|
      @tcp_segments[index] = packet
    end
    @tcp_segments
  end

  def write_to(destination)
    create_tcp_segments
    if @handshake
      (Hash[@tcp_segments.to_a.reverse]).each_pair do |header, body|
        until is_acknowledged?(header)
          destination.read_buffer[header] = body
          sleep(0.2)
          destination.send_read_receipt_to(self) #not the senders job to send the read_receipt, need to move to recevier class
        end
      end
    end
  end

  def is_acknowledged?(header)
    @receipts.include?(header)
  end

  def split_into_packets_of(num, message)
    packets = []
    until message.length == 0
      packets << message.slice!(0,num)
    end
    packets
  end

end

#client
class Receiver 

  attr_accessor :read_buffer, :read_receptacle

  def initialize
    @handshake = false
  end

  def establish_connection_with(server)
    @handshake = true
    server.handshake #is it okay to have methods calling methods on instances of another class?
    @read_buffer = {}
    @read_receptacle = {}
  end

  def send_read_receipt_to(sender)
    if @handshake
      header = @read_buffer.first[0]
      body = @read_buffer.first[1]
      @read_receptacle[header] = body
      sender.receipts << header
      @read_buffer.shift
    end
  end

  def reorder_data
    @read_receptacle = Hash[@read_receptacle.sort]
  end   

  def read 
    reorder_data
    message = ""
    @read_receptacle.each_pair do |header, body|
      message += body
    end
    message
  end                 

end

sender = Sender.new
receiver = Receiver.new
receiver.establish_connection_with(sender)
sender.write_to(receiver)
pry
#receiver.read 

