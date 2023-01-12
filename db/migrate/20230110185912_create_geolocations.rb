class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    # drop_table :geolocations
    create_table :geolocations do |t|
      t.string :ip
      t.text :location_data

      t.timestamps
    end
  end
end
