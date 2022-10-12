test = ""

%w(math output terminal note memo tip info warning important caution notice column flushright centering abstract chapterauthor include sonohoka).each do |word|
  str = <<~"EOS"
  ### #{word}

  \`\`\` #{word}
  \`\`\`

  \`\`\` #{word}
  source_code
  \`\`\`

  \`\`\` #{word}:caption
  source_code
  \`\`\`

  EOS

  test << str
end

puts test
