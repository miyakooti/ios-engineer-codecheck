## メッセージ
- UIのブラッシュアップやコードの改善などまだまだやりたいことがたくさんあります！！
- Issuesに対応するPRを毎回投げるようにしました。closedしたPRを見て頂ければ分かりやすいと思います。
- 配列は複数形の名前にしました
- tableViewVCそのまま使うと良くないので、VCに継承させる形で実装しました
- デリゲートメソッドはすべてextensionを利用して、記述場所を分割しました

## issue2
配列は複数形の名前にしました

略称はつけず、抽象的な名前を排除しました

（PR作るの忘れました、、）

## [issue3](https://github.com/miyakooti/ios-engineer-codecheck/pull/1)
guardで強制アンラップを削除しました

## [issue4](https://github.com/miyakooti/ios-engineer-codecheck/pull/2)
[weak self]で循環参照を消去しました


エラーハンドリングを追加しました


オートレイアウトのエラーを修正しました

## issue5
下位互換なので未着手

## [issue6](https://github.com/miyakooti/ios-engineer-codecheck/pull/3)
使わない変数を渡さないなどしました（インターフェース分離）

## [issue7](https://github.com/miyakooti/ios-engineer-codecheck/pull/5)
MVPを採用しましたが画面遷移がsegueのままにしてしまったので、それに伴ってdetailVCが少し汚くなってしまいました。handOverInitialDataのところが特に汚い。
遷移するときViewにデータが渡ってしまいかつアクションもないため、初回のデータを利用していろいろ処理するために定義しました。
Routerクラスなどを設けてやるべきでした。

PassiveViewを採用したつもりですが、ViewDidLoad()を起点とした処理が行われているため、PassiveViewと言えるのかどうかわかりません。。

## issue8
未着手

## [issue9](https://github.com/miyakooti/ios-engineer-codecheck/pull/7)
検索待ってる間に何も表示されないのは顧客体験的に悪いなと感じたので、クルクルを追加しました
検索結果が無かったときの対応なども追加したいです

## issue10
テスト書いたことがほぼ無くうまく行かなかったため、マージしていません、、


## これからやりたいこと
- 画面遷移をRouterで実装
- 検索結果がなかったときのアラート表示
- storyboardをVCごとに分割して保守性を高める
- 〇〇の原則、一回やってからコードかなり変えてしまったので、もう一回見直す
- ライフサイクルメソッドの中は小さくしたい
- Segueをやめたい
- テスト追加
