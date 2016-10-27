From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Wed, 26 Oct 2016 23:48:36 -0700
Subject: Introducing Unit test framework based on nvme-cli
Message-ID: <1477550917-6472-1-git-send-email-chaitanya.kulkarni@hgst.com>

Hi,

Introducing nvme-cli based unit test framework. All the test cases use commands implemented in nvme-cli.

The goal is to have simple, lightweight, and easily usable framework which we can used to
develop various categories of unit tests based on nvme-cli and improve overall development.

Over the period of time since release of the nvme-cli various test cases are developed which are now integral part of our device deriver testing.

These test cases are evolved with nvme-cli and can be used for nvme-cli testing. 

I would like to take this opportunity and share first set of test cases which has most frequently used generic NVMe features from cli :-

1. nvme_attach_detach_ns_test.py
2. nvme_compare_test.py
3. nvme_create_max_ns_test.py
4. nvme_error_log_test.py
5. nvme_flush_test.py
6. nvme_format_test.py
7. nvme_get_features_test.py
8. nvme_read_write_test.py
9. nvme_smart_log_test.py
10. nvme_writeuncor_test.py
11. nvme_writezeros_test.py

Please have a look at README for an overview and process of adding new test case. 
Framework also has a sample template which can be used readily to write new test case.

Assumptions for current implementation :-
1. nvme-cli is already installed on the system.
2. Only one test case can be executed at any given time.
3. Each test case has logical PRE, RUN and POST sections.
4. It assumes that driver is loaded and default namespace "/dev/nvme0n1" is present. 
(It is easy to add driver load/unload in pre and post sections of test cases as per requirement.)

I?d like to know what features, test cases most people would want as a part of this framework.
Any suggestions are welcome, I'd like to implement them.

On approval I would like to submit more test cases to enhance the framework.

Patch Ref :- [PATCH] Unittest framework based on nvme-cli.

Regards,
Chaitanya
