class RaCreateVersionsTable < ActiveRecord::Migration[5.0]
  def change
    create_table 'ra.versions' do |t|
      t.timestamps
    end



    # add_foreign_key 'ra.region_changes', 'ra.versions', column: 'version_id'
    # add_foreign_key 'ra.county_changes', 'ra.versions', column: 'version_id'
    # add_foreign_key 'ra.municipality_changes', 'ra.versions', column: 'version_id'
    # add_foreign_key 'ra.district_changes', 'ra.versions', column: 'version_id'
    # add_foreign_key 'ra.street_name_changes', 'ra.versions', column: 'version_id'
    # add_foreign_key 'ra.property_registration_number_changes', 'ra.versions', column: 'version_id'
    # add_foreign_key 'ra.building_number_changes', 'ra.versions', column: 'version_id'
    # add_foreign_key 'ra.building_unit_changes', 'ra.versions', column: 'version_id'
  end
end
