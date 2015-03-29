#!/usr/local/bin/ruby
 
require 'cinch'
require 'rss'
 
#エンコードはサーバによって適時変えること
IRC_ENCODING='ISO-2022-JP'
 
feed_url = 'http://b.hatena.ne.jp/hotentry/it.rss'
 
bot = Cinch::Bot.new do
  configure do |c|
 
    # IRCサーバIPアドレス指定
    c.server = "127.0.0.1"
 
    #SSL通信を使っていた場合はこれを記述
    c.ssl.use = true
     
    #ポート指定
    c.port = "6668"
     
    #IRCサーバにパスワードをかけている場合はパスワードを記述
    c.password = "password"
 
    # チャンネル名と、チャンネルにパスワードをかけている場合は記述
    c.channels = ["#test password"]
 
    # botのニックネームとかユーザ名を記述
    c.nick = 'bot'
    c.realname = 'bot'
    c.user = 'bot'
  end
 
  on :message, "hatena" do |m|
    rss = RSS::Parser.parse(feed_url)
 
    m.reply "o "+ rss.channel.title.encode(IRC_ENCODING).force_encoding('external')
     
    rss.items.each do |item|
      m.reply item.title.encode(IRC_ENCODING).force_encoding('external')
      m.reply item.link.encode(IRC_ENCODING).force_encoding('external')
    end
     
  end
end
 
bot.start
