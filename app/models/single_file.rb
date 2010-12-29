class SingleFile
  include Mongoid::Document

  field :file_name
  field :directory
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  field :mtime, :type => DateTime
  field :last_seen, :type => DateTime

  embeds_one :host

  embedded_in :scanned_file, :inverse_of => :single_file
end
