---
author: dmac
title: JNCIA Automation and DevOps Exam – What you need to know
date: 2020-10-05 10:00:00 +0100
categories: [networking]
tags: [certs]
---

# JNCIA Automation and DevOps Exam – What you need to know

I recently took the Automation and DevOps, Associate [JNCIA-DevOps JN0-221](https://www.juniper.net/gb/en/training/certification/tracks/devops/jncia-devops.html?tab=jnciadevops") exam, and below, you will find some tips based on this experience. To be more specific, I will show you:

- A study plan and resources.
- How to save money when booking your exam?.
- What to expect on the exam day?.
- The overall exam experience.

## Study Plan

For any new topic I learn, I usually start watching videos, then I move on to the hands-on stage. For me, the best way of learning is by doing. To conclude, I do some extra reading about the topics as usually books go more in-depth on the concepts, and they are easier to go through once you have a base of knowledge.

Below you can find a study plan that will help you prepare for the exam:

1. Find out what are the [topics included in the exam](https://www.juniper.net/gb/en/training/certification/tracks/devops/jncia-devops.html?tab=jnciadevops).
2. Create an account in [Junos Genius/Learning Portal](https://learningportal.juniper.net/) to access free training provided by Juniper for this certification.
3. Complete all the labs you can find in [NRE labs](https://nrelabs.io/).
4. Lab all the topics by yourself. For this, check the “Further Practice” section in this post.

## Juniper Learning Portal (Previously known as Genius)

[Junos Genius/Learning Portal](https://learningportal.juniper.net/) is a portal on which Juniper provides free training for its certifications. I was impressed with the quality of the content and the clear explanation of each topic. These are a few points I liked about the platform:

- It lets you access the content on your desktop, tablet, or your mobile.
- The lessons are usually short and focused on specific topics included in your exam.
- Your progress is synced across your devices. For example, if you close the platform on your desktop and then go to bed, you can continue on your tablet from where you left off.
- You have access to “Day one” books. They can help you get started and are more in-depth than the videos, so you can use them as a complement.

## Day One Books

If you like reading to get further information, I recommend you the following 2 books. They were handy as a reference:

- [Automating Junos with Ansible, 2nd Edition](https://www.juniper.net/documentation/en_US/day-one-books/DO_AJA2ndEd.pdf) – I saw some references to Python2 in this book but make sure you always use at least Python 3.6 instead when starting a new python project.
- [Junos PyEZ Cookbook](https://www.juniper.net/documentation/en_US/day-one-books/DO_PyEZ_Cookbook.pdf) – For this book, you can focus on Part 1 (Set up Guide) and Part 2 (Basic Scripts).

## NRE Labs

> When editing this post in April 2023 I realised that NRE Lab was shutdown [See This Post](https://nrelabs.io/2021/12/goodbye-for-now/)
{: .prompt-warning }

I can absolutely say it is such a shame as it content was pretty useful to prepare for this exam.

I can only be grateful for all the effort folks like `Matt Oswald` put to help the community.

## Further Preparation

### Python

It's essential to get a basic understanding of Python, data types, lists, dictionaries, strings, etc.
I actively used the following resources to refresh my Python skills.

- [Real Python](https://realpython.com/)
- [Corey Schafer's Youtube Channel](https://www.youtube.com/watch?v=YYXdXT2l-Gg&list=PL-osiE80TeTskrapNbzXhwoFUiLCjGgY7) - A bit old but pretty useful and to the point.
- [Kirk Byers – Python for Network Engineers (Free Course)](https://pynet.twb-tech.com/free-python-course.html). He offers an 8-weeks course introduction to Python which is fantastic.

### XML

XML, XML and more XML!, you can't get enough of it. Practice how to filter XML data with XPath using the PyEZ library and the Juniper.junos role in Ansible.

In the following video, Jeremy Schulman talks about XML and XPath:

{% include embed/youtube.html id='QVVzfyvgX9c' %}

### Ansible

Ansible is a useful tool that will be thoroughly tested in your exam, so you will need to understand:

- How Ansible works, its structure, and ansible basics.
- What is idempotency?.
- The differences between the Ansible core modules and the [Juniper.junos galaxy modules](https://galaxy.ansible.com/Juniper/junos).
- Juniper.junos – How do you get the configuration from the network devices.
- Juniper.junos – How do you commit the configuration?.
- Juniper.junos – How do you execute RPCs from Ansible with the Juniper.junos role?.

### PyEZ

Check the [PyEZ documentation](https://junos-pyez.readthedocs.io/en/latest/) and complete the following tasks as practice for the exam:

- Enable Netconf in the network device.
- Install PyEZ.
- Connect to a device and lock/unlock the config. (With and without context managers).
- Execute RPCs to get the configuration from the devices and then filter data (Using XPath expressions).
- Commit config changes.
- Upgrade a device.

### Junos REST API

Regarding the Rest API that JunOS offers, make sure you get familiar with it, read its documentation, and understand how to perform the following tasks:

- How to set up the Rest API in the network devices?.
- How to run RPCs from the API.
- How to run RPCs from the REST-API explorer.
- What HTTP methods can you use in this API?.

## Get a 75% discount voucher for your exam

Junos Genius will provide you a voucher with a 75% discount for the JNCIA-DevOps exam if you:

- Finish the Open Learning Modules (11 Modules).
- Finish the Certification Prep Videos (6 Modules).
- Finish the practice test.
- Finish the voucher assessment test.

You will see all the requirements above when you enroll in the JNCIA DevOps course in the JunOS Genius app.

After completing the previous requirements, you should receive a voucher in the email registered in your JunOS Genius account. If you don’t receive it, I’d advise you to email to Juniper at `certification@juniper.net`. They will send you your voucher in the next 2 working days.

In my case, I ended up paying only 60 USD to book my exam. 240 – 150 (Voucher Discount) = 60 USD

## Exam Day

Before the exam day, Pearson VUE will send you a link to download the OnVUE app and test your laptop with it. The system is quite intrusive because it will record your screen, your microphone, and I even got a permission’s request on my laptop asking me to capture my keyboard strokes.

On the exam’s day, you will need to log in 15 minutes before the test, open the onVUE app. The app will ask you to take and upload pictures of your surroundings. You will be the only person allowed in the room where you will take the test.

After uploading your room’s pictures and your ID, a Proctor will contact you via a chat popup inside the onVUE app and then initiate a call with you. In my case, she requested me to show with the camera that my monitors were unplugged.

After showing the proctor my surroundings with the camera, she activated my exam, and I started answering the 65 questions.

On the top right-hand side of your screen, you have an icon that allows you to mark the questions. Before submitting all the exam’s questions, you can then review the items you marked.

After submitting the answers, you click finish, and you will immediately get your exam results.

## Exam's overall experience

The exam requires you to complete 65 multiple-choice questions in up to 90 minutes, which is plenty of time to answer and review them. The passing score is 60%.

In Juniper exams, you can review your questions before submitting them. Additionally, you can go back to previous questions at any time during the exam.

Make sure that you will be alone in your room on the exam day to avoid any suspicions of wrong-doing.

During this Covid-19 madness, I appreciate the fact that you can take the test at home. Although you need to share pictures and videos of your room with the proctor (I understand not everyone would like to do this), I did find the whole experience smooth and convenient.

Good luck with your exam!!. I hope this helps you get an idea of what to expect and how to study for it.
