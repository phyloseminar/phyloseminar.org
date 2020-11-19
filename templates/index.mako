---
layout: inset
title: phyloseminar.org | home
id: home
---

<%namespace name="util" file="util.mako"/>


<h1>next on phyloseminar.org</h1>
<p>
  <i>To attend a seminar, visit our <a href="http://youtube.com/phyloseminar">YouTube channel</a>.</i>
</p>
% if upcoming:
<h2>${upcoming['category'] | h}</h2>
<div class="panel panel-default">
  <div class="panel-heading container">
    <div class="col-md-3">
      <div>${upcoming['name'] | h}</div>
      % if 'institution' in upcoming:
      <div><small role="presentation">${upcoming['institution'] | h}</small></div>
      % endif
    </div>
    <div class="col-md-6">
      <p>${upcoming['title'] | h}</p>
    </div>
    <div class="col-md-3 text-right">
      <time datetime="${upcoming['date']}">
        <script type="text/javascript">
          <!--
          localize_date("${upcoming['date']}");
          //-->
        </script>
        <noscript>${upcoming['date'] | h}</noscript>
      </time>
    </div>
  </div>
  % if 'abstract' in upcoming:
  <div class="panel-body">
    % if 'portrait' in upcoming:
    <div class="col-md-3">
      <div class="portrait pull-left">
        <img class="portrait img-rounded" src="${upcoming['portrait']}" width="${upcoming['portrait-width']}" height="${upcoming['portrait-height']}" alt="${upcoming['name']}"/>
        <div class="text-center"><small role="presentation">${upcoming['name'] | h}</small></div>
      </div>
    </div>
    <div class="col-md-9">
      ${upcoming['abstract'] | trim, md}
    </div>
    % else:
    <div>
      ${upcoming['abstract'] | trim, md}
    </div>
    % endif
  </div>
  % endif
</div>
<div class="panel-group" id="seminars">
  % for category, rows in categories:
  % if category != upcoming['category']:
  <h2>${category | h}</h2>
  % endif
  % for item in rows:
  ${util.seminar_panel(item, collapse=True, date_only=False, panel_id="{0}{1}".format(loop.parent.index, loop.index))}
  % endfor
  % endfor
</div>
% else:
<p>
  We are in the process of planning the next set of talks.<br>
</p>
<p>
  If you haven't already, take a look at the <a href="recorded.html">recorded talks</a>.<br>
<p>
  Check back soon, or follow us on
  <a href="http://twitter.com/phyloseminar">Twitter</a>
  to find out about upcoming seminars!
</p>
% endif
