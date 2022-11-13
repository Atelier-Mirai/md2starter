こんにちは 世界

# header 1
## header 2
## header 3
### header 4
#### header 5
#### header 6

*強調*
_強調_
**とっても強調**
__とっても強調__
~~打ち消し線~~

1. item 1
1. item 2
1. item 3
  1. item 3-a
  1. item 3-b
  1. item 3-c

* item 1
* item 2
* item 3
** item 3-a
** item 3-b
** item 3-c

> 色は匂へど　散りぬるを
> 我が世誰そ　常ならむ
> 有為の奥山　今日越えて
> 浅き夢見じ　酔ひもせず

***
- - -
____________

[アトリヱ未來](https://atelier-mirai.net)

作者のウェブサイトは[こちら][アトリヱ未來]です。
[こちら][アトリヱ未來]では情報技術を学ぶ方々を応援しています。
[アトリヱ未來]を是非ご覧ください。
[アトリヱ未來]: https://atelier-mirai.net

https://atelier-mirai.net

[include](index.html)

[include](stylesheets/master.css)


``` include:index.html
```

``` include:stylesheets/master.css
```

include: index.html

include: stylesheets/master.css

![image_caption](image.jpg)

![](image.jpg)

![image_caption](image.jpg?width=50mm)

![image_caption](image.jpg?width=50%&border=on)

``` image:image.jpg?width=50%&border=on&caption=image_captiondayo
```

![](image.jpg?side=L&sep=7mm&width=30mm&boxwidth=40mm&border=on&content=おはようございます)

``` sideimage:image.jpg?side=L&sep=7mm&width=30mm&boxwidth=40mm&border=on
おはようございます
こんにちは
こんばんは
```

| Left align | Center align | Right align |
|:-----------|:------------:|------------:|
| Apple      | Banana       | Cherry      |
| Apple      | Banana       | Cherry      |
| Apple      | Banana       | Cherry      |

Table: caption

| a | b | c |
|---|---|---|
| A |   | C |
|   | B | C |
| A | B |   |


``` math
\left( \sum_{k=1}^n a_k b_k \right)^{\!\!2} \leq
\left( \sum_{k=1}^n a_k^2 \right) \left( \sum_{k=1}^n b_k^2 \right)
```

When $a \ne 0$, there are two solutions to $(ax^2 + bx + c = 0)$ and they are
$$ x = {-b \pm \sqrt{b^2-4ac} \over 2a} $$

ウェブサイト作成には、HTML[^html] と CSS[^css] 、JavaScript[^js] がよく使われます。

[^html]: Hyper Text Markup Language の略です。
[^css]: Cascading Style Sheets の略です。
[^js]: JavaScriptは、ブレンダン・アイクによって開発されました。

円周率πを示す定数`Math::PI`を用いると、半径 `r` の円の面積 `s` は、`s = MATH::PI * r**2 ` と書くことが出来ます。

```
# Output "I love Ruby"
say = "I love Ruby"
puts say
```

``` ruby
# Output "I love Ruby"
say = "I love Ruby"
puts say
```

``` ruby:ruby.rb
# Output "I love Ruby"
say = "I love Ruby"
puts say
```

``` note
note text
note text
note text
```

``` note:note_caption
note text
note text
note text
```

``` output
output text
output text
output text
```

``` output:output_caption
output text
output text
output text
```

``` terminal
terminal text
terminal text
terminal text
```

``` terminal:terminal_caption
terminal text
terminal text
terminal text
```

``` memo
memo text
memo text
memo text
```

``` memo:memo_caption
memo text
memo text
memo text
```

``` tip
tip text
tip text
tip text
```

``` tip:tip_caption
tip text
tip text
tip text
```

``` info
info text
info text
info text
```

``` info:info_caption
info text
info text
info text
```

``` warning
warning text
warning text
warning text
```

``` warning:warning_caption
warning text
warning text
warning text
```

``` important
important text
important text
important text
```

``` important:important_caption
important text
important text
important text
```

``` caution
caution text
caution text
caution text
```

``` caution:caution_caption
caution text
caution text
caution text
```

``` notice
notice text
notice text
notice text
```

``` notice:notice_caption
notice text
notice text
notice text
```

``` column
Rubyとは...
オープンソースの動的なプログラミング言語で、 シンプルさと高い生産性を備えています。 エレガントな文法を持ち、自然に読み書きができます。
```

``` column:Rubyのご紹介
Rubyとは...
オープンソースの動的なプログラミング言語で、 シンプルさと高い生産性を備えています。 エレガントな文法を持ち、自然に読み書きができます。
```

``` flushright
右揃え Right-align
```

``` centering
中央揃え Center-align
```

``` abstract
Text to summarize and introduce this chapter
```

``` abstract:toc=off
Text to summarize and introduce this chapter
```

chapterauthor: Taro

``` chapterauthor:Taro
```

``` chapterauthor
Taro
```

「{難|むつか}しい{漢字|かんじ}」
