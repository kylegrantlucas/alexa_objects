module AlexaObjects
  class EchoRequest
    attr_reader :intent_name, :slots, :timestamp, :request_type, :session_new, :user_id, :access_token, :application_id
    attr_accessor :attributes
    alias :session_new? :session_new

    def initialize(response_hash)
      @attributes = response_hash["session"]["attributes"] ? response_hash["session"]["attributes"] : {}

      session = response_hash["request"]
      request = response_hash["request"]

      if session
        @user_id = session["user"]["userId"]
        @access_token = session["user"]["accessToken"]
        @application_id = session["application"]["applicationId"]
      end

      if request
        @request_type = request["type"]
        @timestamp = request["timestamp"]
        @session_new = request["new"]

        if request["intent"]
          @intent_name  =  request["intent"]["name"]
          @slots      = build_struct(request["intent"]["slots"])
        end
      end
    end

    def filled_slots
      @slots.select { |slot| slot != nil}
    end

    def intent_request?
      request_type == "IntentRequest"
    end

    def launch_request?
      request_type == "LaunchRequest"
    end

    def session_ended_request?
      request_type == "SessionEndedRequest"
    end

    private 
    def build_struct(hash)
      if hash.nil?
        nil
      else
        slot_names = hash.keys.map {|k| k.to_sym.downcase }
        slot_values = hash.values.map { |v| v["value"] }
        Struct.new(*slot_names).new(*slot_values)
      end
    end
  end
end