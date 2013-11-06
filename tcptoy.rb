# examples of packets:
# {type: "handshake", reply_to: "sender"}
# {type: "data", data: "blah blah message blah", id: 1}
# {type: "receipt", id: 1}
# other potential packets:
# {type: "data_start", data_stop_id: 35}
# OR
# {type: "data_start"}
# {type: "data_stop"}

class Communicator

  attr_accessor :partner
  received_data = []

  def in(packet)
    if packet[type] == handshake
      #make sender your connection partner and send handshake packet back to sender
    elsif packet[type] == data
      received_data << packet
    elsif packet[type] == receipt
      #do something else, not sure what yet
    end
  end

  def out(packet)

  end
end

sender = Communicator.new
receiver = Communicator.new






