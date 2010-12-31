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

    scanned_file = params[:scanned_file]
    single_file = scanned_file[:single_files][0]

    @scanned_file = ScannedFile.new(scanned_file)

    @existing_file = ScannedFile.first(:conditions => {"scanned_files.file_name" => single_file[:file_name]})
    if @existing_file.nil?
      # There isn't any file matching the path of the new scanned file
      @new_file = ScannedFile.find_or_initialize_by(:filehash => scanned_file[:filehash])
      @new_file.merge_with @scanned_file
      @new_file.single_files.create single_file
      @new_file.save
      respond_with @new_file
    else
      # This file is already in the database
      @existing_file.merge_with @scanned_file
      @existing_file.save
      respond_with @existing_file
    end
  end


  def create2
    @scanned_file = ScannedFile.new(params[:scanned_file])

    @host = Host.find_or_initialize_by(:name => params[:host][:name],
                                        :protocol => params[:host][:protocol])
    @host.save

    @single_file = SingleFile.find_or_initialize_by(:file_name => @scanned_file.single_files[0].file_name,
                                                    :directory => @scanned_file.single_files[0].directory)
    #@single_file.save
    
    if not @single_file.scanned_file.nil?
    then
      @new_file = @single_file.scanned_file
      @new_file.merge_with @scanned_file
    elsif not @scanned_file.filehash.nil?
    then
      @new_file = ScannedFile.find_or_initialize_by(:filehash => @scanned_file.filehash)
      @new_file.merge_with @scanned_file
      @new_file.single_files << @single_file
    else
      @new_file = ScannedFile.new
      @new_file.filehash = @scanned_file.filehash if not @scanned_file.filehash.nil?
      @new_file.merge_with @scanned_file
      @new_file.single_files << @single_file
    end

    @new_file.save
    respond_with @new_file
  end

end
