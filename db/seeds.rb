sunflower = Plant.find_or_initialize_by(name: "ひまわり")
sunflower.description = "はじめてでも育てやすい植物です。"
sunflower.save!

cactus = Plant.find_or_initialize_by(name: "サボテン")
cactus.description = "じっくり気長に育てたい植物です。"
cactus.save!

tulip = Plant.find_or_initialize_by(name: "チューリップ")
tulip.description = "ほどよいペースで成長を楽しめる植物です。"
tulip.save!

[
  [sunflower, [["たね", 1, 0], ["発芽", 2, 2500], ["開花", 3, 8000]]],
  [cactus, [["たね", 1, 0], ["発芽", 2, 3000], ["開花", 3, 9000]]],
  [tulip, [["球根", 1, 0], ["発芽", 2, 2000], ["開花", 3, 7000]]]
].each do |plant, stages|
  plant.plant_stages.destroy_all
  stages.each do |name, stage_order, required_points|
    plant.plant_stages.create!(
      name: name,
      stage_order: stage_order,
      required_points: required_points
    )
  end
end
