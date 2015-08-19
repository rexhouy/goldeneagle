class PlaylistService

        @@duration = 10
        @@playlist = []
        @@waitinglist = []

        @@start_point = 0
        @@cursor = 0

        def self.duration
                @@duration
        end

        def self.duration=(duration)
                @@duration = duration
        end

        def self.add(share)
                @@waitinglist << share
        end

        def self.remove(share)
                @@playlist.delete_if do |s|
                        s.id.eql? share.id
                end
                @@waitinglist.delete_if do |s|
                        s.id.eql? share.id
                end
        end

        def self.next
                if @@playlist.empty?
                        playlist = Share.passed.order(updated_at: :asc)
                        playlist.each do |share|
                                @@playlist << share
                        end
                end
                # If waiting list is not empty, play waiting list.
                # if waiting list is empty
                #   if cursor point to the end of the playlist, set cursor to -10 or 1st.
                # play next cursor
                unless @@waitinglist.empty?
                        share = @@waitinglist.shift
                        @@playlist << share
                        share.duration ||= @@duration
                        return share
                end
                @@cursor += 1
                if @@cursor >= @@playlist.length
                        # @@cursor = @@playlist.length - 10
                        @@cursor = 0 # if @@cursor < 0
                end
                share = @@playlist[@@cursor]
                share.duration ||= @@duration unless share.nil?
                share
        end

end
