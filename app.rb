require 'json'
require_relative 'lib/bot.rb'

puts 'Importing handles...'
json_handles = File.read('data/journalists.json')

puts 'Parsing JSON...'
handles = JSON.parse(json_handles)

puts 'Initializing bot...'
bot = Bot.new(handles['journalists'])

puts 'Running bot...'
bot.say_hi
#bot.run