require 'json'
require_relative 'lib/bot.rb'

puts 'Importing handles...'
json_handles = File.read('data/journalists.json')

puts 'Parsing JSON...'
handles = JSON.parse(json_handles)

puts 'Initializing bot...'
bot = Bot.new(handles['journalists'])

puts 'Running bot...'
puts 'Bot\'s saying hi...'
bot.say_hi

puts 'Bot\'s liking things...'
bot.like_hashtag("#bonjour_monde")

puts 'Bot\'s streaming tweets...'
bot.stream(["#bonjour_monde", "the_hacking_project"])