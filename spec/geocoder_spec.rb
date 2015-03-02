# encoding: utf-8

require File.expand_path 'spec_helper.rb', __dir__

describe OpenCage::Geocoder do
  def geo
    OpenCage::Geocoder.new(api_key: ENV.fetch('OPEN_CAGE_API_KEY'))
  end

  describe 'authentication' do
    it 'raises an error if the API key is missing' do
      proc do
        OpenCage::Geocoder.new
      end.must_raise OpenCage::Geocoder::GeocodingError
    end

    it 'raises an error when geocoding if the API key is incorrect' do
      proc do
        geo = OpenCage::Geocoder.new(api_key: 'AN-INVALID-KEY')
        geo.geocode('SOMEWHERE')
      end.must_raise OpenCage::Geocoder::GeocodingError
    end
  end

  describe '#reverse_geocode' do
    def bermondsey
      'London, Bermondsey Wall West, London SE14, United Kingdom'
    end

    it 'reverse geocodes a set of coordinates' do
      assert_equal bermondsey, geo.reverse_geocode(51.5019951, -0.0698806)
    end

    it 'accepts arrays and strings for coordinates' do
      assert_equal bermondsey, geo.reverse_geocode([51.5019951, '-0.0698806'])
    end

    it 'is simple to handle a single string' do
      assert_equal bermondsey,
                   geo.reverse_geocode('51.5019951 -0.0698806'.split)
    end

    it 'raises an error for badly formed input' do
      exception = proc do
        geo.reverse_geocode('NOT-A-COORD', 51.50934)
      end.must_raise ArgumentError
      assert_equal 'invalid value for Float(): "NOT-A-COORD"', exception.message
    end
  end

  describe '#geocode' do
    it 'geocodes a place name' do
      assert_equal [-32.5980702, 149.5886383], geo.geocode('Mudgee, Australia')
    end

    it 'geocodes a postcode' do
      assert_equal [51.5226295, -0.1024389], geo.geocode('EC1M 5RF')
    end

    it 'geocodes a place name with encoding' do
      assert_equal [51.9501317, 7.61330165026119], geo.geocode('Münster')
    end

    it 'correctly parses a request with encoding in the response' do
      assert_equal [43.3224219, -1.9838889], geo.geocode('Donostia')
    end

    it 'throws a useful error when no results are found' do
      exception = proc do
        geo.geocode('NOWHERE-INTERESTING')
      end.must_raise OpenCage::Geocoder::GeocodingError
      assert_equal exception.message, 'location not found'
    end
  end
end
