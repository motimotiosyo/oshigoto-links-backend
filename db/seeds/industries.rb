# 業界一覧
industries = {
  "製造業" => %w[自動車 電機・精密 機械 化学・素材 食品・飲料],
  "商社・卸売" => %w[総合商社 専門商社],
  "小売・流通" => %w[百貨店・スーパー コンビニ 専門店 EC],
  "金融" => %w[銀行 証券 保険 クレジット・カード ファイナンス],
  "IT・ソフトウェア" => %w[SIer 受託開発 Webサービス ゲーム インフラ・クラウド AI・データ],
  "建設・不動産" => %w[建設 不動産開発 不動産仲介 設計事務所],
  "医療・福祉" => %w[病院 介護施設 保育施設 製薬 医療機器],
  "サービス・インフラ" => %w[交通・運輸 旅行・観光 ホテル・宿泊 飲食 エネルギー 通信],
  "広告・マスコミ" => %w[広告代理店 出版 テレビ・ラジオ Webメディア],
  "官公庁・教育・団体" => %w[官公庁 公共団体 教育機関 NPO・NGO],
  "農林水産" => %w[農業 林業 漁業],
  "家庭・生活" => %w[家庭生活 地域コミュニティ 家事・育児・介護]
}

# 業界（Industry = 大分類）と、その配下の中分類（IndustryCategory）をまとめて作る処理
industries.each.with_index(1) do |(parent, children), i|
  ind = Industry.find_or_create_by!(code: slugify(parent)) { |r| r.name = parent; r.position = i }
  children.each.with_index(1) do |child, j|
    IndustryCategory.find_or_create_by!(industry: ind, code: slugify(child)) { |c| c.name = child; c.position = j }
  end
end
