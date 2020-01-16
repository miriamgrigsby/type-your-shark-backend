class User < ApplicationRecord
    has_secure_password
    has_many :games

    # def spell_id=(id)
    #     spell = Spell.find(id)
    #     self.spells << spell
    # end

    # # def house_id=(id)
    # #     house = House.find(id)
    # #     self.houses << house
    # # end

    # validates :points, presence: true
    # validates :sharks_killed, presence: true
end
