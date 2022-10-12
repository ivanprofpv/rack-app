require_relative 'timeformat'

class App

  def call(env)
    @request = Rack::Request.new(env)

    if valid_path?
      timeformat = TimeFormat.new(@request.params["format"])

      if timeformat.invalid_format?
        rack_response(:bad_request, "Unknown time format [#{timeformat.invalid}]")
      else
        rack_response(:ok, timeformat.format)
      end

    else
      rack_response(:not_found, "Page not found")
    end

  end

  private

  def rack_response(response_message, body)
    [
      Rack::Utils.status_code(response_message),
      {'Content-Type' => 'text/plain'},
      [body]
    ]
  end

  def valid_path?
    @request.path == '/time'
  end

end
