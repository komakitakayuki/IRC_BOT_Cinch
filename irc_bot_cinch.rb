#!/usr/local/bin/ruby
 
require 'cinch'
require 'rss'
 
IRC_ENCODING='ISO-2022-JP'
 
# you can write any RSS url
feed_url = 'http://RSS_URL'
 
bot = Cinch::Bot.new do
  configure do |c|
 
    # IRC Server IP
    c.server = "127.0.0.1"
 
    # If you use SSL, write like this
    c.ssl.use = true
     
    # IRC Server port
    c.port = "6668"
     
    # IRC Server Password
    c.password = "password"
 
    # Channel name & password
    c.channels = ["#test password"]
 
    # bot nick name and real name
    c.nick = 'bot'
    c.realname = 'bot'
    c.user = 'bot'
  end
 
  on :message, "rss" do |m|
    rss = RSS::Parser.parse(feed_url)
 
    m.reply "o "+ rss.channel.title.encode(IRC_ENCODING).force_encoding('external')
     
    rss.items.each do |item|
      m.reply item.title.encode(IRC_ENCODING).force_encoding('external')
      m.reply item.link.encode(IRC_ENCODING).force_encoding('external')
    end
     
  end
end
 
bot.start
