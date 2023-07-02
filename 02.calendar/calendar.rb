#!/bin/env ruby

require 'optparse'
require 'date'

month = Date.today.month
year = Date.today.year
# カレンダー表記に合わせて月を英語表記にする
month_s = Date.today.strftime('%B')

opt = OptionParser.new
opt.on('-y [YEAR]') {|y| 
if y != nil
  year = y.to_i
end
}
opt.on('-m [MONTH]') {|m| 
if m != nil
  month = m.to_i
  month_s = Date.new(year, month, 1).strftime('%B')
end
}
opt.parse!(ARGV)
puts ARGV

# 中央に配置するための最初の余白設定
# 月と年の文字数を一列分の文字数から引く（月と文字の間の半角空白分1文字も追加）
# 残った文字数を半分にし、その整数部分の数×半角空白を挿入する
# 一列分の文字数 20は固定
((20 - ("#{month_s} #{year}").size) / 2).times do
  print " "
end
print "#{month_s} #{year}\n"

# 曜日を表示
puts "Su Mo Tu We Th Fr Sa"

# 1から月末までを表示
day1 = Date.new(year, month, 1)
day2 = Date.new(year, month, -1)
day1_of_week = day1.wday
num = 3 * day1_of_week
num.times  do
  print " "
end

(day1..day2).each do |x| 
  # 1日の曜日を出力し、火曜～金曜の場合は前に空白をいれる 
  # 土曜日だったら改行を入れて出力
  if x.mday < 10
    if x.wday == 6 || x == day2
      print " " + x.mday.to_s + "\n"
    else
      print " " + x.mday.to_s + " "
    end
  else
    if x.wday == 6 || x == day2
      print x.mday.to_s + "\n"
    else
      print x.mday.to_s + " "
    end
  end
end