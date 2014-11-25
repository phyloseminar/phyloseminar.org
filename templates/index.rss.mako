<?xml version="1.0"?>
<rss version="2.0">
  <channel>
    <title>Phyloseminar</title>
    <link>http://phyloseminar.org/</link>
    <description>phyloseminar -- a free online seminar about phylogenetics</description>
    % for item in upcoming:
    <item>
      <title>
        ${item['name'] | x}: ${item['title'] | x}, ${item['rss_date']}
      </title>
      <link>http://phyloseminar.org/</link>
      % if 'abstract' in item:
      <description>${item['abstract'] | trim, md, x}</description>
      % endif
      <pubDate>${item['posted'] | x}</pubDate>
      <guid>${item['infoname'] | x}</guid>
    </item>
    % endfor
  </channel>
</rss>
