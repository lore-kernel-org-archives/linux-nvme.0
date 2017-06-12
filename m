From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Sun, 11 Jun 2017 20:26:09 -0700
Subject: selftests: nvmftests: Introducing unittest framework for NVMe Over
 Fabricis 
Message-ID: <20170612032610.4176-1-chaitanya.kulkarni@hgst.com>


Hi,

Introducing NVMe Over Fabrics unit test framework.

The goal is to have simple, lightweight, and easily expandable framework which can be used to
develop various categories of unit tests for NVMe Over Fabrics and improve overall development.

Please have a look at README for an overview and process of adding a new test case.
The framework also has a sample skeleton which can be used readily to write a new testcase.

I?d like to know what features, test cases are desirable for the framework.
Any suggestions are welcome, I'd like to implement them.

On approval, I would like to submit more test cases to enhance the framework.

Please note that this patch is based on:-

url = https://github.com/torvalds/linux

Commit version :- 

commit 3c2993b8c6143d8a5793746a54eba8f86f95240f
Author: Linus Torvalds <torvalds at linux-foundation.org>
Date:   Sun Jun 4 16:47:43 2017 -0700

    Linux 4.12-rc4

Regards,
Chaitanya
