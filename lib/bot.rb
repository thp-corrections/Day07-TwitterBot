require 'twitter'
require 'dotenv'
require 'pry'

class Bot
  attr_reader :handles, :rest_client, :stream_client

  def initialize(handles)
    Dotenv.load('.env')

    initialize_rest_client
    initialize_stream_client
    @handles = handles
  end

  def say_hi
    random_handles = handles.sample(5)
    random_handles.each { |handle| @rest_client.update("#{handle} J'adore ce que vous faites #bonjour_monde") }
  end

  def like_hashtag(hashtag)
    results = rest_client.search(hashtag)
    rest_client.favorite(results.to_a)
  end

  def stream(topics)
    stream_client.filter(track: topics.join(', ')) do |tweet| 
      rest_client.favorite(tweet)
      rest_client.follow(tweet.user)
    end
  end

  private

  def initialize_rest_client
    @rest_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def initialize_stream_client
    @stream_client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end