# frozen_string_literal: true

module Services
  class ParseLogService
    include ParseLogFile

    def initialize(args)
      @args = args
    end

    def execute
      raise ArgumentError, 'File path couldnt be blank' if filepath.blank?
      raise 'Wrong file format' unless filepath.include?('log')

      parse_log_file(filepath, log_enities = [])
      raise 'No log entities found' if log_enities.blank?

      Queries::LogEntitiesQuery.call(log_enities)
    end

    private

    def filepath
      @args[:filepath]
    end
  end
end
