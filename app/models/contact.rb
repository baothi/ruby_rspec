class Contact < ActiveRecord::Base
  has_many :phones
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phones, length: { is: 3 }


  def name
    [firstname, lastname].join(' ')
  end

  def self.by_letter(letter)
  	where("lastname LIKE ?", "#{letter}%").order(:lastname)
  end
end
