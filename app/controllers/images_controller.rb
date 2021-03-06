class ImagesController < ApplicationController

        def create
                uploader = ImageUploader.new
                uploader.store!(params[:file])
                render json: { filelink: get_url(uploader.url) }
        end

        private
        def get_url(local_path)
                Config::UPLOADS["base_url"] + local_path.gsub(Config::UPLOADS["storage_path"], "")
        end

end
