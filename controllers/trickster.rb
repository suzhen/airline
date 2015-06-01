post '/catch' do

  exam_form = params[:ef]

  corrects = Array.new

  encrypt_question = Parser.encrypt_question(Parser.parse_form(exam_form))

  encrypt_question.each do |question|

    corrects << Trouble.find_by(encrypt_question:question).try(:correct)

  end

  puts corrects.to_s

  correct_answers = corrects.map{|correct| correct.nil? ? "X" : correct }.join(",")

  correct_answers

end



get "/test" do

  erb :test

end