require "sequel"
require "securerandom"

module Patient

  def self.add(name, birthday)
    patient_id = SecureRandom.uuid
    DB[:patients].insert(patient_id, name, birthday)
    patient_id
  end

  def self.patients_of(doctor_id)
    #list of patients assigned to doctor using id
  end

end

module Doctor

  def self.add(name, specialty)
    doctor_id = SecureRandom.uuid
    specialty_id = self.get_specialty_id(specialty)
    DB[:doctors].insert(doctor_id, name, specialty_id)
    doctor_id
  end

  def self.assign(doctor_id, patient_id)
    DB.run("update patients set doctor_id = '#{doctor_id}' where id = '#{patient_id}'")
  end

  #list of doctors based on given specialty
  def self.by_specialty(specialty)
    specialty_id = self.get_specialty_id(specialty)
    DB[:doctors].where(:specialty_id => specialty_id).all
  end

  def self.alphabetical_with_number_of_patients
    #alphabetical list of doctors with cooresponding number of patients
  end

  private

  def self.get_specialty_id(specialty)
    DB["select id from specialties where specialty = '#{specialty}'"].first[:id]
  end

end
