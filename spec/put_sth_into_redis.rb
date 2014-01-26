require 'spec_helper'

describe HelloServerClient do
  it "put something into redis and get it back" do
    # HelloServerClient::Service.all.each(&:delete)

    s = HelloServerClient::Service.find_or_initialize_by_name("temp2")
    s.summary_header = [
      "id",
      "desc"
    ]
    s.summaries = [
      [1, "a"],
      [2, "b"]
    ]
    s.detail_header = [
      "id",
      "desc"
    ]
    s.details = [
      [1, "a", "b", "c"],
      [2, "a", "b", "c"],
      [3, "a", "b", "c"]
    ]
    s.save!

    a = HelloServerClient::Service.find_or_initialize_by_name("temp2")
    a.summary_header.size.should == 2
    a.summaries.size.should == 2
    a.detail_header.size.should == 2
    a.details.size.should == 3
  end
end
