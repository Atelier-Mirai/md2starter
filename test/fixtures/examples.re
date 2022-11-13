こんにちは 世界

= header 1
== header 2
== header 3
=== header 4
==== header 5
==== header 6
@<b>{強調}
@<b>{強調}
@<B>{とっても強調}
@<B>{とっても強調}
@<del>{打ち消し線}

 1. item 1
 1. item 2
 1. item 3
 1. item 3-a
 1. item 3-b
 1. item 3-c

 * item 1
 * item 2
 * item 3
 * ** item 3-a
 * ** item 3-b
 * ** item 3-c

//quote{
色は匂へど　散りぬるを
我が世誰そ　常ならむ
有為の奥山　今日越えて
浅き夢見じ　酔ひもせず
//}

//hr

//hr

//hr

@<href>{https://atelier-mirai.net,アトリヱ未來}

作者のウェブサイトは@<href>{https://atelier-mirai.net,こちら}です。
@<href>{https://atelier-mirai.net,こちら}では情報技術を学ぶ方々を応援しています。
@<href>{https://atelier-mirai.net,アトリヱ未來}を是非ご覧ください。

@<href>{https://atelier-mirai.net}

//list[][index.html][file=source/index.html,1]{
//}

//list[][master.css][file=source/stylesheets/master.css,1]{
//}

//list[][index.html][file=source/index.html,1]{
//}

//list[][master.css][file=source/stylesheets/master.css,1]{
//}

//list[][index.html][file=source/index.html,1]{
//}

//list[][master.css][file=source/stylesheets/master.css,1]{
//}

//image[image][image_caption][]

//image[image][][]

//image[image][image_caption][width=50mm]

//image[image][image_caption][width=50%,border=on]

//image[image][image_captiondayo][width=50%,border=on]

//sideimage[image][30mm][side=L,sep=7mm,boxwidth=40mm,border=on]{
おはようございます
//}

//sideimage[image][30mm][side=L,sep=7mm,boxwidth=40mm,border=on]{
おはようございます
こんにちは
こんばんは
//}

//tsize[][|l|l|l|]
//table[][][csv=on,headerrows=1]{
Left align, Center align, Right align
Apple, Banana, Cherry
Apple, Banana, Cherry
Apple, Banana, Cherry
//}

//tsize[][|l|l|l|]
//table[][caption][csv=on,headerrows=1]{
a, b, c
A,  , C
 , B, C
A, B,  
//}

//texequation[][]{
\left( \sum_{k=1}^n a_k b_k \right)^{\!\!2} \leq
\left( \sum_{k=1}^n a_k^2 \right) \left( \sum_{k=1}^n b_k^2 \right)
//}

When @<m>{a \ne 0}, there are two solutions to @<m>{(ax^2 + bx + c = 0)} and they are

//texequation[][]{
 x = {-b \pm \sqrt{b^2-4ac} \over 2a} 
//}


ウェブサイト作成には、HTML@<fn>{1} と CSS@<fn>{2} 、JavaScript@<fn>{3} がよく使われます。

円周率πを示す定数@<code>{Math::PI}を用いると、半径 @<code>{r} の円の面積 @<code>{s} は、@<code>{s = MATH::PI * r**2} と書くことが出来ます。

//list[][][1]{
# Output "I love Ruby"
say = "I love Ruby"
puts say
//}

//list[][][1]{
# Output "I love Ruby"
say = "I love Ruby"
puts say
//}

//list[][ruby.rb][1]{
# Output "I love Ruby"
say = "I love Ruby"
puts say
//}

//note[][]{
note text
note text
note text
//}

//note[][note_caption]{
note text
note text
note text
//}

//output[][]{
output text
output text
output text
//}

//output[][output_caption]{
output text
output text
output text
//}

//terminal[][]{
terminal text
terminal text
terminal text
//}

//terminal[][terminal_caption]{
terminal text
terminal text
terminal text
//}

//memo[]{
memo text
memo text
memo text
//}

//memo[memo_caption]{
memo text
memo text
memo text
//}

//tip[]{
tip text
tip text
tip text
//}

//tip[tip_caption]{
tip text
tip text
tip text
//}

//info[]{
info text
info text
info text
//}

//info[info_caption]{
info text
info text
info text
//}

//warning[]{
warning text
warning text
warning text
//}

//warning[warning_caption]{
warning text
warning text
warning text
//}

//important[]{
important text
important text
important text
//}

//important[important_caption]{
important text
important text
important text
//}

//caution[]{
caution text
caution text
caution text
//}

//caution[caution_caption]{
caution text
caution text
caution text
//}

//notice[]{
notice text
notice text
notice text
//}

//notice[notice_caption]{
notice text
notice text
notice text
//}

===[column] 
Rubyとは...
オープンソースの動的なプログラミング言語で、 シンプルさと高い生産性を備えています。 エレガントな文法を持ち、自然に読み書きができます。

===[/column]

===[column] Rubyのご紹介
Rubyとは...
オープンソースの動的なプログラミング言語で、 シンプルさと高い生産性を備えています。 エレガントな文法を持ち、自然に読み書きができます。

===[/column]

//flushright{
右揃え Right-align
//}

//centering{
中央揃え Center-align
//}

//abstract{
Text to summarize and introduce this chapter
//}

//makechaptitlepage[toc=on]

//abstract{
Text to summarize and introduce this chapter
//}

//chapterauthor[Taro]

//chapterauthor[Taro]

//chapterauthor[Taro]

「@<ruby>{難,むつか}しい@<ruby>{漢字,かんじ}」

//footnote[1][Hyper Text Markup Language の略です。]
//footnote[2][Cascading Style Sheets の略です。]
//footnote[3][JavaScriptは、ブレンダン・アイクによって開発されました。]
