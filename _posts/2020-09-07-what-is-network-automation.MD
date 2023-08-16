---
author: dmac
title: What is Network Automation?
date: 2020-09-07 10:00:00 +0100
categories: [networking]
tags: [automation]
img_path: /assets/img/posts/
image: 
  path: "2020-09-07/img-preview.jpg"
---

## What is Network Automation?

Let’s start with a simple definition: Network Automation is the process of automating manual, repetitive or complex tasks to improve the consistency of your network, reduce human errors, lower operational costs and ultimately helps you run your network more efficiently. Although you won’t get a one-size-fits-all definition in this article, I want to give you a clearer idea of what it is and what it is not.

Let’s keep working in our definition. Automation is the process of moving a task away from a human and outsource it to a system. For instance, if you need to configure a VLAN in 200 switches and you have a team of 5 people, you can ask each engineer to make the same change in 40 devices. Additionally, you will have to ask them to test these changes and confirm that the users can then reach servers in the same VLAN at least. In contrast, when you “automate” this task, your system will prepare, deploy and test the changes in those 200 devices for you. As a result, we will be helping five engineers to not waste their precious time in a repetitive and boring task that won’t make them any better.

There are many reasons why would you want to automate some tasks and we discuss this in the Why Network Automation post, but for now we will focus on “what” it is instead.

We’ve seen that with automation we can save some time for our colleagues and us but what is that about SDN, NFV, Ansible, Netbox, GIT, DevOps, APIs… Insert any other trendy word you may have read or heard online that is usually associated (directly or indirectly) to Network Automation

Some people tend to associate many of these tools, practices or technologies with Network Automation. Still, they are not the “What”; they are the “How” we deploy it instead.

## What is not Network Automation?

To continue with the definition, we will use another approach and define what is not Network Automation.

Ansible, for example, is one of the most used orchestration tools in the Network Automation area and is commonly used to deploy changes, to get information from our devices or even to generate reports. There are many use cases that you can benefit from by using Ansible or any other open-source tool. However, it is important to make the distinction that Ansible is not what Network Automation is all about. It is just one of the many tools you can use in your automation journey to solve your problems.

To continue, I’d love it if we can agree with the fact that Network Automation is NOT the solution for all our problems. I must admit I cringe every time I hear phrases like: “We need to automate all our network” or “let’s automate it ” without even thinking on the extent of the changes needed.

Is crucial to be intentional and evaluate the effort vs reward ratio when considering automation. To illustrate this point, think on one task that you do once every couple of months (and let’s call it “Task Y”). We estimate that “Task Y” takes us 4 minutes to complete so if we do some basic maths we can state that doing “Task Y” only takes us 24 minutes a year.

> <center>“Task Y” – Time spent per year</center>  
> <center>4 minutes * (12/2 = 6 times a year) = 24 minutes a year</center>
{: .prompt-info }

Let’s now try to think in terms of Return on Investment (RoI), we can estimate that automating “TaskY” would require us 8 hours of work (Automation effort). But how many times would we need to complete “Task Y” to make this automation initiative worth it?. Let’s jump back to our math101 class, and let’s do a quick calculation:

> <center>“Task Y” Data</center>  
> <center> Execution time = 4 minutes</center>
> <center> Frequency = Once every 2 months </center>
> <center> Automation Effort = 8 hours = 60 minutes x 8 hours = 480 minutes </center>
> <center> Times to make it worthwhile = 480 minutes / 4 Minutes = 120 times </center>
> <center> Years to make it worthwhile = 120 times / 6 times a year = 20 years </center>
{: .prompt-info }

The figures above suggest that we should automate “TaskY” only if we expect to be doing it for the next **twenty years** (Or more ideally).

Most of the times, these tasks will stop well before five years, so probably the effort required to automate “TaskY” doesn’t worth your effort.

Some times is not just about the time a task can take us but the money that it represents for an organisation. The case described before is just an example. Still, the main suggestion is to always think about the effort vs reward ratio before committing to automate a task.

The reality is, Network Automation will mean different things for different people, but I would summarise it as the process of automating tasks to improve the way we work, to be more efficient and solve problems that can save us time, money and energy.

In the next post, we will talk about “Why Network Automation is important?” and we’ll see a few use cases.

I would like to hear what is your definition of Network Automation, and how do you use it daily?
