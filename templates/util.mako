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
    % if collapse and 'abstract' in item:
    <div class="row text-center">
      <a class="accordion-toggle" data-bs-toggle="collapse" data-bs-target="#abstract${panel_id}" aria-expanded="false" aria-controls="abstract${panel_id}" role="button">
        <i class="fa fa-angle-down" aria-hidden="true" role="presentation"></i>
        <span class="sr-only">expand abstract</span>
      </a>
    </div>
    % endif
  </div>
  % if 'abstract' in item:
  % if collapse:
  <div id="abstract${panel_id}" class="collapse">
  % else:
  <div id="abstract${panel_id}">
  % endif
    <div class="panel-body">${item['abstract'] | trim, md}</div>
  </div>
  % endif
</div>
</%def>
