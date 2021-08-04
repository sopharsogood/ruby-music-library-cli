class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def self.all
        @@all
    end

    def initialize(name)
        self.name = name
        self.songs = []
    end

    def save
        @@all << self
    end

    def self.create(name)
        newgenre = Genre.new(name)
        newgenre.save
        newgenre
    end

    def self.destroy_all
        @@all.clear
    end

    def add_song(song)
        song.genre_setter(self) if !song.genre
    end
    
    def songs
        Song.all.select {|song| song.genre == self}
    end

    def artists
        artists = []
        Song.all.each do |song|
            if song.genre == self && !artists.include?(song.artist)
                artists << song.artist
            end
        end
        artists
    end
end