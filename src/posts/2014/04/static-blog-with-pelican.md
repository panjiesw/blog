Title: Static Blog with Pelican
Date: 2014-04-13
Category: Codes
Tags: pelican, python
Slug: static-blog-with-pelican
Disqus: static-blog-with-pelican
Author: Panjie Setiawan Wicaksono
meta_keywords: pelican, python, static, blog, gh-pages, github pages
meta_description: Learn how to make a static blog with Pelican and publish it to Github Pages.
meta_og_image: /static/images/pelican.png
Summary: [Pelican](http://blog.getpelican.com/) is a static site publishing tool. This blog of mine is one of running example using Pelican. This awesome Python based tool is simple, tidy while also has the power to be extendable and scalable. Combine it with [gh-pages](https://pages.github.com) of Github and you will get a fun and _free_ blogging experience without the much more bloated system in _conventional_ CMS. Enough _blabbering_, let's get started!

Been months since my last blog post lol :)) I'll begin to cover my lack of writing enthusiasm by writing about, well, how i create this blog, a happy static site hosted in Github Pages.

[Pelican](http://blog.getpelican.com/) is a static site publishing tool. This blog of mine is one of running example using Pelican. This awesome Python based tool is simple, tidy while also has the power to be extendable and scalable. Combine it with [gh-pages](https://pages.github.com) of Github and you will get a fun and _free_ blogging experience without the much more bloated system in _conventional_ CMS.

You can see a list of Pelican feature at their [blog](http://blog.getpelican.com/). Some of features i'd like to mention are **Markdown + rst content writing** and **Code syntax highlighting**. Markdown and rst are a pleasant to work in writing content. Instead of HTML tag or button-clicking / shortcut remembering in WYSIWYG rich text editor, they let you concentrate in making a great writing with a little syntax. And as this blog will mostly be filled with techie code things (among my other randomness), code syntax highlighting of **Pygments** will surely comes in handy. Already have a site of contents published in **WordPress**? Pelican can import it to static Pelican compatible contents. GREAT!! Enough _blabbering_ and let's get started :)

## Jumps To
- [Requirements](#requirements)
- [Setting up Github account and Github Pages](#github)
- [Setting Up Our Development Environment](#setup-env)
- [Installing Pelican](#install-pelican)
- [The Project Structure](#project-structure)
- [The Workflow](#workflow)
    - [Creating a Blog Post](#createpost)
    - [Publishing Contents](#publishing)
- [What's Next](#next)
    - [Custom Domain with Github Pages](#domain)
    - [Automation Tools](#automation)
- [Alternatives](#alternatives)

<a name="requirements"></a>
## Requirements

- Python ``>=2.6``
- Github account
- Git
- Writing and tinkering enthusiasm :p

<a name="github"></a>
## Setting Up Github Account and Github Pages
We'll use Github Pages as our static content host. As it's static, your contents can easily be hosted anywhere. But with Git, you can track and get version history of your contents. Besides, it's free!!

Go to [Github](https://github.com/) and sign a new account up if you haven't had one, then create a new repository for our blog. For this tutorial i'll name it ``blog``.

Now, for our blog to be accessible, we need to create a new branch called ``gh-pages`` and place our site content (.html, .css files, images, etc.) into it. Later, your blog will have a URL like ``http://youraccount.github.io/blog``.

Personally, i'd like to organize my branches like so:

```text
// in 'master' (default branch)
blog
├── .gitignore
├── local_settings.py
├── local_settings_dev.py
├── README.md
├── requirements.txt
├── settings.py
├── plugins
    ├── plugin_one.py
    ├── other_plugin.py
├── src
    ├── posts
        ├── 2014
            ├── 01
                ├── some-post.md
                ├── another-post.md
```

And in ``gh-pages`` branch, includes all above structures **plus** generated static content in root ``blog`` directory. Messy, don't you think? Don't worry, we'll do almost all work in ``master`` branch so it's ok to have a messy ``gh-pages``, i think.

<a name="setup-env"></a>
## Setting Up Our Development Environment
If you already have ``pip`` and ``virtualenv`` set, then you can skip to the [next section](#install-pelican).

- Install ``setuptools``. Download [ez_setup.py](https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py) and run it using target Python version. This will install ``easy_install`` CLI command to manage packages.

        :::bash
        wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python

    or, to install to the system Python

        :::bash
        wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | sudo python

- Install ``pip``. Using ``easy_install`` above, use superuser privileges if needed.

        :::bash
        easy_install pip

- Install ``virtualenv``. Virtualenv is an environment wrapper to run and install Python packages independent to the system Python packages.

        :::bash
        pip install virtualenv

- Create a new virtual environment for our blog project. In this tutorial, i'll name it ``blog-env``.

        :::bash
        virtualenv blog-env

- Activate the virtual environment.

        :::bash
        cd blog-env
        source ./bin/activate
        # to deactivate it
        deactivate

<a name="install-pelican"></a>
## Installing Pelican
To get Pelican to work we'll need to install it. _duh_.

In our activated virtualenv ``blog-env``, run this command

```bash
pip install pelican
```

<a name="project-structure"></a>
## The Project Structure
Inside the ``blog-env`` folder, create a folder for our blog project, i'll call it ``blog`` same as our repository name we created earlier. Then we need to setup a local git in this folder.

```bash
cd blog
# Initialize git
git init .
# Add remote origin
git remote add origin git@github.com:youraccount/blog.git
```

Create a directory structure of ``blog`` like in master branch organization above. I'll explain each of its use.

- ``.gitignore``, place here any path you don't want to include in your git repository. Here is the example content you can use.

        :::bash
        local_settings*.py
        output

        # Python
        *.py[cod]

        # C extensions
        *.so

        # Packages
        *.egg
        *.egg-info
        dist
        build
        eggs
        parts
        bin
        var
        sdist
        develop-eggs
        .installed.cfg
        lib
        lib64

        # Installer logs
        pip-log.txt

        # Unit test / coverage reports
        .coverage
        .tox
        nosetests.xml

        # Translations
        *.mo

        # Mr Developer
        .mr.developer.cfg
        .project
        .pydevproject

- ``local_settings.py``, contains Pelican settings used in deploying the blog, while ``local_settings_dev.py`` is used in development. Like this, we can customize the settings both when in development, and when we're ready to publish in ``gh-pages`` branch.
    
    We don't want to include this in our repo because it may contain personal data.

    You can see all Pelican available settings [here](http://pelican.readthedocs.org/en/3.3.0/settings.html).

- ``settings.py``, contains the same contents as ``local_settings*`` except we strip all value from it. We'll make this as our reminder of how our settings are defined and include it in our repository. Here is an example of ``settings.py`` contents

        :::python
        # -*- coding: utf-8 -*-

        AUTHOR = 'xxxxxxxx xxxxxxxxxxxxx'
        SITENAME = "xxxxxxxxxxxx"
        SITEURL = 'http://xxxxxxxxxxxxxxxxx'
        TIMEZONE = "Europe/Madrid"

        GITHUB_URL = 'http://github.com/XXXXX'
        DISQUS_SITENAME = "XXXXXXXXXX"
        EMAIL = "XXXXXXXXXXXXXX@gmail.com"
        PDF_GENERATOR = False
        REVERSE_CATEGORY_ORDER = True
        LOCALE = 'en_US'
        DEFAULT_PAGINATION = 5

        THEME = "iris"

        FEED_RSS = 'feeds/all.rss.xml'
        CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

        LINKS = (('XXXXX XXXX', 'http://YYYYYYYYYYY.ZZZ'),)

        SOCIAL = (('twitter', 'http://twitter.com/XXXXXX'),
                  ('linkedin', 'http://www.linkedin.com/in/XXXXXXX'),
                  ('github', GITHUB_URL),)

        OUTPUT_PATH = 'output'
        PATH = 'src'

        ARTICLE_URL = "posts/{date:%Y}/{date:%m}/{slug}/"
        ARTICLE_SAVE_AS = "posts/{date:%Y}/{date:%m}/{slug}/index.html"

        GOSQUARED_SITENAME = "XXX-YYYYYY-X"

        # global metadata to all the contents
        #DEFAULT_METADATA = (('yeah', 'it is'),)

        # static paths will be copied under the same name
        STATIC_PATHS = ["images", ]

        # A list of files to copy from the source to the destination
        #FILES_TO_COPY = (('extra/robots.txt', 'robots.txt'),)

- ``plugins`` folder contains all Pelican plugins used in our blog.
- ``src`` folder contains all Pelican sources which will be generated to static contents. Inside it, there is a ``posts`` folder which contains all our blog posts organized by year, month and date of publishing.

<a name="workflow"></a>
## The Workflow
Now that everything is setup, let's define a workflow to write and publish our post.

We have 2 branches in our local git repo

- ``master`` contains the sources of the blog. We'll write a new ``markdown`` or ``rst`` file for our posts here, add images, and stuff. Basically we do almost all the work in this branch.
- ``gh-pages`` contains the static content generated from the sources. We'll merge the sources from ``master`` branch and regenerate the static contents.

<a name="createpost"></a>
### Creating a Blog Post
To create a blog post, we'll do these steps, in ``master`` branch of our repository.

1. ``master`` -> Write the post with ``markdown`` or ``rst``.

        :::bash
        mkdir -p src/posts/2014/04
        touch src/posts/2014/04/hello-world.md

2. ``master`` -> Generate the static contents to default output path, which is folder ``output``.

        :::bash
        pelican -s ./local_settings_dev.py

3. ``master`` -> Preview the generated static contents in a local server. These commands will run a local server in ``localhost:8000``

        :::bash
        cd output
        # using python 2.6 or 2.7
        python -m SimpleHTTPServer
        # using python 3.x
        python3 -m http.server

You can repeat those steps in development time as much as needed until you satisfied and ready to publish the contents.

<a name="publishing"></a>
### Publishing Contents
When you're ready to publish your contents, we'll do these steps, in ``gh-pages`` of our repository.

1. ``master`` -> Commit the sources change and push it to Github. This won't be the blog, it's just our sources.

        :::bash
        git add .
        git commit -m "Create post: Hello World"
        git push origin master

2. ``master`` -> Create ``gh-pages`` branch if it's not exist yet.

        :::bash
        git branch gh-pages

    Then switch to that branch.

        :::bash
        git checkout gh-pages

3. ``gh-pages`` -> Merge the sources from ``master`` branch.

        :::bash
        git merge master

4. ``gh-pages`` -> Regenerate the static contents. This time we'll use ``local_settings.py`` settings file and set the output path to the root of our repository, so Github Pages can find and serve the contents directly, and because we exclude default ``output`` dir from our Git repo so that won't be available in Github.

        :::bash
        pelican -s ./local_settings.py -o ./

5. ``gh-pages`` -> Preview it again if you like, admire it, kiss it a good luck charm, etc etc
6. ``gh-pages`` -> Commit the changes.

        :::bash
        git add .
        git commit -m "Publish post Hello World, to the World"
        git push origin gh-pages
        # Remember to switch to master after publishing
        git checkout master

7. Visit your Github Pages in a browser with URL ``http://youraccount.github.io/blog`` to see what world see in your blog.

8. Do step 5 again for as much as you want, or make another post if you have lots to share to world.

<a name="next"></a>
## What's Next

<a name="domain"></a>
### Custom Domain with Github Pages
Now maybe you want to use your more attractive domain for your blog, like this blog. Here is how to do that

1. Create a text file named ``CNAME`` in the root dir of your ``gh-pages`` branch.

        :::bash
        git checkout gh-pages
        touch CNAME

2. Write the domain you want to use in there.

        :::text
        blog.derp.com

3. Push the change.

        :::bash
        git add .
        git commit -m "Use blog.derp.com domain"
        git push origin gh-pages
        git checkout master

4. Go to your domain's registrar or wherever you can _properly_ add a DNS record to your domain. Create a new ``CNAME`` record and point it to ``youraccount.github.io``.

5. Wait a little while for the change propagate. This may take minutes or even hours.

To see a more detailed explanation, for example to setup an apex / top-level domain like ``derp.com`` instead of ``blog.derp.com`` like above, go to this [Github Help Article](https://help.github.com/articles/setting-up-a-custom-domain-with-pages)

<a name="automation"></a>
### Automation Tool
With above workflow, it'll become much more repetitive as you develop later. We can cut number of commands we input to create / publish a post with _automation tool_.

There are a lot of automation / task management we can use in Pelican blog project such as

- [**Fabric**](http://www.fabfile.org/) A Python (2.5-2.7) library and command-line tool for streamlining the use of SSH for application deployment or systems administration tasks. It provides a basic suite of operations for executing local or remote shell commands. 

    For a Python based project, a Python tool like this is usefull and doesn't nedd anyother dependencies / language framework. But if you use Python > 3.0, Fabric doesn't support it, as of this time of writing. I'll update this if a version which support Python > 3.0 is available via ``pip``.

- [**Grunt**](http://gruntjs.com/) JavaScript Task Runner. If you have Node.js installed, this automation tool is great for any project. Even better, someone made a plugin [grunt-pelican](https://github.com/chuwy/grunt-pelican) to generate static contents with Pelican, great!! I'll write about how to do this in a post sometime.

<a name="alternatives"></a>
## Alternatives
Static publishing is fun and beside Pelican there are other tools you can use

- [**Frozen-Flask**](https://pythonhosted.org/Frozen-Flask/) freezes a [Flask](http://flask.pocoo.org/) application into a set of static files. It uses Flask, a microframework for Python based on Werkzeug, Jinja 2 and good intentions.

- [**Jekyll**](http://jekyllrb.com/) Transform your plain text into static websites and blogs. It's made with [Ruby](https://www.ruby-lang.org/en/) language and the one which powers the Github Pages.

- [**Octopress**](http://octopress.org/) A framework for Jekyll. It gives a basic Jekyll project with ton of features such as ``rake`` tasks to manage creation and content publishing, a semantic HTML5 template, responsive layout, Built in 3rd party support for Twitter, Google Plus, Disqus, and many more.

<a name="tada"></a>
## Tada
There you are, what a fun way to make blog isn't it? :)

Hope this helps you start your own Pelican blog. If you have any suggestion or want to share your experience, please tell me more about it, Thanks!
