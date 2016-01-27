require 'json'

class LogParser
  # Parses a file containing JSON documents, each on its own line.
  # When in strict mode, lines which do not parse as valid JSON documents
  # raise exceptions, otherwise they are ignored.
  # 
  # Example usage:
  #
  # LogParser::new(open('log.txt'), strict: false).each_record {|document|
  #     # do something with document
  #     puts document.inspect
  # }
  def initialize(log_file, options={})
    @log_file = log_file

    @strict = options.include?(:strict) ? options[:strict] : true
  end


  def each_record(&block)
    loop do
      begin
        line = @log_file.readline
      rescue EOFError
        break
      end
      begin
        yield JSON.load(line)
      rescue JSON::ParserError
        if @strict
          raise
        end
      end
    end
  end
end
