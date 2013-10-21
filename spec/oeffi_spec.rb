require File.expand_path "./server"

describe "Oeffi" do

  it "provides an autocomplete method" do
    ::Oeffi::autocomplete("Leipzig").should have_at_least(1).items
  end

  it "has a query method for finding trips" do
    from = {
      id: 12996,
      type: "STATION"
    }

    to = {
      id: 13000,
      type: "STATION"
    }
    result = ::Oeffi::query(from, to)
    result.to_a.should have_at_least(1).items
  end

  describe "TripList" do
    before(:each) do
      from = {
        id: 12996,
        type: "STATION"
      }

      to = {
        id: 13000,
        type: "STATION"
      }
      @_result = ::Oeffi::query(from, to)
      @result = @_result.to_a
    end

    it "should be initialized properly with an array" do
      t = TripList.new @result
      t.list.length.should equal @result.length
    end

    it "should provide a hash as json" do
      t = TripList.new @result
      t.as_json.should be_an Array

      p t.as_json
    end

    describe "Trip" do
      before(:each) do
        @list = TripList.new @result
      end

      it "should provide trip information as a hash" do
        trip = Trip.new @_result.first

        p trip.as_json
      end

    end
  end
end