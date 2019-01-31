require 'spec_helper'

RSpec.describe Bitmex::Chat do
  let(:client) { Bitmex::Client.new testnet: true, api_key: ENV['API_KEY'], api_secret: ENV['API_SECRET'] }

  describe '#messages' do
    it 'with rest api' do
      messages = client.chat.messages channel_id: 1, count: 10, reverse: true
      expect(messages.size).to eq 10
      expect(messages.first.channelID).to eq 1
      expect(messages.first.message).not_to be_nil
    end
    it 'with websocket api'
  end

  it '#channels' do
    channels = client.chat.channels
    expect(channels.size).to eq 7
    expect(channels.first.id).to eq 1
    expect(channels.first.name).to eq 'English'
  end

  describe '#stats' do
    it 'with rest api' do
      stats = client.chat.stats
      expect(stats.users).to be > 0
      expect(stats.bots).to be > 0
    end
    it 'with websocket api'
  end

  xit '#send' do
    message = client.chat.send 'Hi, here is bitmex-api-ruby test bot.'
    expect(message.message).to include 'bitmex-api'
    expect(message.channelID).to eq 1
  end
end
