require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let(:driver) {
    Driver.create name: "Ida", vin: "183028034", available: true
  }
  describe "index" do
    it "responds with success when there are many drivers saved" do
      driver
      get drivers_path

      must_respond_with :success

    end

    it "responds with success when there are no drivers saved" do
      get drivers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      get driver_path(driver)

      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do

      get driver_path(2310)

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      driver_hash = {
          driver: {
              name: "ida",
              vin: "928493",
              available: true,
          }
      }

      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_hash = {
          driver: {
              vin: "928493",
              available: true,
          }
      }

      expect {
        post drivers_path, params: driver_hash
      }.wont_change "Driver.count"

      assert_template :new
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do

      get edit_driver_path(driver.id)
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do

      get edit_driver_path(-1)

      must_respond_with :redirect

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do

      driver_hash = {
          driver: {
              name: "Sharon",
              vin: "284924",
              available: true,
          },
      }
      driver_id = driver.id


      expect {
        patch driver_path(driver_id), params: driver_hash
      }.wont_change "Driver.count"

      find_driver = Driver.find(driver_id)
      expect(find_driver.name).must_equal driver_hash[:driver][:name]
      expect(find_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(find_driver.available).must_equal driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to driver_path(find_driver.id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do

      invalid_id = -10
      driver_hash = {
          driver: {
              name: "Sharon",
              vin: "284924",
              available: true,
          },
      }

      expect {
        patch driver_path(invalid_id), params: driver_hash
      }.wont_change "Driver.count"

      must_respond_with :not_found

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_id = driver.id

      driver_hash = {
          driver: {
              vin: "284924",
              available: true
          }
      }

      expect {
        patch driver_path(driver_id), params: driver_hash
      }.wont_change "Driver.count"

      must_respond_with :redirect
      must_redirect_to driver_path(driver_id)
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do

      id = driver.id

      expect {
        delete driver_path(id)
      }.must_change "Driver.count", -1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      id = -10

      expect {
        delete driver_path(id)
      }.wont_change "Driver.count"

      must_respond_with :not_found
    end
  end
end
