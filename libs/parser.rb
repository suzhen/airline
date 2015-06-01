class Parser

  def self.parse_form(exam_form)
      html_doc = Nokogiri::HTML(exam_form)
      questions = []
      html_doc.css('.question-container').each do |div|
        orgin_content = div.first_element_child.content
        questions << orgin_content.gsub(/^[\d]+./, "").gsub(/\(10分\)/, "").strip()
      end
      questions
  end

  def self.encrypt_question(questions)
    questions.map{|question|  Digest::MD5.new.update(question).hexdigest }
  end

end