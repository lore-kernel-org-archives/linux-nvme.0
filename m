From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 6 Feb 2019 05:21:40 +0000
Subject: [LSF/MM TOPIC] : blktests: status, an expansion plan for the storage
 stack test framework
Message-ID: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>

Hi,

Since discussion of the storage stack and device driver at the LSFMM 2017
(https://lwn.net/Articles/717699/),  Omar Sandoval introduced a new framework
"blktests" dedicated for Linux Kernel Block layer testing.
(https://lwn.net/Articles/722785/, https://github.com/osandov/blktests).
 
As Linux Kernel Block layer is central to the various file systems and underlying
low-level device drivers it is important to have a centralized testing framework and
make sure it grows with the latest block layer changed which are being added based
on the different device features from different device types
(e.g. NVMe devices with Zoned Namespace support).

Since then blktests has grown and became go-to framework where we have integrated
different stand-alone test suites like SRP-tests, NVMFTESTS, NVMe Multipath tests,
zone block device tests, into one central framework, which has made an overall block layer
testing and development much easier than having to configure and execute different
test cases for each kernel release for different subsystems such as FS, NVMe,
Zone Block devices, etc). 

Here is the list of the existing test categories:-

??? block? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?28 Tests
??? loop? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?07 Tests
??? meta? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 12 Tests
??? nbd? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 02 Tests
??? nvme? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?28 Tests
??? nvmeof-mp? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 12 Tests
??? scsi? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 06 Tests
??? srp? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?13 Tests
??? zbd? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 05 Tests
---------------------------------------------------------------- 
           9 Categories? ? ? ? ? ? ?               ~110 Tests

This project has gathered much attention and storage stack community is actively
participating and adding new test cases with different categories to the framework. 

For storage track, we would like to propose a session dedicated to blktests. It is a great
opportunity for the storage developers to gather and have a discussion about:-

1. Current status of the blktests framework.
2. Any new/missing features that we want to add in the blktests.
3. Any new kernel features that could be used to make testing easier?
E.g. Implementing new features in the null_blk.c in order to have device
independent complete test coverage. (e.g. adding discard command for null_blk or any
other specific REQ_OP). Discussion about having any new tracepoint events in the block layer.
4. Any new test cases/categories which are lacking in the blktests framework.
 
Regards,
Chaitanya
