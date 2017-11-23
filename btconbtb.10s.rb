#! /usr/bin/env ruby
# coding: utf-8

require "net/http"
require "uri"
require "json"

ICON1 = '💰'.freeze
ICON2 = '💸'.freeze

def getPrice
  uri = URI.parse("https://api.bitflyer.jp")
  uri.path = '/v1/getboard'
  uri.query = ''
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  response = https.get uri.request_uri
  response_hash = JSON.parse(response.body)
  response_hash["mid_price"]
end

def getTicker
  uri = URI.parse("https://api.bitflyer.jp")
  uri.path = '/v1/getticker'
  uri.query = ''
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  response = https.get uri.request_uri
  response_hash = JSON.parse(response.body)
end

current_price = getPrice.to_i.to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,').reverse
last_trade_price = getTicker["ltp"].to_i.to_s.reverse.gsub( /(\d{3})(?=\d)/, '\1,').reverse


# --------------------------------------
# Display
# --------------------------------------
if getPrice.to_i > getTicker["ltp"].to_i
  puts ICON1 + '￥' + current_price + ' | color=green'
else
  puts ICON2 + '￥' + current_price + ' | color=red'
end

puts "---"
puts 'Current Price ￥' + current_price
puts 'Last Trade Price ￥' + last_trade_price
