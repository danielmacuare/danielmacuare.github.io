---
author: dmac
title: "From Wordpress to Jekyll: The joy of blogging again."
date: 2023-08-14 00:00:00 +100
categories: [networking]
tags: [automation]
img_path: /assets/img/posts/
image: 
  path: "2023-08-14/img-preview.jpg"
---

## Starting point

Back in late 2017 I started toying with the idea of creating my own blog as a way to connect with Network Engineers keen on talking about automation. I myself was learning the ropes of Networking and Automation but back then I didn't know many people interested in this area.

As I had been learning Ansible I decided to use it to create my local Wordpress instance while improving my skills with this tool.

At first, I started creating the Wordpress blog manually by installing all the packages and configuring them myself. This helped me understanding how all the components worked together and the thousands necessary tweaks required to get my Wordpress instance up and running.

After having a working prototype and understanding how to create my LAMP (Linux-Apache-MySQL-PHP) stack I then decided to try and automate this process using Ansible. Since I learn the most by doing I thought I would use this opportunity to improve my skills and gain more experience with this tool.

The whole experience took me around 6 months of learnings and experimentation. By the 6 months mark, I had automated the creation of my own local wordpress instance by running a `vagrant up`. I had also gained so more experience on:

- Vagrant
- Shell Scripting
- Ansible
- Deploying a LAMP Stack and configuring Wordpress

> - You can find the original repo here: [Ansible-Vagrant-Centos7-Wordpress](https://github.com/danielmacuare/Centos7_WP)  
> - This is the Diagram of the process used to deploy the Worpdress instance using Vagrant: [Diagram](https://github.com/danielmacuare/Centos7_WP/blob/master/shared/ansible/Wordpress_ansible.pdf)
{: .prompt-tip }

After all this work, I realised something I had suspected all along. I wasn't exactly thrilled about the idea of maintaining all Wordpress moving parts. My main aim was to dive into blogging, not to have to maintain all the software elements of the LAMP stack after its deployment. Eventually, I just gave up on the whole thing and focused on getting better at Networking and Automation.

A few years later, around 2020, I discovered a service offered by AWS called [AWS Lightsail](https://aws.amazon.com/lightsail/projects/wordpress/). The interesting point about it was that I now was able to deploy my Wordpress instance in minutes without the hassle of maintaining it. I only had to worry about blogging (Or at least, that's what I thought).

After deploying my blog using AWS Lightsail (I totally loved this service by the way), I was really excited but the more posts I started to write in Wordpress, the more I fell this wasn't going to do it for me.

## My issues with Wordpress/Elementor

The main challenges I faced were the creation of posts and how complex it was to troubleshoot a problem in Wordpress.

To create and edit my posts I was using [Elementor](https://elementor.com/), a helpful Wordpress builder. While it was useful to build and customise your site based on some of their themes, it was a frustrating experience to write even a simple blog post. Next are only some of the issues I faced:

- [No Markdown Support in Elementor](https://github.com/elementor/elementor/issues/6282): To create my blog posts I had to use HTML because Markdown was not natively supported. Although, it was a good learning experience, it took quite a long time to create a simple post.

- [No native syntax highlighting as of 2020.](https://github.com/elementor/elementor/issues/5815#issuecomment-687565427)

- Complex to troubleshoot: There were so many layers of abstraction, every pluging introduced a new way to mess up your configuration. Often times I had to disable all plugins one by one to try to understand why a post would not show up. Elementor was also another layer of abstraction and it was pretty tough to find whether a post was failing because of Elementor, the theme, some plugins, or an error in Wordpress.

I've got to say I'm not an expert with Wordpress and its components and there probably are some workarounds for all my issues but I didn't really want to spend so much time trying to make it work to my liking. All I really wanted was an easy way to create, test, and get my blog out there with some basic requirements.

## My ideal platform

After abandoning my blog for a few years, I got interested again in early 2023 so I started thinking what were my requirements if I were to move to a different platform and start blogging again. Below you can see my wishlist as I called it:

- Native Markdown support. I couldn't bear the thought of writing another post in pure HTML.
- Native Syntax Highlighting
- Dark Mode. What can I say here? I love to use dark mode in all my apps.
- Tagging and category systems to easily arrange and filter my posts.
- Commenting system
- Youtube integration
- Nice UI
- Powerful search options for my posts
- Seamless process to test and deploy new posts
- Customizable CSS

## Why Jekyll?

While watching one of my favourites Youtubers [(Kudos to Techno Tim)](https://www.youtube.com/@TechnoTim), I heard about [Jekyll](https://jekyllrb.com/), a Static Site Generator. Although I had tried [Gatsby](https://www.gatsbyjs.com/) and [Hugo](https://gohugo.io/) in the past, I never got to find the right theme for me to start and I would always get stuck trying to make some features work.

## What is a Static Site Generator (SSG)?

In a very simplistic way, a SSG is a tool that lets you define text files (Can be based on Markdown) and use templates to render a website in HTML. In some cases, Static Site Generators are a great alternative to full blown Content Management Systems (CMS) like Wordpress as they don't require connection to a database and they don't require the server to render the HTML page based on information coming from a database.

The main benefits of SSG over a CMS are:

- Speed and performance
- Reduced maintenance
- Simplicity
- Portability
- Cost-efficiency

### Chirpy Theme FTW

Thanks [cotes2020](https://github.com/cotes2020) for creating and maintaining this great theme.

After watching the video below from [Techno Tim](https://www.youtube.com/@TechnoTim) and testing the [Chirpy Theme](https://chirpy.cotes.page/) I went to give it a try to check if it would meet my requirements.

{% include embed/youtube.html id='F8iOU1ci19Q' %}

While testing the theme, I discovered that not only it was easy to use and customise but also it was possible (by using Jekyll) to deploy my blog on GitHub Pages. **This saved me 90 USD as I don't need to host my blog in AWS anymore!.** If you want to try this, be aware of the [Github Pages Limitations](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages)

#### Chirpy Theme Features

- [Solid Documentation](https://chirpy.cotes.page/)
- [Active and maintained Theme](https://github.com/cotes2020/jekyll-theme-chirpy)
- [Native Markdown support](https://chirpy.cotes.page/posts/text-and-typography/). I couldn't bear the thought of writing another post in plain HTML.
- [Native Syntax Highlighting](https://www.youtube.com/@TechnoTim)
- [Dark Mode](https://chirpy.cotes.page/posts/write-a-new-post/#darklight-mode). What can I say here? I love to use dark mode in all my apps.
- [Tagging and category systems](https://chirpy.cotes.page/posts/write-a-new-post/#darklight-mode) to easily arrange and filter my posts.
- [Commenting system](https://chirpy.cotes.page/posts/write-a-new-post/#comments)
- [Youtube integration](https://chirpy.cotes.page/posts/write-a-new-post/#videos)
- [Nice UI](https://chirpy.cotes.page/)
- [Powerful search options for my posts](https://chirpy.cotes.page/posts/getting-started/)
- [Github Actions](https://github.com/danielmacuare/danielmacuare.github.io/actions)
- [Customizable CSS](https://chirpy.cotes.page/posts/getting-started/#customizing-stylesheet)

## Results

- I can now write my blog posts using Markdown. [See the source code of this post](https://github.com/danielmacuare/danielmacuare.github.io/blob/prod/_posts/2023-08-14-from-wordpress-to-jekyll.MD)
- I have reduced my deployment time from hours in Wordpress to less than a minute with Jekyll. With one commit, GitHub Actions runs automatically to deploy my site to github pages. Example of the [CD Pipeline](https://github.com/danielmacuare/danielmacuare.github.io/actions/workflows/pages-deploy.yml)
- I can create my post locally in my computer side by side and test it live.
- I have saved 90 USD annually by hosting my blog in Github Pages instead of AWS.
- I can customise my blog's CSS in one file to look as I want. [Example](https://github.com/danielmacuare/danielmacuare.github.io/blob/prod/assets/css/style.scss)

## What can be improved?

- CDN for caching if the size of the repo grows near 1 GB. See [Github Pages Limitations](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages#usage-limits)
- I would love to have thumbnails for my posts. Unfortunately this is [not supported by my theme](https://github.com/cotes2020/jekyll-theme-chirpy/issues/421) so I would need to create it myself. This might be a good opportunity to improve my limited front-end skills.

## Closing thoughts

I couldn't be happier with this switch. I'm looking forward to blogging again and if you are in a similar position to the one I was at, give SSGs a try. Hugo, Gatsby, Jekyll, any of them will do and you will be very content with the results.
