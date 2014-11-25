---
layout: inset
title: phyloseminar.org | schedule
id: schedule
---

<%namespace name="util" file="util.mako"/>

<h1>upcoming seminars</h1>
<div class="panel-group" id="seminars">
  % for category, rows in categories:
  <h2>${category | h}</h2>
  % for item in rows:
  ${util.seminar_panel(item, collapse=True, date_only=False, panel_id="{0}{1}".format(loop.parent.index, loop.index))}
  % endfor
  % endfor
</div>
