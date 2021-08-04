class Artist
    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def self.all
        @@all
    end

    def initialize(name)
        self.name = name
    end

    def save
        @@all << self
    end

    def self.create(name)
        newartist = Artist.new(name)
        newartist.save
        newartist
    end

    def self.destroy_all
        @@all.clear
    end

    def add_song(song)
        song.artist = self if !song.artist    # causes infinite loop
        # song.artist_setter(self) if !song.artist
    end
    
    def songs
        Song.all.select {|song| song.artist == self}
    end

    def genres
        genres = []
        Song.all.each do |song|
            if song.artist == self && !genres.include?(song.genre)
                genres << song.genre
            end
        end
        genres
    end
end