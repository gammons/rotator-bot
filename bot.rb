require "slack-ruby-client"

Slack.configure do |config|
  config.token = ENV["SLACK_API_TOKEN"]
end

class Rotation
  attr_reader :members, :name

  def initialize(name)
    @name = name
    @members = []
  end

  def add_member(member)
    @members << member
  end

  def remove_member(member)
    @members.reject! { |m| m == member }
  end
end

class RotationManager
  attr_reader :rotations

  def initialize
    @rotations = []
  end

  def add_rotation(rotation)
    @rotations << rotation
  end

  def remove_rotation(rotation_name)
    @rotations.reject! { |r| r.name == rotation_name }
  end
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "HELLO"
end

client.on :message do |data|
  puts "MESSAGE"
  client.message(channel: data.channel, text: "asdf")
end

client.start!

# Manager = RotationManager.new

# class RotatorBotServer < SlackRubyBot::Server
#   on "hello" do |client, data|
#     client.say(text: "hello!", channel: data.channel)
#   end
# end
#
# class RotatorBot < SlackRubyBot::Bot
#   command "new" do |client, data, _match|
#     Manager.add_rotation(Rotation.new(data.text.split.last))
#     client.say(text: "ok", channel: data.channel)
#   end
#
#   command "list" do |client, data, _match|
#     client.say(text: "I know about these rotations: #{Manager.rotations.map(&:name).join("\n")}", channel: data.channel)
#     Manager.add_rotation(Rotation.new(data.text.split.last))
#   end
# end
#
# RotatorBot.run
