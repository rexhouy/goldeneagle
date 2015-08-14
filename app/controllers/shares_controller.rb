# -*- coding: utf-8 -*-
class SharesController < ApplicationController
        layout "share"

        # GET /shares
        def index
                @shares = Share.passed.paginate(:page => params[:page])
        end

        # GET /shares/search
        def search
                if params[:tel].nil? or params[:tel].empty?
                        index
                else
                        @shares = Share.where(tel: params[:tel])
                end
                @tel = params[:tel]
                render :index
        end

        # GET /shares/1
        def show
                @share = Share.find(params[:id])
        end

        # GET /shares/new
        def new
                @share = Share.new
        end

        # POST /shares
        def create
                @share = Share.new(share_params)

                if @share.save
                        redirect_to @share, notice: "上传成功"
                else
                        render :new
                end
        end
        # POST /shares/like/:id
        def like
                @share = Share.find(params[:id])
                @share.fav += 1
                @share.save
                render plain: "ok"
        end

        private
        def share_params
                params.require(:share).permit(:name, :tel, :image_1, :image_2, :image_3, :content)
        end
end
