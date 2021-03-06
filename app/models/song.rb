class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name
    self.genre.name if self.genre
  end

  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def artist_name
    self.artist.name if self.artist
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def note_contents
    self.notes.map{|n| n.content}
  end

  def note_contents=(contents)
    contents = contents.compact.reject { |c| c == "" }
    contents.each do |c|
      self.notes << Note.create(content: c)
    end
    self.note_contents
  end
end
