class Song
    extend Concerns::Findable

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def self.all
        @@all
    end

    def initialize(name, artist = nil, genre = nil)
        self.name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def save
        @@all << self
    end

    def self.create(name)
        newsong = Song.new(name)
        newsong.save
        newsong
    end

    def self.destroy_all
        @@all.clear
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self) # this will soon call artist_setter below
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    ### Commented out, replicated by Findable module
    #def self.find_by_name(name)
    #    Song.all.find {|song| song.name == name}
    #end

    #def self.find_or_create_by_name(name)
    #    finder = self.find_by_name(name)
    #    if !finder
    #        self.create(name)
    #    else
    #        finder
    #    end
    #end

    def self.new_from_filename(filename)
        split_filename = filename.split(/\s\-\s|\./)
        name = split_filename[1].strip
        newsong = Song.new(name)
        newsong.artist = Artist.find_or_create_by_name(split_filename[0].strip)
        newsong.genre = Genre.find_or_create_by_name(split_filename[2].strip)
        newsong
    end

    def self.create_from_filename(filename)
        newsong = self.new_from_filename(filename)
        @@all << newsong
        newsong
    end
end