# frozen_string_literal: true

module ParseLogFile
  private

  def parse_log_file(filepath, log_enities)
    # Automatically closing a file using a block
    # Process a file sequentially, lines loaded into memory not at the same time.
    File.open(filepath).each do |line|
      next if line&.blank?
      page, ip = line.strip.split(' ')
      next until page&.present? && page&.include?('/')
      log_enities << Entities::LogEntity.new(page, ip)
    end
  end
end
