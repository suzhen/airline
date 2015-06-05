class Parser

  def self.parse_form(exam_form)
      html_doc = Nokogiri::HTML(exam_form)
      questions = []
      answers = []
      html_doc.css('.question-container').each do |div|

        question = {}

       

        q_stem = div.first_element_child
        q_code = div.css('.no-point')
 
        question[:stem] =  q_stem.content.gsub(/^[\d]+./, "").gsub(/\(10分\)/, "").strip()
        question[:code] =  q_code.attribute("id").to_s[8..-1]
        question[:encrypt] = Digest::MD5.new.update(question[:stem]).hexdigest

        questions << question

        q_answers = div.css('.answer')

        q_answers.each do |e|
          answer = {}
          answer_code = e.first_element_child.attribute("value").to_s
          answer_content = e.content
          
          answer[:qcode] =  question[:code]
          answer[:pageorder] = answer_content.match(/[A-Z]\./).to_s.gsub(/\./, "")
          answer[:item] = answer_content.gsub(/[A-Z]\./,"").strip()
          answer[:code] = answer_code
          answer[:encrypt] = Digest::MD5.new.update(answer[:item]).hexdigest

          answers << answer
        end
              
      end

      return questions,answers
  
  end

end