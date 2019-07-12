module Bitmex
  class Mash < Hashie::Mash
    disable_warnings

    attr_reader :rest, :websocket

    def initialize(hash, rest = nil, websocket = nil)
      super(hash)
      @rest = rest
      @websocket = websocket
    end

    def order
      Bitmex::Order.new rest, websocket, orderID
    end
  end
end
