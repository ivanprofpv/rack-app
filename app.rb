require_relative 'timeformat'

class App

  def call(env)
    @request = Rack::Request.new(env)

    if valid_path?
      good_or_bad_responce
    else
      rack_response(:not_found, "Page not found")
    end

  end

  private

  def good_or_bad_responce
    timeformat = TimeFormat.new(@request.params["format"])
    timeformat.sort_arrays
    if timeformat.invalid_format?
      rack_response(:ok, timeformat.format)
    else
      rack_response(:bad_request, "Unknown time format [#{timeformat.invalid}]")
    end
  end


  def rack_response(response_message, body)
    [
      Rack::Utils.status_code(response_message),
      {'content-type' => 'text/plain'},
      [body]
    ]
  end

  def valid_path?
    @request.path == '/time'
  end

end
