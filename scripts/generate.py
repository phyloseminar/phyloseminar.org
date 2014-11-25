from PIL import Image
from mako.lookup import TemplateLookup
from mako.runtime import Context
from mako.template import Template
import codecs
import datetime
import dateutil.tz, dateutil.parser
import functools
import glob
import itertools
import mako.exceptions
import markdown
import operator
import os
import shutil
import urlparse
import yaml

md = functools.partial(markdown.markdown, output_format='xhtml')

def render(name, **kwargs):
    lookup = TemplateLookup(directories=['templates'], imports=['from generate import md'])
    tmpl = lookup.get_template("{0}.mako".format(name))

    filename = name
    if '.' not in filename:
        filename += '.html'
    with codecs.open(os.path.join('webpage', filename), 'wb',
                     encoding='utf-8') as outfile:
        ctx = Context(outfile, **kwargs)
        try:
            tmpl.render_context(ctx)
        except:
            outfile.seek(0)
            outfile.truncate()
            mako.exceptions.html_error_template().render_context(ctx)
            raise

def main():
    with open('config.yaml') as infile:
        config = yaml.load(infile)
    localtime = dateutil.tz.gettz(config['local-timezone'])
    now = datetime.datetime.now(localtime)
    recorded, upcoming, for_rss = [], [], []

    for info in sorted(glob.glob('./material/*/info.yaml')):
        infodir = os.path.dirname(info)
        infoname = os.path.basename(infodir)
        with open(info) as infile:
            info = yaml.load(infile)
        info['infoname'] = infoname

        try:
            with codecs.open(os.path.join(infodir, 'abstract.txt'), encoding='utf-8') as infile:
                info['abstract'] = infile.read()
        except IOError:
            pass

        if info.get('date'):
            date = dateutil.parser.parse(info['date']).replace(tzinfo=localtime)
            in_future = date > now
            info['date'] = date.isoformat()
            info['rss_date'] = date.strftime("%Y-%m-%d %H:%M %Z")
        else:
            in_future = True

        if info.get('posted'):
            posted = dateutil.parser.parse(info['posted']).replace(tzinfo=localtime)
            if posted < now:
                for_rss.append(info)
            info['posted'] = posted.isoformat()

        if in_future:
            portrait = glob.glob(os.path.join(infodir, '*.jpg'))
            if portrait:
                portrait, = portrait
                portrait_name = infoname + '.jpg'
                shutil.copyfile(
                    portrait, os.path.join('webpage/images', portrait_name))

                info['portrait'] = 'images/' + portrait_name

                img = Image.open(portrait)
                info['portrait-width'], info['portrait-height'] = img.size

            upcoming.append(info)

        else:
            if 'evx-file' in info:
                info['evx-url'] = urlparse.urljoin(config['evx-url-base'], info['evx-file'])
            recorded.append(info)

    render('recorded',
           categories=itertools.groupby(recorded, operator.itemgetter('category')))

    render('index',
           upcoming=upcoming[0] if upcoming else None,
           categories=itertools.groupby(upcoming[1:], operator.itemgetter('category')))

    # render the last five in reverse order
    render('index.rss', upcoming=for_rss[:-6:-1])

    #render('schedule',
    #       categories=itertools.groupby(upcoming, operator.itemgetter('category')))

if __name__ == '__main__':
    main()
