module ServiceObject
  class Base
    attr_reader :opts

    def initialize(opts = {})
      @opts = opts
    end

    def call
      begin
        call!()
      rescue StandardError => e
        Rails.logger.error(e.message)
        Base.error_result(e)
      end
    end

    def call!
      Base.successful_result(perform_call)
    end

    def self.successful_result(result)
      @success_struct ||= Struct.new(:success?, :value)
      @success_struct.new(true, result)
    end

    def self.error_result(error)
      @success_struct ||= Struct.new(:success?, :error)
      @success_struct.new(false, error)
    end

  protected

    def perform_call
      # Template method.
      # Service classes have to override this method to add their logic.
    end
  end
end
