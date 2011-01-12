class ScannedFile
  include Mongoid::Document
  
  field :filehash
  field :name
  field :size, :type => Integer
  field :category
  field :content_type
  
  embeds_many :single_files
  embeds_many :informations

  def merge_with scanned_file
    self.name = scanned_file.name if self.name.nil? and not scanned_file.name.nil?
    self.size = scanned_file.size if self.size.nil? and not scanned_file.size.nil?
    self.category = scanned_file.category if self.category.nil? and not scanned_file.category.nil?
    self.content_type = scanned_file.content_type if self.content_type.nil? and not scanned_file.content_type.nil?
  end

  def forced_merge_with scanned_file
    self.name = scanned_file.name if not scanned_file.name.nil?
    self.size = scanned_file.size if not scanned_file.size.nil?
    self.category = scanned_file.category if not scanned_file.category.nil?
    self.content_type = scanned_file.content_type if not scanned_file.content_type.nil?
  end
end
