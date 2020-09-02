# frozen_string_literal: true

module Queries
  # LogEntitiesQuery
  class LogEntitiesQuery
    def self.call(log_enities)
      log_enities.group_by(&:page)
                 .map { |log_entity| [log_entity[0], log_entity[1].size] }
                 .sort_by! { |_k, views| views }
                 .reverse
    end
  end
end
