class SingleFile
  include Mongoid::Document

  field :file_name
  field :directory
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  field :mtime, :type => DateTime
  field :last_seen, :type => DateTime

  references_one :host # MongoDB collections with only a few objects may safely exist as separate collections, as the whole collection is quickly cached in application server memory

  embedded_in :scanned_file, :inverse_of => :single_file
end
