# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

sunflower = Plant.find_or_create_by!(name: "ひまわり") do |plant|
  plant.description = "太陽のように元気に育つ植物です。"
end

cactus = Plant.find_or_create_by!(name: "サボテン") do |plant|
  plant.description = "少しずつ着実に成長する植物です。"
end

tulip = Plant.find_or_create_by!(name: "チューリップ") do |plant|
  plant.description = "やさしい彩りで成長を楽しめる植物です。"
end

[
  [sunflower, [["たね", 1, 0], ["発芽", 2, 10], ["若葉", 3, 30]]],
  [cactus, [["たね", 1, 0], ["発芽", 2, 10], ["若葉", 3, 30]]],
  [tulip, [["たね", 1, 0], ["発芽", 2, 10], ["若葉", 3, 30]]]
].each do |plant, stages|
  stages.each do |name, stage_order, required_points|
    PlantStage.find_or_create_by!(plant: plant, stage_order: stage_order) do |stage|
      stage.name = name
      stage.required_points = required_points
    end
  end
end