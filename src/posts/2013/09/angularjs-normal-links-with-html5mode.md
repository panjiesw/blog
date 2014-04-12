Title: AngularJS Normal Links with HTML5 Mode
Date: 2013-09-26
Category: Codes
Tags: javascript, coffeescript, angularjs, html5, reminder
Slug: angularjs-normal-links-with-html5mode
Disqus: angularjs-normal-links-with-html5mode
meta_description: How to do full page reload with AngularJS HTML5 Mode.
meta_og_description: How to do full page reload with AngularJS HTML5 Mode.
meta_og_image: /static/images/angularjs.jpg
Author: Panjie Setiawan Wicaksono
Summary: HTML5 Mode, a configuration mode of [$location service](http://docs.angularjs.org/api/ng.$location) in angularjs, uses HTML5 History API which one of its usage is to enrich client side interaction in a web application. When the $location service configured with this mode, browser will not do a full page reload when its URL is changed, without the need of hashbang ``#!`` in part of URL. But what if, in one time, you need a full page reload to react on browser's URL change? Such as signing a user out, which usually is handled by server side of your app.

Yeah! At last, some code in this boring blog! :p

Since the first time i played with [AngularJS](http://angularjs.org) i have been enjoying the experience of developing a rich web application. I won't describe what it is or compare it with other client side javascript frameworks out there here right now, maybe some other time. Instead, also as a kind of note for myself, i will only write here a portion of one of its feature, HTML5 Mode in $location service.

HTML5 Mode, a configuration mode of [$location service](http://docs.angularjs.org/api/ng.$location) in angularjs, uses HTML5 History API which one of its usage is to enrich client side interaction in a web application. When the $location service configured with this mode, browser will not do a full page reload when its URL is changed, without the need of hashbang ``#!`` in part of URL. But what if, in one time, you need a full page reload to react on browser's URL change? Such as signing a user out, which usually is handled by server side of your app.

For the sake of completeness(?), here is how i usually do to setup the $locationProvider to use html5 mode. Yes, i use coffeescript, it's easier to write and read, also provide a little similiar syntax as Python, which also i love.

```coffeescript
# in a module which defines routes
module.exports = [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider, config) ->

    $routeProvider
      .when('/a-route',
        templateUrl: '/some/directory/partial.html'
        controller: 'SomeController'
      )
      # ...and many other routes

      # Catch all
      .otherwise({redirectTo: '/catch-all'})

    # Use html5 mode.
    $locationProvider.html5Mode(true)
]
```

With above config, whenever user hit an anchor with link in your angularjs bootstrapped app, the browser will not do a full page reload. Instead the app will catch the URL and send it to your route handler client side so you can interact your app further.

A problem arise when using such configuration, as one or more link in your app need to be handled by your server side application, and thus the browser need to do a full page reload for it to bypass the angularjs app. Confused yet? Yeah, me too :p . But bear with still-a-newb-in-writing-me and think of one example like the one mentioned above.

Yup, usually signing a user out of your application involves direct interaction with your server side application, maybe to remove the session, token, any other authentication related stuff. How can we do that while the client side application is configured with html5mode like above? Here are what i found from stumbling in SO and do a further reading in AngularJS docs:

Taken from [AngularJS docs](http://docs.angularjs.org/guide/$location#html-link-rewriting) :
>When you use HTML5 history API mode, you will need different links in different browsers, but all you have to do is specify regular URL links, such as: ``<a href="/some?foo=bar">link</a>``
>
>When a user clicks on this link,
>
>* In a legacy browser, the URL changes to /index.html#!/some?foo=bar
>* In a modern browser, the URL changes to /some?foo=bar
>
>In cases like the following, links are not rewritten; instead, the browser will perform a full page reload to the original link.
>
>*  Links that contain target element  
>    Example: ``<a href="/ext/link?a=b" target="_self">link</a>``  
>*  Absolute links that go to a different domain  
>    Example: ``<a href="http://angularjs.org/">link</a>``  
>*  Links starting with '/' that lead to a different base path when base is defined  
>    Example: ``<a href="/not-my-base/link">link</a>``  

In our case above, just put a ``target="_self"`` attribute to the anchor and the browser will do a full page reload so they hit the server side application directly.  

There we go, all good and set. Now back to the code :)
