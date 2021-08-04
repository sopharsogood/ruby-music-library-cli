class MusicLibraryController
    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end

    def call
        input = "help"
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        until input == "exit"
            input = gets.strip.downcase
            case input
                when "list songs"
                    self.list_songs
                when "list artists"
                    self.list_artists
                when "list genres"
                    self.list_genres
                when "list artist"
                    self.list_songs_by_artist
                when "list genre"
                    self.list_songs_by_genre
                when "play song"
                    self.play_song
            end
        end
    end

    def list_songs
        Song.all_alphabetized.each_with_index do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all_alphabetized.each_with_index do |artist, index|
            puts "#{index + 1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all_alphabetized.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        name = gets.strip
        artist = Artist.all.find {|artist| artist.name == name}
        songs_by_artist = Song.all_alphabetized.select {|song| song.artist == artist}
        songs_by_artist.each_with_index do |song, index|
            puts "#{index + 1}. #{song.name} - #{song.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        name = gets.strip
        genre = Genre.all.find {|genre| genre.name == name}
        songs_by_genre = Song.all_alphabetized.select {|song| song.genre == genre}
        songs_by_genre.each_with_index do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name}"
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_number = gets.strip.to_i
        if (1..Song.all.length).to_a.include?(song_number)
            index_number = song_number - 1
            song = Song.all_alphabetized[index_number]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
end