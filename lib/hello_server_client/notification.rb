require 'ohm'
require 'ohm/contrib'

module HelloServerClient
  class Notification < Ohm::Model
    include Ohm::Timestamps
    include Ohm::DataTypes

    attribute :name
    unique :name

    attribute :summary_header, Type::Array
    attribute :summaries, Type::Array

    attribute :detail_header, Type::Array
    attribute :details, Type::Array

    index :name

    def self.find_or_initialize_by_name(name)
      # find doesn't work
      #s = self.find(name: name)
      s = find_by_name(name)
      if s.nil?
        s = self.new
        s.name = name
      end
      return s
    end

    def self.find_by_name(name)
      @@index = Hash.new unless defined? @@index
      id = @@index[name]
      if id
        # something is indexed
        obj = self[id]
        if obj and obj.name == name
          # good index
          return obj
        else
          @@index.delete(name)
          return nil
        end
      else
        # get object
        obj = self.all.select { |o| o.name == name }.first
        if obj
          @@index[name] = obj.id
          return obj
        else
          return nil
        end
      end
    end

    # INFO: add oj gem
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
