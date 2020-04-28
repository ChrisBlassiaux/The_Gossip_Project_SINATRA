
require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)

    gossip_to_show = id

    new_array_of_gossips = Gossip.all
    return new_array_of_gossips[id]
  end

  def self.update(index, author, content)

    # savoir l'index
    id_row = idex
    author_new = author
    content_new = content

    # parcourir tableau et delete le potin avec l'index 
    array_of_gossips = Gossip.all
    array_of_gossips.delete(array_of_gossips[id_row])

    # et recreer le fichier CSV
    CSV.open("db/gossip.csv", "w") do |csv|
      array_of_gossips.each do |i|
        csv << [i[0], i[1]]
        csv << [author_new, content_new]
      end
    end
  end
end
