class ScannedFile
  include Mongoid::Document
  
  field :filehash
  field :name
  field :size, :type => Integer
  field :category
  field :content_type
  
  embeds_many :single_file
  embeds_many :information

  def merge_by_hash_with scanned_file
    self.name = scanned_file.name if self.name.nil? and not scanned_file.name.nil?
    self.size = scanned_file.size if self.size.nil? and not scanned_file.size.nil?
    self.category = scanned_file.category if self.category.nil? and not scanned_file.category.nil?
    self.content_type = scanned_file.content_type if self.content_type.nil? and not scanned_file.content_type.nil?

    self.merge_single_files scanned_file.single_files
  end

  def merge_single_files single_files_a
#    already_present = false
#
#    single_files_a.each do |single_file|
#      self.single_files.each do |self_single_file|
#        if self_single_file.directory == single_file.directory and self_single_file.file_name = single_file.file_name
#	then
#          self_single_file.updated_at = single
#	end
#      end
#    end
  end
end
