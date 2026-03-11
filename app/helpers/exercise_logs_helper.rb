module ExerciseLogsHelper
  def exercise_type_label(exercise_type)
    {
      "walk" => "散歩",
      "strength_training" => "筋トレ",
      "stretching" => "ストレッチ",
      "running" => "ランニング",
      "yoga" => "ヨガ"
    }[exercise_type] || exercise_type
  end
end
