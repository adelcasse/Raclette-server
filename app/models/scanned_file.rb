class ScannedFile
  include Mongoid::Document
  
  field :filehash
  field :name
  field :size, :type => Integer
  field :directory
  field :category
  field :created_at, :type => DateTime
  field :updates_at, :type => DateTime
  field :mtime, :type => DateTime
  field :content_type
  field :last_seen, :type => DateTime
  
  embeds_many :host
  embeds_many :information
end
