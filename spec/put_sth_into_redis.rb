require 'spec_helper'

describe HelloServerClient do
  it "put something into redis" do
    s = Service.find_or_initialize_by_name("temp")
    s.value = {
      test: "ok"
    }
  end
end
