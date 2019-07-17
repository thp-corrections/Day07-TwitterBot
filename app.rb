require 'json'
require_relative 'lib/bot.rb'

puts 'Importing handles...'
json_handles = File.read('data/journalists.json')

puts 'Parsing JSON...'
handles = JSON.parse(json_handles)

puts 'Initializing bot...'
# Bot.new(handles['journalists'])