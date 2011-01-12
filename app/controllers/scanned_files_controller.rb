class ScannedFilesController < ApplicationController

  respond_to :json, :xml

  def index
    @scanned_files = ScannedFile.all.find
    respond_with @scanned_files.to_a
  end

  def show
    @scanned_file = ScannedFile.criteria.id(params[:id]).find.first
    respond_with @scanned_file
  end


  def create
    scanned_file = params[:scanned_file]
    single_file = scanned_file[:single_files][0]
    host = params[:host]

    @scanned_file = ScannedFile.new(scanned_file)
    @host = Host.find_or_initialize_by(:hostname => host[:hostname])
    @host.protocol = host[:protocol] if not host[:protocol].nil?
    @host.save

    @existing_file = ScannedFile.where("single_files.file_name" => single_file[:file_name]).and("single_files.directory" => single_file[:directory]).first
    if @existing_file.nil?
      # There isn't any file matching the path of the new scanned file
      @new_file = create_new_file_from(@scanned_file, single_file)
      respond_with @new_file
    else
      # This file is already in the database
      if @existing_file.filehash == scanned_file[:filehash]
        @existing_file.merge_with @scanned_file
        @existing_file.save
        respond_with @existing_file
      else
	@existing_file.single_files.destroy_all(:conditions => {:file_name => single_file[:file_name], :directory => single_file[:directory]})
	@existing_file.save
        @new_file = create_new_file_from(@scanned_file, single_file)
	respond_with @new_file
      end
    end
  end

  def update
    @update_file = ScannedFile.criteria.id(params[:id]).find.first
    merge_file = ScannedFile.new(params[:scanned_file])

    @update_file.forced_merge_with merge_file

    @update_file.save
    respond_with @update_file
  end


  private

  def create_new_file_from(scanned_file, single_file)
      @new_file = ScannedFile.find_or_create_by(:filehash => scanned_file.filehash)
      @new_file.merge_with scanned_file
      @new_file.single_files.create single_file
      @new_file.single_files[0].save
      @new_file.save
      return @new_file
  end

end
