class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def app_status(app)
    PetApplication.where(pet_id: self.id).where(application_id: app.id).first.status
  end

  def self.adoptable
    where(adoptable: true)
  end

  def get_pet_by_name(name)
    Pet.where(name: name)
  end
end
