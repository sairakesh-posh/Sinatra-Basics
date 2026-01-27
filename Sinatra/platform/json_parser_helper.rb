def json_parser
  begin
    request.body.rewind
    @data = JSON.parse(request.body.read)
  rescue => e
    halt(400, {
      response: 'JSON format is expected',
      error: e
    }.to_json
    )
  end
end