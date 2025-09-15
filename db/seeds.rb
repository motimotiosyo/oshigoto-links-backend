# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 開発環境用テストデータ
# NOTE: user_id, industry_id, occupation_idは仮のIDを使用（関連テーブル作成後に修正予定）

puts "Creating development test data..."

# 既存データをクリア（開発環境のみ）
if Rails.env.development?
  ExperiencePost.destroy_all
  puts "Cleared existing experience posts"
end

# テストデータ作成
test_posts = [
  {
    title: "在宅ワークでの集中力向上方法",
    body: "在宅ワークを始めてから集中力を保つのに苦労していましたが、ポモドーロテクニックを導入することで劇的に改善しました。25分集中→5分休憩のサイクルで作業効率が向上し、疲労感も軽減されました。",
    user_id: 1,
    industry_id: 1,
    occupation_id: 1,
    status: "published"
  },
  {
    title: "リモート会議でのコミュニケーション改善",
    body: "リモート会議でうまく発言できずにいましたが、事前にアジェンダを確認し、話すポイントをメモしておくことで自信を持って参加できるようになりました。",
    user_id: 1,
    industry_id: 2,
    occupation_id: 2,
    status: "published"
  },
  {
    title: "家事と仕事の両立で学んだタイムマネジメント",
    body: "育児をしながらフリーランスで働く中で、タスクの優先順位付けと時間の使い方を見直しました。朝の時間を有効活用することで、無理なく両立できています。",
    user_id: 2,
    industry_id: 3,
    occupation_id: 3,
    status: "published"
  },
  {
    title: "副業での経験が本業に活かされた話",
    body: "週末にWebライティングの副業をしていたところ、文章力や情報整理能力が向上し、本業での資料作成やメール対応が格段に改善されました。",
    user_id: 2,
    industry_id: 1,
    occupation_id: 1,
    status: "published"
  },
  {
    title: "未経験からプログラミングを学んだ体験",
    body: "全くの未経験からプログラミングを始めて半年。オンライン学習と実際にコードを書く練習を繰り返すことで、基本的なWebサイトが作れるようになりました。",
    user_id: 3,
    industry_id: 4,
    occupation_id: 4,
    status: "published"
  }
]

created_count = 0
test_posts.each do |post_data|
  post = ExperiencePost.find_or_create_by!(
    title: post_data[:title]
  ) do |experience_post|
    experience_post.body = post_data[:body]
    experience_post.user_id = post_data[:user_id]
    experience_post.industry_id = post_data[:industry_id]
    experience_post.occupation_id = post_data[:occupation_id]
    experience_post.status = post_data[:status]
    experience_post.published_at = Time.current
  end
  created_count += 1 if post.previously_new_record?
end

puts "Created #{created_count} experience posts"
puts "Total experience posts: #{ExperiencePost.count}"
