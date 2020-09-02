# frozen_string_literal: true

require 'rake'

RSpec.describe 'Rake Tasks' do
  before do
    file, path = Rake.application.find_rakefile_location
    Rake::Task.define_task(:environment)
    Rake.load_rakefile("#{path}/#{file}")
    @task = Rake::Task['parse:webserver_log']
  end

  after do
    @task.all_prerequisite_tasks.each(&:reenable)
    @task.reenable
  end

  context 'when webserver.log file present' do
    it 'expected the correct stdout' do
      filepath = 'spec/fixtures/files/webserver.log'
      expect do
        @task.invoke(filepath)
      end.to output(/contact 90 unique views/).to_stdout
    end
  end

  context 'when filepath argument is empty' do
    it do
      expect do
        @task.invoke
      end.to raise_error(ArgumentError, /File path couldnt be blank/)
    end
  end

  context 'when filepath argument is wrong' do
    filepath = 'wrong/path/file.log'
    it do
      expect do
        @task.invoke(filepath)
      end.to raise_error(Errno::ENOENT, /No such file or directory/)
    end
  end

  context 'when wrong file format provided' do
    filepath = 'wrong/path/file.mp4'
    it do
      expect do
        @task.invoke(filepath)
      end.to raise_error(RuntimeError, /Wrong file format/)
    end
  end

  context 'when empty log file provided' do
    filepath = 'spec/fixtures/files/empty.log'
    it do
      expect do
        @task.invoke(filepath)
      end.to raise_error(RuntimeError, /No log entities found/)
    end
  end
end
