module Concerns::Findable
        # these are class methods
        # this module is to be extended, not included

        def find_by_name(name)
            self.all.find {|instance| instance.name == name}
        end

        def find_or_create_by_name(name)
          finder = self.find_by_name(name)
            if !finder
                self.create(name)
            else
                finder
            end
        end

        # this maybe doesn't belong here given the module name Findable
        # but it wants to extend to the same set of classes
        # and also involves sifting through the @@all array
        # so good enough

        def all_alphabetized
            self.all.sort do |object, other_object|
                object.name <=> other_object.name
            end
        end
end