class Admin::SharesController < AdminController

        def screen
                respond_to do |format|
                        @share1 = PlaylistService.next
                        format.html {
                                @share2 = PlaylistService.next
                                render layout: false
                        }
                        format.json { render json: @share1 }
                end
        end

        def duration_all
                PlaylistService.duration = params[:duration] || 20
                render plain: "ok"
        end

        def index
                @shares = Share.filter(params[:filter]).paginate(:page => params[:page])
                @duration = PlaylistService.duration
        end

        def show
                @share = Share.find(params[:id])
                @share.duration ||= PlaylistService.duration unless @share.nil?
        end

        def duration
                share = Share.find(params[:id])
                share.duration = params[:duration]
                share.save
                render plain: "ok"
        end

        def pass
                update_status params[:id], Share.statuses[:passed]
                PlaylistService.add(@share)
        end

        def reject
                update_status params[:id], Share.statuses[:rejected]
                PlaylistService.remove(@share)
        end

        private
        def update_status(id, status)
                @share = Share.find(id)
                @share.status = status
                @share.save
                @share.duration ||= PlaylistService.duration
                render :show
        end

end
