post '/catch' do

  cross_origin
  
  exam_form = params[:ef]

  corrects = Array.new

  questions,answers = Parser.parse_form(exam_form)

  questions.each do |question|

    correct = {}

    q = Question.preload(:answers).find_by(encrypt_stem:question[:encrypt])


    correct[:qcode] = question[:code]

    correct[:answers] = []

    if q.present?

      q.code = question[:code] if q.code.blank?

      answers.select {|answer| answer[:qcode] == question[:code]}.each do |answer|

        c = {}

        a =  q.answers.find_by(encrypt_item:answer[:encrypt]) 

        if a.present?

          if a.code.blank?
            a.code = answer[:code]
            a.save
          end

          if a.checked

            c[:code] = answer[:code]

            c[:pageorder]  = answer[:pageorder]

            correct[:answers] << c.transform_keys{ |key| key.to_s.downcase }

          end

        end

      end

      q.save

    else

       c = {}

       c[:code] = "0"

       c[:pageorder] = "X"

       correct[:answers] << c.transform_keys{ |key| key.to_s.downcase }

    end

    corrects << correct.transform_keys{ |key| key.to_s.downcase }

  end

  content_type :json

  #[{"qcode":"5716","answers":[{"code":"0","pageorder":"X"}]},{"qcode":"5724","answers":[{"code":"18132","pageorder":"A"}]},{"qcode":"40622","answers":[{"code":"120045","pageorder":"A"}]},{"qcode":"40738","answers":[{"code":"120329","pageorder":"B"}]},{"qcode":"44588","answers":[{"code":"131632","pageorder":"B"}]},{"qcode":"4903","answers":[{"code":"16029","pageorder":"B"}]},{"qcode":"5185","answers":[{"code":"16747","pageorder":"C"}]},{"qcode":"5214","answers":[{"code":"16818","pageorder":"A"}]},{"qcode":"5073","answers":[{"code":"16441","pageorder":"B"}]},{"qcode":"44595","answers":[{"code":"131648","pageorder":"A"}]}]
  #[{"qcode":"5716","answers":[{"code":"18113","pageorder":"A"},{"code":"18114","pageorder":"Z"}]},{"qcode":"5724","answers":[{"code":"18132","pageorder":"A"}]},{"qcode":"40622","answers":[{"code":"120045","pageorder":"A"}]},{"qcode":"40738","answers":[{"code":"120329","pageorder":"B"}]},{"qcode":"44588","answers":[{"code":"131632","pageorder":"B"}]},{"qcode":"4903","answers":[{"code":"16029","pageorder":"B"}]},{"qcode":"5185","answers":[{"code":"16747","pageorder":"C"}]},{"qcode":"5214","answers":[{"code":"16818","pageorder":"A"}]},{"qcode":"5073","answers":[{"code":"16441","pageorder":"B"}]},{"qcode":"44595","answers":[{"code":"131648","pageorder":"A"}]}]
  Oj.dump(corrects)
 
end



get "/test" do

  erb :test

end