---
author: dmac
title: Network Automation Hell - Where do I start?
date: 2020-09-14 10:00:00 +0100
categories: [networking]
tags: [automation]
---

## Network Automation Hell - Where do I start?

It’s impossible to deny that Network automation is now more than and trendy buzzword or an irrelevant topic that doesn’t even deserve a pinch of your attention. There are countless benefits that automation can provide to you and to your organisations but jumping from a pure Network engineering role into this new world can become extremely overwhelming.

While browsing YouTube you can find some videos talking about Ansible, Pipelines, Python, Frameworks, APIs, Git, Jenkins, Batfish, etc… And the list just goes on and on. This is what I like to call the Automation hell and we want to avoid the FOMO (fear of missing out) when we are just starting our journey.

![Network Automation Tools](../../assets/img/posts/2020-09-14/fig1-net-automation-tools.jpg){: w="900" h="600" }
_Figure 1 - Some Network Automation Tools_

Let’s start with the most common question and the one that you are thinking of right NOW (I know, you must be thinking… is this guy a mind reader or what??)… Where do I start?.

Unfortunately, there isn’t just one right answer that would fit everyone’s learning speed, initial experience, or even interest. For example, if your plan is to make network automation a career or a long-term goal, probably getting some programming skills would help you in the long run. On the other hand, if you’d only want to use high-level tools to get the job done with minimal effort, trying to look into the vendors’ automation solutions might make more sense to you.

In this blog, I am more focused on growing a career in the network automation area in order to increase the range of solutions I can provide for a problem. Having said this, I believe the best way to start is by learning a programming language.

## Picking a programming language

In the Network Automation world, Python and Go are two popular programming languages. Python, in particular, is one of the fastest-growing programming languages in the world given its “relatively” low entry-level compared to other languages.

The reason I would recommend a programming language as a starting point is that it will give you more flexibility in the future to tackle problems in multiple fronts, not only in the Network Automation area. For example, last week, I was using Python to create a Lambda function in AWS that would send alerts to our Slack channel when Internet traffic exceeds a certain threshold in our VPCs. I was able to complete this task because of the flexibility that a programming language gives you.

## Resources
Since we are avoiding getting into the Automation hell, I’m going only to show you the 4 best resources that I’ve come across when learning Python, and the great news is that they are totally FREE!

<h3 style="text-align: center;">Corey Schafer</h3>

This guy is the Rockstar of the Python world for newcomers. Make sure to check out both, its tutorial for beginners and its GIT tutorial. GIT is extremely useful for version control and you will find yourself using it anytime you can.

{% include embed/youtube.html id='ZDa-Z5JzLYM' %}

<h3 style="text-align: center;">Real Python</h3>

This site is fantastic! The explanations are great, filled with visualisations and code snippets. Although some content is paid, you can find a long and in-depth how-to about Python for Free. The Requests package in Python is commonly used to query APIs. You can see a great article about it by clicking in the logo at your right.

[![Real Python](../../assets/img/posts/2020-09-14/real-python-logo.jpg){: w="900" h="600" }](https://realpython.com/){:target="_blank"}

<h3 style="text-align: center;">Dmitry Figol’s Streams</h3>
Dmitry is one of the maintainers of the nornir python package, and he constantly streams about Network Automation topics. These are long streams, but the amount of things you can learn from those streams is incredible. I’m shocked that this guy only has 4.5K subs in his Youtube channel. If you go through his videos, you will see him learning and his thought process when learning about new topics.

{% include embed/youtube.html id='MLeiShwb7Qo' %}

## Learning goals

After you’ve finished the previous resources and doing all the exercises in Kirk’s course, you will have acquired pretty useful skills:

- Python basics.
- Read/Write files with Python.
- Connect to a device using Netmiko.
- Using Regular expressions to filter output (Although it is highly encouraged to use APIs when possible instead of screen-scraping).
- Jinja2, YAML and JSON, these 3 are key areas that you could be using daily when building configs.

## Next steps

A great way to continue is to start creating small projects or tasks with Python. Next, you can see a list of examples:

- Create an inventory of your network devices in YAML or JSON.
- Generate the base config for one type of network device, let’s say a Juniper router. Here you can create a template in Jinja2, define some variables in YAML and then translate it into Python’s native structures like dictionaries, list, etc. to finally generate a config file. If you get stuck, check [this snippet](https://gist.github.com/danielmacuare/5c36390e9202538278da418f8506084e).
- Apply the config to a new device (Full replace and partial modifications) with the config you created in the previous point. There are many ways of doing this:
  - Use Netmiko to log into the device and apply the commands to change the config.
  - Use more sophisticated packages like nornir. If you get stuck, use the nornir tutorial or [this Gist](https://gist.github.com/danielmacuare/c647880cfc99a605d25c3b669ab63fc7) I’ve created with the very basics of nornir.
  - Use the vendor’s API (If your vendor provides one). Juniper, for example, provides a great API based in Netconf to query or modify your device’s config.
- Get data from the devices and create a report. I.e. what routes do you see in the routing table, how many interfaces are up and down in your network, what is the software version of your devices, etc.

## Final pieces of advice

- Learn how to use libraries like Paramiko, Netmiko to logging to the network devices but move on from screen scraping and use APIs whenever is possible as they would return structured data that you would easily consume and process as per your use case.
- Identify the quick wins in your organisation and offer to solve problems with your skills. Most of the time, reporting tasks are low risk as they only require to gather data from the devices, process the data and generate a custom output.
- Don’t apply changes to live network devices when starting, get used to get data from the devices, generate reports, etc. Try and test all your changes in GNS3, EVE-NG or any other lab to gain confidence and understand how all the pieces fit together.
- Start small and keep improving, do small and incremental changes in favour of massive changes.
- Start learning about testing and CI/CD before starting to deploy automated changes in your network. Automation is a great way to improve how we work, but it needs to be used with caution as a small config error can be applied to hundreds or thousands of devices very quickly.

## Closing thoughts

When I began my journey, I remember feeling overwhelmed at times. One of the first videos I watched was from Matt Oswald, and I remember thinking “what the hell is all that? YAML, JSON, Python, Ansible, etc”.

This post is a self-reflection on what would I have done differently if I had to start again in Network Automation.

I hope this post helps you decide where you should start. Wherever that is, keep curious and enjoy the journey. It takes time, lot of practice and continuous improvement. Keep working your craft day by day, week by week. 

I would like to hear what is the best resource (Video/Blog/Person) you have used to learn about Network Automation.
