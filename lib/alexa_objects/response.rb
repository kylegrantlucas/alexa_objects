module AlexaObjects
  class Response
    attr_accessor :session_attributes, :spoken_response, :card_title, :card_content, :reprompt_text, :end_session, :speech_type, :text_type

    def initialize
      @session_attributes = {}
      @speech_type = "PlainText"
      @spoken_response = nil
      @card_title = nil
      @card_content = nil
      @reprompt_text = nil
      @text_type = "text"
      @end_session = true
    end

    def add_attribute(key, value)
      @session_attributes.merge!(key => value)
    end

    def append_attribute(key, value)
      @session_attributes[key] << value if @session_attributes[key]
    end

    def with_card
      {
        "version" => "2.0",
        "sessionAttributes" =>  
        "response" => {
          "outputSpeech" => {
            "type"=> speech_type,
            "#{text_type}"=> spoken_response
          },
          "card"=> {
            "type"=> "Simple",
            "title"=> card_title,
            "content"=> card_content
          },
          "reprompt"=> {
            "outputSpeech"=> {
              "type"=> speech_type,
              "text"=> reprompt_text
            }
          },
          "shouldEndSession"=> end_session 
        }
      }.merge(@session_attributes)
    end

    def link_card
      self.with_card.tap { |hs| hs[:response][:card] = {"type": "LinkAccount"} }
    end

    def without_card
      self.with_card.tap { |hs| hs[:response].delete(:card) }
    end
  end
end