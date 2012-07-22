require 'geocoder/results/base'

module Geocoder::Result
  class GeoipOmni < Base

    def address(format = :full)
      s = state_code.to_s == "" ? "" : ", #{state_code}"
      "#{city}#{s} #{postal_code}, #{country}".sub(/^[ ,]*/, "")
    end
    
    def latitude
      @data[5]
    end
    
    def longitude
      @data[6]
    end

    def city
      @data[4]
    end

    def state
      @data[3]
    end

    def state_code
      @data[2]
    end

    def country
      @data[1]
    end

    def country_code
      @data[0]
    end

    def postal_code
      @data[11]
    end
    
    def metrocode
      @data[7]
    end
    
    def area_code
      @data[8]
    end
    
    def time_zone
      @data[9]
    end
    
    def continent_code
      @data[10]
    end
    
    def isp
      @data[12]
    end
    
    def organization
      @data[13]
    end
    
    def domain
      @data[14]
    end
    
    def as_number
      @data[15]
    end
    
    def netspeed
      @data[16]
    end
    
    def user_type
      @data[17]
    end
    
    def accuracy_radius
      @data[18]
    end
    
    def error_code
      @data[23]
    end

    # def self.response_attributes
    #   %w[metrocode ip]
    # end
    # 
    # response_attributes.each do |a|
    #   define_method a do
    #     @data[a]
    #   end
    # end
  end
end
