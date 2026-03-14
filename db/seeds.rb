sunflower = Plant.find_or_initialize_by(name: "ひまわり")
sunflower.description = "はじめてでも育てやすい植物です。"
sunflower.save!

cactus = Plant.find_or_initialize_by(name: "サボテン")
cactus.description = "じっくり気長に育てたい植物です。"
cactus.save!

tulip = Plant.find_or_initialize_by(name: "チューリップ")
tulip.description = "ほどよいペースで成長を楽しめる植物です。"
tulip.save!

sunflower_image_path = Rails.root.join("db/seeds/images/sunflower.jpeg")
if File.exist?(sunflower_image_path) && !sunflower.image.attached?
  sunflower.image.attach(
    io: File.open(sunflower_image_path),
    filename: "sunflower.jpeg"
  )
end

cactus_image_path = Rails.root.join("db/seeds/images/cactus.jpeg")
if File.exist?(cactus_image_path) && !cactus.image.attached?
  cactus.image.attach(
    io: File.open(cactus_image_path),
    filename: "cactus.jpeg"
  )
end

tulip_image_path = Rails.root.join("db/seeds/images/tulip.jpeg")
if File.exist?(tulip_image_path) && !tulip.image.attached?
  tulip.image.attach(
    io: File.open(tulip_image_path),
    filename: "tulip.jpeg"
  )
end

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
