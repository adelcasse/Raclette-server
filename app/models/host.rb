class Host
  include Mongoid::Document
  
  field :hostname
  field :protocol
  field :protocol_login
  field :protocol_password
  field :start_scan, :type => DateTime
  field :end_scan, :type => DateTime
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  
  referenced_in :single_file 
end
