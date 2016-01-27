class LogRecord < ActiveRecord::Base
  def self.from_log(doc)
    params = {}

    if doc['path']
        path_uri = URI.parse(doc.delete('path'))

        # this includes a leading slash for windows,
        native_path = URI.decode(path_uri.path)
        params['file_name'] = File.basename(native_path)
        params['file_path'] = native_path

    end
    
    params['extra'] = JSON::dump(doc)
    
    LogRecord::new(params)   
  end
end
