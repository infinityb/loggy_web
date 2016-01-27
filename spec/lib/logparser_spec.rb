require 'rails_helper'
require 'logparser'



RSpec.describe LogParser do
  TEST_FILE_WITH_PARSE_ERROR = <<-END
    {"a": 1, "b": 4}
    {"a": 2, "b": 5}
    {"a": 3, "b": 6}
    foobar
    {"a": 4, "b": 7}
    END

  it "ignores invalid documents without strict mode" do
    file = StringIO::new(TEST_FILE_WITH_PARSE_ERROR)
    parser = LogParser::new(file, strict: false)

    document_counter = 0
    parser.each_record {|rec|
      document_counter += 1
    }

    expect(document_counter).to be(4)
  end

  it "raises exceptions on invalid documents when in strict mode" do
    file = StringIO::new(TEST_FILE_WITH_PARSE_ERROR)

    # strict is default
    parser = LogParser::new(file)

    document_counter = 0
    expect{
      parser.each_record {|rec|
        document_counter += 1
      }
    }.to raise_error(JSON::ParserError)

    # ensure we hit the exception at the right point and not earlier.
    expect(document_counter).to be(3)
  end
end
