require 'rails_helper'

RSpec.describe LogRecord, type: :model do
  it "moves document keys into instance fields" do
    logrec = LogRecord.from_log({"path" => "file:///c%3A/program%20files/windows%20defender/MpCmdRun.exe"})

    ## expect(logrec.file_path).to eq("/c:/program files/windows defender/MpCmdRun.exe")
    expect(logrec.file_name).to eq("MpCmdRun.exe")

    extra = JSON.load(logrec.extra)
    expect(extra["path"]).to be(nil)
  end
end