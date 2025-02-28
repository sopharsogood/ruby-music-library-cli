class MusicImporter
    attr_accessor :path

    def initialize(path)
        self.path = path
    end

    def files
        Dir.children(self.path)
    end

    def import
        self.files.each do |filename|
            Song.create_from_filename(filename)
        end
    end
end