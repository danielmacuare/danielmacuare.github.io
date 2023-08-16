---
author: dmac
title: How to enable code-completion in VScode for Boto3?
date: 2020-09-06 10:00:00 +0100
categories: [cloud, productivity]
tags: [python, aws]
img_path: /assets/img/posts/
image: 
  path: "2020-09-06/img-preview.jpg"
---


While working with AWS [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/create_transit_gateway_vpc_attachment.html#) I found myself constantly jumping to the AWS documentation to look for the methods I needed. I wondered if there was any code-completion for it instead?

![VsCode Boto3](2020-09-06/boto3-vscode-syntax-highlighting.jpg)_Figure 1 - Boto3 Code-Completion in VSCode_

Yes, there was a package called botostubs to do just this and enable code-completion for boto3.

I hope you find it useful.

**Edit (11/04/23):** There is an alternative package to do this called `boto3-stubs`. Check how you can install it and use it with VsCode, PyCharm, Sublime, etc. [boto3-stubs-docs](https://youtype.github.io/boto3_stubs_docs/)
