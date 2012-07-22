require 'geocoder/lookups/base'
require 'geocoder/results/geoip_omni'

module Geocoder::Lookup
  class GeoipOmni < Base

    private # ---------------------------------------------------------------

    ##
    # Parses a raw search result (returns hash or array).
    #
    def parse_raw_data(raw_data)
      raw_data.split ','
    rescue
      warn "Geocoding API's response was not valid."
    end

    def results(query, reverse = false)
      # don't look up a loopback address, just return the stored result
      return [reserved_result(query)] if loopback_address?(query)
      begin
        return (doc = fetch_data(query, reverse)) ? [doc] : []
      rescue StandardError => err # Freegeoip.net returns HTML on bad request
        raise_error(err)
        return []
      end
    end

    def reserved_result(ip)
      {
        "ip"           => ip,
        "city"         => "",
        "region_code"  => "",
        "region_name"  => "",
        "metrocode"    => "",
        "zipcode"      => "",
        "latitude"     => "0",
        "longitude"    => "0",
        "country_name" => "Reserved",
        "country_code" => "RD"
      }
    end

    def query_url(query, reverse = false)
      "#{protocol}://geoip.maxmind.com/e?l=#{Geocoder::Configuration.ip_api_key}&i=#{query}"
    end
  end
end
