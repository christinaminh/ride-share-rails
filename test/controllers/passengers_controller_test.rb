require "test_helper"

describe PassengersController do
  let(:passenger) {
    Passenger.create(
      name: "sample passenger",
      phone_num: "000-000-0000"
    )
  }

  describe "index" do
    it "responds with success when there are any passengers saved" do
      passenger.reload

      get passengers_path

      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      Passenger.destroy_all

      expect(Passenger.all.count).must_equal 0

      get passengers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing passenger" do
      id = passenger.id

      get passenger_path(id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      invalid_id = -1

      get passenger_path(invalid_id)

      must_respond_with :not_found
    end

  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      passenger_hash = {
        passenger: {
          name: "passenger to create",
          phone_num: "111-111-1111"
        }
      }

      expect{
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      created_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(created_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(created_passenger)
    end

    it "does not create a passenger if the form data violates Passenger validations" do
      invalid_passenger_hash = {
        passenger: {
          name: nil,
          phone_num: nil
        }
      }

      expect{
        post passengers_path, params: invalid_passenger_hash
      }.wont_change "Passenger.count"

      assert_template :new
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      id = passenger.id

      get edit_passenger_path(id)

      must_respond_with :success
    end

    it "responds with 404 when getting the edit page for a non-existent passenger" do
      invalid_id = -1

      get edit_passenger_path(invalid_id)

      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:updated_passenger_hash) {
      {
        passenger: {
          name: "passenger to update",
          phone_num: "222-222-2222"
        }
      }
    }

    it "can update an existing passenger with valid information accurately, and redirect" do
      id = passenger.id

      expect{
        patch passenger_path(id), params: updated_passenger_hash
      }.wont_change "Passenger.count"

      updated_passenger = Passenger.find_by(id: id)

      expect(updated_passenger.name).must_equal updated_passenger_hash[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal updated_passenger_hash[:passenger][:phone_num]

      must_redirect_to passenger_path(id)
    end

    it "does not update any passenger if given an invalid id, and responds with 404" do
      invalid_id = -1

      expect{
        patch passenger_path(invalid_id), params: updated_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end

    it "does not update a passenger if the form data violates Passenger validations, and responds with a redirect" do
      invalid_passenger_hash = {
        passenger: {
          name: nil,
          phone_num: nil
        }
      }

      id = passenger.id

      expect{
        patch passenger_path(id), params: invalid_passenger_hash
      }.wont_change "Passenger.count"

      assert_template :edit
    end

  end

  describe "destroy" do
    it "destroys the passenger instance in database when passenger exists, then redirects" do
      id = passenger.id

      expect{
        delete passenger_path(id)
      }.must_change "Passenger.count", -1

      must_redirect_to passengers_path
    end

    it "does not change the database when the passenger does not exist, then responds with 404" do
      invalid_id = -1

      expect{
        delete passenger_path(invalid_id)
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end
  end
end
