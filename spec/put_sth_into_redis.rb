require 'spec_helper'

describe HelloServerClient do
  it "put something into redis and get it back" do
    s = HelloServerClient::Service.find_or_initialize_by_name("temp")
    s.value = {
      "test" => "ok",
      "time" => Time.now
    }
    s.detail = {
      "detail" => "ok"
    }
    s.save!

    a = HelloServerClient::Service.find_or_initialize_by_name("temp")
    s.value["test"].should == "ok"
    s.detail["detail"].should == "ok"
  end
end
