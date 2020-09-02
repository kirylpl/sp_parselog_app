# frozen_string_literal: true

namespace :parse do
  desc 'Task to parse and sort webserver log entities'
  task :webserver_log, [:filepath] => [:environment] do |task, args|

    parse_log_service = Services::ParseLogService.new(args)
    results = parse_log_service.execute

    results.each do |page, views|
      print "#{page} #{views} unique views\n"
    end

  end
end
