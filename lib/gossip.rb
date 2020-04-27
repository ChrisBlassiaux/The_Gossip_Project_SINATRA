
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

  def self.update(id, author, content)

    # savoir l'index
    id_row = id
    new_author = author
    new_content = content

    # parcourir tableau et modifier l'element avec l'index 
    array_of_gossips = Gossip.all
    array_of_gossips.each do |gossip|
      if gossip == gossip[id_row]
        gossip[0].author << new_author
        gossip[1].content << new_content
      end
    end

    # et recreer le fichier CSV
    CSV.open("db/gossip.csv", "w") do |csv|
      array_of_gossips.each do |i|
          csv << [i[0], i[1]]
      end
    end
  end
end