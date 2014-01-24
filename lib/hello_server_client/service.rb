require 'oj'
require 'ohm'
require 'ohm/contrib'

module HelloServerClient
  class Service < Ohm::Model
    include Ohm::Timestamps
    include Ohm::DataTypes

    attribute :name
    unique :name
    attribute :value, Type::Hash

    index :name

    def self.find_or_initialize_by_name(name)
      # find doesn't work
      s = self.all.select { |o| o.name == name }.first
      if s.nil?
        s = self.new
        s.name = name
      end
      return s
    end


    #attribute :value_json
    #def value
    #  nil if self.value_json.nil?
    #  Oj.load(self.value_json.to_s)
    #end
    #
    #def value=(obj)
    #  if obj.nil?
    #    self.value_json = nil
    #    return
    #  end
    #  self.value_json = Oj.dump(obj)
    #end

    def updated_time
      Time.at(self.updated_at.to_i)
    end
  end
end