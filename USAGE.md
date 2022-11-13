# MD2Starter

記法の説明をします。We will explain the notation.

## 普通の文章 plain text

```
こんにちは 世界
Hello World
```

```
こんにちは 世界
Hello World
```

## 見出し header

```
# header 1
## header 2
## header 3
### header 4
#### header 5
#### header 6
```

```
= header 1

== header 2

=== header 3

==== header 4

===== header 5

====== header 6
```

## 文字の装飾 text decoration

```
 *強調*
 _強調_
 **とっても強調**
 __とっても強調__
 ~~打ち消し線~~

 *emphasis*
 _emphasis_
 **double_emphasis**
 __double_emphasis__
 ~~strikethrough~~
```

```
@<b>{強調}
@<b>{強調}
@<B>{とっても強調}
@<B>{とっても強調}
@<del>{打ち消し線}

@<b>{emphasis}
@<b>{emphasis}
@<B>{double_emphasis}
@<B>{double_emphasis}
@<del>{strikethrough}
```

## 順序付項目 ordered list

```
1. item 1
1. item 2
1. item 3
  1. item 3-a
  1. item 3-b
  1. item 3-c
```

```
1. item 1
1. item 2
1. item 3
1. item 3-a
1. item 3-b
1. item 3-c
```

入れ子には対応していませんので、適宜修正してください。
Nesting is not supported, so please modify accordingly.

## 箇条書項目 unordered list

```
* item 1
* item 2
* item 3
** item 3-a
** item 3-b
** item 3-c
```

```
* item 1
* item 2
* item 3
* ** item 3-a
* ** item 3-b
* ** item 3-c
```

入れ子には対応していませんので、適宜修正してください。
Nesting is not supported, so please modify accordingly.

## 引用 blockquotes

```
> 色は匂へど　散りぬるを
> 我が世誰そ　常ならむ
> 有為の奥山　今日越えて
> 浅き夢見じ　酔ひもせず

> Alfa, Bravo, Charlie, Delta, Echo, Foxtrot, Golf,
> Hotel, India, Juliett, Kilo, Lima, Mike, November,
> Oscar, Papa, Quebec, Romeo, Sierra, Tango, Uniform,
> Victor, Whiskey, Xray, Yankee, Zulu
```

```
//quote{
色は匂へど　散りぬるを
我が世誰そ　常ならむ
有為の奥山　今日越えて
浅き夢見じ　酔ひもせず

Alfa, Bravo, Charlie, Delta, Echo, Foxtrot, Golf,
Hotel, India, Juliett, Kilo, Lima, Mike, November,
Oscar, Papa, Quebec, Romeo, Sierra, Tango, Uniform,
Victor, Whiskey, Xray, Yankee, Zulu
//}
```

## 水平線 horizontal rule

\* (アスタリスク), - (ハイフン), _ (アンダーバー) を3つ以上並べることで、水平線になります。Three or more * (asterisk), - (hyphen), or _ (underscore) in a row makes a horizontal line.

```
***
- - -
____________
```

```
//hr

//hr

//hr
```

## リンク link

### 通常の使い方 Normal usage

```
[アトリヱ未來](https://atelier-mirai.net)[Atelier Mirai](https://atelier-mirai.net)
```

```
@<href>{https://atelier-mirai.net,アトリヱ未來}@<href>{https://atelier-mirai.net,Atelier Mirai}
```

### URLに名前を付けて用いる Use a name for the URL

```
作者のウェブサイトは[こちら][アトリヱ未來]です。
[こちら][アトリヱ未來]では情報技術を学ぶ方々を応援しています。
[アトリヱ未來]を是非ご覧ください。
[アトリヱ未來]: https://atelier-mirai.net

The author's website is [here][Atelier Mirai].
At [here][Atelier Mirai], we support people who study information technology.
Please visit [Atelier Mirai].
[Atelier Mirai]: https://atelier-mirai.net
```

```
作者のウェブサイトは@<href>{https://atelier-mirai.net,こちら}です。
@<href>{https://atelier-mirai.net,こちら}では情報技術を学ぶ方々を応援しています。
@<href>{https://atelier-mirai.net,アトリヱ未來}を是非ご覧ください。

The author's website is @<href>{https://atelier-mirai.net,here}.
At @<href>{https://atelier-mirai.net,here}, we support people who study information technology.
Please visit @<href>{https://atelier-mirai.net,Atelier Mirai}.
```

* 自動リンク autolink
そのまま記載されたURLは、リンクになります。URLs listed as is are links.

```
https://atelier-mirai.net
```

```
@<href>{https://atelier-mirai.net}
```

### source ディレクトリのファイルを取り込む Include files in the source directory

HonKit / GitBookの記法が可能です。HonKit / GitBook notation is available.

```
[include](index.html)
[include](stylesheets/master.css)
```

ブロックコード記法も使えます。Block code notation can also be used.

````
``` include:index.html
```

``` include:stylesheets/master.css
```
````

簡潔に一行で書くことも出来ます。It can also be written in one concise line.

```
include: index.html

include: stylesheets/master.css
```

何れの記法も出力結果は同じです。The output result is the same for all notation.

```
//list[][index.html][file=source/index.html,1]{
//}

//list[][master.css][file=source/stylesheets/master.css,1]{
//}
```


## 画像 images

### 通常の使い方 Normal usage

```
![image_caption](image.jpg)
```

```
//image[image][image_caption][]
```

### 見出しを付けない使い方 Usage without image caption

```
![](image.jpg)
```

```
//image[image][][]
```

### 様々なオプション Various options
Starter では、画像のための様々なオプションを指定することが出来ます。
Starter で用意されている width / border / side / sep / boxwidth の各オプションと、
独自に用意した content / caption オプションがございます。

Starter allows you to specify various options for images.
In addition to the width, border, side, sep, and boxwidth options provided in Starter
Starter provides width, border, side, sep, and boxwidth options, as well as content and caption options.

画像表示幅を50mmにする Set the image display width to 50 mm

```
![image_caption](image.jpg?width=50mm)
```

```
//image[image][image_caption][width=50mm]
```

画像表示幅を頁幅の50%にし、画像を枠線で囲む Set the image display width to 50% of the page width and surround the image with a border.

```
![image_caption](image.jpg?width=50%&border=on)
```

```
//image[image][image_caption][width=50%,border=on]
```

同じ例ですが、次のようなブロックコード形式で記述することも出来ます。The same example can be written in block code form as follows.

````
``` image:image.jpg?width=50%&border=on&caption=image_caption
```
````

Starter では、画像をテキストを並べて表示できるよう、「//sideimage」が用意されています。
次のように記述することで、sideimage に対応します。
Starter provides "//sideimage" so that images can be displayed alongside text.
The following description will support sideimage.

画像が左側、画像と本文(content)との余白幅7mm、画像幅30mm、画像を表示する領域の幅40mm(省略可)、画像を枠線で囲み、本文(content)として「おはようございます」を表示する
Image on the left, 7mm margin width between image and body text (content), 30mm image width, 40mm width of area displaying image (can be omitted), border around image, and "Good morning" as body text (content)

```
![](image.jpg?side=L&sep=7mm&width=30mm&boxwidth=40mm&border=on&content=おはようございます)
```

```
![](image.jpg?side=L&sep=7mm&width=30mm&boxwidth=40mm&border=on&content=good morning
```

複数行の本文(content)を記載したい例もあるかと思います。次のようなブロックコード形式で記述することも出来ます。
May be used to describe a multi-line body (content). It can be written in block code format as follows.

````
``` sideimage:image.jpg?side=L&sep=7mm&width=30mm&boxwidth=40mm&border=on
おはようございます
こんにちは
こんばんは
```
````

````
``` sideimage:image.jpg?side=L&sep=7mm&width=30mm&boxwidth=40mm&border=on
good morning
hello
good evening
```
````

(//sideimage では、画像への見出し(caption)は無効です。For //sideimage, the caption to the image is disabled.)

## 表 table

### 通常の使い方 Normal usage

```
| Left align | Center align | Right align |
|:-----------|:------------:|------------:|
| Apple      | Banana       | Cherry      |
| Apple      | Banana       | Cherry      |
| Apple      | Banana       | Cherry      |
```

```
//tsize[][|l|l|l|]
//table[][][csv=on,headerrows=1]{
Left align, Center align, Right align
Apple, Banana, Cherry
Apple, Banana, Cherry
Apple, Banana, Cherry
//}
```


Starterでは、CSV形式の表がサポートされているので、CSV形式の表として変換されます。
In Starter, tables in CSV format are supported, so they are converted as CSV-formatted tables.

各セルの位置揃えは、Starter形式に変換する際には、全て「左揃え」となります。必要に応じ、```//tsize[][|l|l|l|]``` を ```//tsize[][|l|c|r|]```に修正して下さい。
All alignment of each cell will be "left-aligned" when converted to Starter format. If necessary, modify ```//tsize[][|l|l|l|]``` to ```//tsize[][|l|c|r|]```.


### 見出しを付けた使い方 Usage with table caption

```
Table: caption

| a | b | c |
|---|---|---|
| A |   | C |
|   | B | C |
| A | B |   |
```

```
//tsize[][|l|l|l|]
//table[][caption][csv=on,headerrows=1]{
a, b, c
A,  , C
 , B, C
A, B,  
//}
```

## 数式 math

### 通常の使い方 Normal usage

````
``` math
\left( \sum_{k=1}^n a_k b_k \right)^{\!\!2} \leq
\left( \sum_{k=1}^n a_k^2 \right) \left( \sum_{k=1}^n b_k^2 \right)
```
````

### GitHub 拡張形式 GitHub Extended Format

> [Markdown Math support](https://github.blog/2022-05-19-math-support-in-markdown/)
> GitHub上のMarkdownで$と$$の区切り文字をネイティブに使用し、TeXやLaTeX風の構文で数式を挿入することができるようになりました。You can use the $ and $$ delimiters natively in Markdown on GitHub to insert math expressions in TeX and LaTeX style syntax.


「$」〜「$」で、インライン数式を記述できます。
「$$」〜 「$$」で、ブロック数式となります。

```
When $a \ne 0$, there are two solutions to $(ax^2 + bx + c = 0)$ and they are
$$ x = {-b \pm \sqrt{b^2-4ac} \over 2a} $$
```

「$」〜「$」で、書かれたインライン数式を変換したい場合には、「--math」オプションを使用してください。(正規表現やjQuery等のプログラムコードもインライン数式と見なされます。もし誤って変換された際には適宜修正してください。)

If you want to convert inline formulas written with "$" to "$", use the "--math" option. (Regular expressions and program code such as jQuery are also considered inline formulas. If they are converted incorrectly, please correct them accordingly.)

## 脚注 footnote

```
ウェブサイト作成には、HTML[^html] と CSS[^css] 、JavaScript[^js] がよく使われます。
HTML[^html], CSS[^css], and JavaScript[^js] are often used to create websites.

[^html]: Hyper Text Markup Language の略です。
[^css]: Cascading Style Sheets の略です。
[^js]: JavaScriptは、ブレンダン・アイクによって開発されました。

[^html]: It stands for Hyper Text Markup Language.
[^css]: It stands for Cascading Style Sheets.
[^js]: JavaScript was developed by Brendan Eich.
```

```
ウェブサイト作成には、HTML@<fn>{1} と CSS@<fn>{2} 、JavaScript@<fn>{3} がよく使われます。
//footnote[1][Hyper Text Markup Language の略です。]
//footnote[2][Cascading Style Sheets の略です。]
//footnote[3][JavaScriptは、ブレンダン・アイクによって開発されました。]

HTML@<fn>{1}, CSS@<fn>{2}, and JavaScript@<fn>{3} are often used to create websites.
//footnote[1][It stands for Hyper Text Markup Language.]
//footnote[2][It stands for Cascading Style Sheets.]
//footnote[3][JavaScript was developed by Brendan Eich.]
```

## インラインコード code span

```
円周率πを示す定数`Math::PI`を用いると、半径 `r` の円の面積 `s` は、`s = MATH::PI * r**2 ` と書くことが出来ます。
Using the constant `Math::PI`, which denotes π, the area `s` of a circle of radius `r` can be written as `s = MATH::PI * r**2 `.
```

```
円周率πを示す定数@<code>{Math::PI}を用いると、半径 @<code>{r} の円の面積 @<code>{s} は、@<code>{s = MATH::PI * r**2} と書くことが出来ます。
Using the constant @<code>{Math::PI}, which denotes π, the area @<code>{s} of a circle of radius @<code>{r} can be written as @<code>{s = MATH::PI * r**2}.
```

## コードブロック code blocks

````
```
# Output "I love Ruby"
say = "I love Ruby"
puts say
```
````

```
//list[][][1]{
# Output "I love Ruby"
say = "I love Ruby"
puts say
//}
```

````
``` ruby
# Output "I love Ruby"
say = "I love Ruby"
puts say
```
````

```
//list[][][1]{
# Output "I love Ruby"
say = "I love Ruby"
puts say
//}
```

````
``` ruby:ruby.rb
# Output "I love Ruby"
say = "I love Ruby"
puts say
```
````

```
//list[][ruby.rb][1]{
# Output "I love Ruby"
say = "I love Ruby"
puts say
//}
```

引用元 Quote [Ruby](https://www.ruby-lang.org)


## Re:VIEW Starter の 拡張記法 Extension for Re:VIEW Starter

コードブロックの言語名を流用することで、Starter形式の拡張に対応しています。
Starter-style extensions are supported by substituting the language name in the code block.

### note / output / terminal / memo / tip / info / warning / important / caution / notice

````
``` note
note text
note text
note text
```
````

```
//note[][]{
note text
note text
note text
//}
```

````
``` note:note_caption
note text
note text
note text
```
````

```
//note[][note_caption]{
note text
note text
note text
//}
```

### コラム column

````
``` column
Rubyとは...
オープンソースの動的なプログラミング言語で、 シンプルさと高い生産性を備えています。 エレガントな文法を持ち、自然に読み書きができます。
```
````

````
===[column]
Rubyとは...
オープンソースの動的なプログラミング言語で、 シンプルさと高い生産性を備えています。 エレガントな文法を持ち、自然に読み書きができます。

===[/column]
````

````
``` column:Rubyのご紹介
Rubyとは...
オープンソースの動的なプログラミング言語で、 シンプルさと高い生産性を備えています。 エレガントな文法を持ち、自然に読み書きができます。
```
````

````
===[column] Rubyのご紹介
Rubyとは...
オープンソースの動的なプログラミング言語で、 シンプルさと高い生産性を備えています。 エレガントな文法を持ち、自然に読み書きができます。

===[/column]
````

````
``` column
Ruby is...
A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.
```
````

```
===[column]
Ruby is...
A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.

===[/column]
```

````
``` column:Introduction_to_Ruby
Ruby is...
A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.
```
````

```
===[column] Introduction_to_Ruby
Ruby is...
A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.

===[/column]
```
(Note that "Introduction to Ruby" separated by a space will not be converted correctly.)


引用元 Quote [Ruby](https://www.ruby-lang.org)


### 右揃え Right-align / 中央揃え Center-align

````
``` flushright
右揃え Right-align
```
````

```
//flushright{
右揃え Right-align
//}
```

````
``` centering
中央揃え Center-align
```
````

```
//centering{
中央揃え Center-align
//}
```

## 概要 abstract

````
``` abstract
本章の概要と紹介のためのテキスト
Text to abstract and introduce this chapter
```
````

```
//abstract{
本章の概要と紹介のためのテキスト
Text to abstract and introduce this chapter
//}

//makechaptitlepage[toc=on]
```

````
``` abstract:toc=off
本章の概要と紹介のためのテキスト
Text to abstract and introduce this chapter
```
````

```
//abstract{
本章の概要と紹介のためのテキスト
Text to abstract and introduce this chapter
//}
```

## 章執筆者 chapter author
概要の後に、その章を執筆した著者名を記すことが出来ます。
After the summary, you can note the name of the author(s) who wrote the chapter.

三通りの記法を用意しました。お好みの形式をお使いください。
There are three different formats available. Please use the format you prefer.

````
chapterauthor: Taro
````
````
``` chapterauthor:Taro
```
````
````
``` chapterauthor
Taro
```
````

何れの記法も出力結果は同じです。The output result is the same for all notation.

```
//chapterauthor[Taro]
```

## るび ruby

「難しい漢字」に「るび」を付けるには次のように書きます。
To add "ruby" to "difficult kanji", write as follows.

```
「{難|むつか}しい{漢字|かんじ}」
"{難|mutsuka}shii {漢字|kanji}".
```

```
「@<ruby>{難,むつか}しい@<ruby>{漢字,かんじ}」
"@<ruby>{難,mutsuka}shii @<ruby>{漢字,kanji}".
```

以上、マークダウン記法と、Starter形式への拡張記法のご紹介でした。
ご活用いただければ幸いです。

This is an introduction to markdown notation and its extension to Starter format.
We hope you will find them useful.
