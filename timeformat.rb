class TimeFormat
  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(formats)
    @formats = formats.split(',')
  end

  def invalid_format?
    invalid_formats.any?
  end

  def invalid
    invalid_formats.join(', ')
  end

  def format
    Time.now.strftime(valid_formats.join('-'))
  end

  private

  def valid_formats
    @formats.map { |format| TIME_FORMATS[format] }.compact
  end

  def invalid_formats
    @formats.reject { |format| TIME_FORMATS.include?(format) }
  end
end
