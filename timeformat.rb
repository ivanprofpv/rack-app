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
    @formats = formats
    @valid_formats = []
    @invalid_formats = []
  end

  def sort_arrays
    @formats.split(',').each do |format|
      TIME_FORMATS[format] ? @valid_formats << TIME_FORMATS[format] : @invalid_formats << format
    end
  end

  def invalid_format?
    @invalid_formats.empty?
  end

  def invalid
    @invalid_formats.join(', ')
  end

  def format
    Time.now.strftime(@valid_formats.join('-'))
  end

end
