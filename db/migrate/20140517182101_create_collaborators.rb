class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :email
      t.boolean :access

      t.timestamps
    end
  end
end
