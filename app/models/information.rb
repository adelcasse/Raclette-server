class Information
  include Mongoid::Document
  
  field :label
  field :data
  
  embedded_in :scanned_file, :inverse_of => :information
end