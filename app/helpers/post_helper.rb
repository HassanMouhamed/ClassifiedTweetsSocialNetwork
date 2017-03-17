module PostHelper
  require 'rjb'
  require 'liblinear'


  Rjb::add_jar(Dir.glob("#{Rails.root}/lib/java_libs/myesa4.jar").join(':'))
  Rjb::load(Dir.glob("#{Rails.root}/lib/java_libs/myesa4.jar").join(':'))
  @@test = Rjb.import('edu.wiki.demo.TestGeneralESAVectors')
  @@instance_class ||= @@test.new

  def get_post_category post
    hashed_concept_vector = Hash.new
    concept_vector= @@instance_class.generateConceptVector(post)
    concept_vector_arr =concept_vector.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '').split(" ")
    concept_vector_arr.each do |element|
      hash_element = element.split(":")
      key = hash_element[0]
      value = hash_element[1]
      hashed_concept_vector[key.to_i] = value.to_f
    end
    model = Liblinear::Model.load("#{Rails.root}/lib/tmp_train.model")
    Liblinear.predict(model, hashed_concept_vector)
  end

end
