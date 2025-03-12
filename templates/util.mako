<%def name="seminar_panel(item, collapse=False, date_only=False, panel_id=None)">
<div class="panel panel-default">
  <div class="panel-heading container">
    <div class="row">
      <div class="col-md-3">
        <div>
          % if 'youtube-url' in item:
          <a href="${item['youtube-url']}">
            ${item['name'] | h}
            &nbsp;<i class="fa fa-youtube-play" aria-hidden="true" role="presentation"></i>
          </a>
          % else:
          ${item['name'] | h}
          % endif
        </div>
        % if 'institution' in item:
        <div><small role="presentation">${item['institution'] | h}</small></div>
        % endif
      </div>
      <div class="col-md-6">
        <p>${item['title'] | h}</p>
      </div>
      <div class="col-md-3 text-right">
        <time datetime="${item['date']}">
          <script type="text/javascript">
            <!--
            % if date_only:
            localize_date("${item['date']}", { year: "numeric", month: "long", day: "numeric" });
            % else:
            localize_date("${item['date']}");
            % endif
            //-->
          </script>
          <noscript>${item['date'] | h}</noscript>
        </time>
      </div>
    </div>
  </div>
  % if 'abstract' in item:
  <div id="abstract${panel_id}">
    <div class="panel-body">
      % if 'portrait' in item:
      <div class="col-md-3">
        <div class="portrait pull-left">
          <img class="portrait img-rounded" src="${item['portrait']}" width="${item['portrait-width']}" height="${item['portrait-height']}" alt="${item['name']}"/>
          <div class="text-center"><small role="presentation">${item['name'] | h}</small></div>
        </div>
      </div>
      <div class="col-md-9">
        ${item['abstract'] | trim, md}
      </div>
      % else:
      <div>
        ${item['abstract'] | trim, md}
      </div>
      % endif
    </div>
  </div>
  % endif
</div>
</%def>
