class Host
  include Mongoid::Document
  
  field :name
  field :protocol
  field :protocol_login
  field :protocol_password
  field :start_scan, :type => DateTime
  field :end_scan, :type => DateTime
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  
  embedded_in :single_file, :inverse_of => :host
end
