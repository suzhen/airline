require 'roo'
require "active_support"
require 'active_support/core_ext'
require 'digest'
require "./boot"

spreadsheetx = Roo::Spreadsheet.open('./questions/airlinexlsx.xlsx')

header = spreadsheetx.row(1)

(2..spreadsheetx.last_row).each do |i|
  
  question =  spreadsheetx.row(i)[0].strip()

  encrypt_question =  Digest::MD5.new.update(question).hexdigest  

  _answers = []
  (1..6).each do |ci|
    _answers << spreadsheetx.row(i)[ci] unless spreadsheetx.row(i)[ci].blank?
  end

  answers =  Hash[('A'..'F').to_a.zip(_answers).select{ |answer| !answer[1].nil? }]

  corrects = spreadsheetx.row(i)[7].split(";") #.gsub(/\;/, "_")

  q = Question.new(:stem=>question,:encrypt_stem=>encrypt_question)

  answers.each_pair do | key, value |

    q.answers.build(:item=>value,:encrypt_item=> Digest::MD5.new.update(value).hexdigest,:checked=> corrects.include?(key) )

  end
  
  q.save

  # Trouble.create(:question=>question,:encrypt_question=>encrypt_question,:answers=>Oj.dump(answers),:correct=>correct)

 end