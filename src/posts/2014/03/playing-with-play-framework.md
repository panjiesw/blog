Title: Playing With Play Framework
Date: 2014-03-17
Category: Codes
Tags: java, scala, play-framework
Slug: playing-with-play-framework
Disqus: playing-with-play-framework
Author: Panjie Setiawan Wicaksono
Status: draft
Summary: In the last few months i have been working on a project using Play Framework. It's a [High Velocity Web Framework For Java and Scala](http://www.playframework.com/), built on [Akka](http://akka.io/), a toolkit and runtime for building high concurrent, distributed and fault tolerant event-driven applications on the JVM. Here in this post i'll share how enjoyable it is, playing with Play Framework and Scala.

## Preface

First of all, i was originally not fond of the idea building a web application using Java or any JVM based language. I always preferred php, python, or Node.js for that, until i found out about Play Framework and using it in a project.

In the last few months i have been working on a project using Play Framework. It's a [High Velocity Web Framework For Java and Scala](http://www.playframework.com/), built on [Akka](http://akka.io/), a toolkit and runtime for building high concurrent, distributed and fault tolerant event-driven applications on the JVM. Here in this post i'll share how enjoyable it is playing with Play Framework and Scala. And it appears it's not as scary as i thought, developing a Web Application using JVM based language.

Play Framework comes with support for Java and Scala. Although in its core Play uses Scala, but they also provides all the hook and API to use in Java application. So you can choose to work with either language, or mix both of them together in one app if you like. I for one, use Scala as my main language to work with to get the flexibility of functional programming and also the power of JVM.

## The Fun Begins ##

#### 1. Play Framework Distribution Download ####
If we visit the [Play Download Page][1], there are two flavor of distribution to choose, New Distribution using Typesafe Activator or Classic Distribution.

The difference is, Typesafe Activator comes with a Web UI for Play Console and [a lot of templates][2] to try or become the base of our projects. So it's the best choice to learn if you're just starting with Play Framework. Another difference is the command to use, it's ``activator`` if you're using Typesafe Activator, and ``play`` if you're using Classic Distribution.

[image Activator]

For me, i chose the Classic one, so i get the ``play`` command. I believe all ``play`` command is also available in ``activator`` so if you chose the New Distribution, all commands below will also work in Typesafe Activator console.

**NOTICE**: Some of Linux distributions come with a program with Command Line Interface ``play`` same as Classic Distribution Play Console command. If somehow you want to keep it, you'll need to add an alias to Play Console Command to work effectively.

    alias play=$PLAY_HOME/play
    
After download finished and the play command has made available in your environment, type ``play`` to check it's working properly. It should print out something like in picture below.

[screen shot play command]


  [1]: http://www.playframework.com/download
  [2]: http://typesafe.com/activator/templates
