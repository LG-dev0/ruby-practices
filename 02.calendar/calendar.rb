#!/bin/env ruby

require 'optparse'
require 'date'

month = Date.today.month
year = Date.today.year
# カレンダー表記に合わせて月を英語表記にする
month_s = Date.today.strftime('%B')

opt = OptionParser.new
opt.on('-y [YEAR]') do |y| 
  year = y&.to_i || year
end
opt.on('-m [MONTH]') {|m| 
if m != nil
  month = m.to_i
  month_s = Date.new(year, month, 1).strftime('%B')
end
}
opt.parse!(ARGV)
puts ARGV

# 中央に配置するための最初の余白設定
# 一列分の文字数 20は固定
puts "#{month_s} #{year}".center(20)

# 曜日を表示
puts "Su Mo Tu We Th Fr Sa"

# 1から月末までを表示
day_first = Date.new(year, month, 1)
day_end = Date.new(year, month, -1)
day_of_week = day_first.wday
num = 3 * day_of_week
num.times  do
  print " "
end

(day_first..day_end).each do |date| 
  if date.saturday?
    print date.mday.to_s.rjust(2) + "\n"
  else
    print date.mday.to_s.rjust(2) + " "
  end
end
print "\n" 