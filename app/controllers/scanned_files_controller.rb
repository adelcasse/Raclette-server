class ScannedFilesController < ApplicationController

  respond_to :json, :xml

  def index
    @scanned_files = ScannedFile.all
    respond_with @scanned_files.to_a
  end

  def show
    @scanned_file = ScannedFile.criteria.id(params[:id])
    respond_with @scanned_file.to_a
  end


  def create
    #TODO: if the file already exists but its hash has been changed, we have to discontinue it and create a new scanned_file document with the new hash
    #TODO: Implement hosts de pending on the final schema chosed
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
      @new_file = ScannedFile.find_or_initialize_by(:filehash => scanned_file[:filehash])
      @new_file.merge_with @scanned_file
      @new_file.single_files.create single_file
      @new_file.single_files[0].host = @host
      @new_file.save
      respond_with @new_file
    else
      # This file is already in the database
      if @existing_file.filehash == scanned_file[:file_hash]
        @existing_file.merge_with @scanned_file
        @existing_file.save
      else
      end
      respond_with @existing_file
    end
  end
end
