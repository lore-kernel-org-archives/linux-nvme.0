From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 6 Feb 2019 11:32:13 +0100
Subject: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
In-Reply-To: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <2ed684c6-38de-1717-5787-31b00c72ba4f@suse.de>

On 06/02/2019 06:21, Chaitanya Kulkarni wrote:
> Hi,
> 
> Since discussion of the storage stack and device driver at the LSFMM 2017
> (https://lwn.net/Articles/717699/),  Omar Sandoval introduced a new framework
> "blktests" dedicated for Linux Kernel Block layer testing.
> (https://lwn.net/Articles/722785/, https://github.com/osandov/blktests).
>  
> As Linux Kernel Block layer is central to the various file systems and underlying
> low-level device drivers it is important to have a centralized testing framework and
> make sure it grows with the latest block layer changed which are being added based
> on the different device features from different device types
> (e.g. NVMe devices with Zoned Namespace support).
> 
> Since then blktests has grown and became go-to framework where we have integrated
> different stand-alone test suites like SRP-tests, NVMFTESTS, NVMe Multipath tests,
> zone block device tests, into one central framework, which has made an overall block layer
> testing and development much easier than having to configure and execute different
> test cases for each kernel release for different subsystems such as FS, NVMe,
> Zone Block devices, etc). 
> 
> Here is the list of the existing test categories:-
> 
> ??? block? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?28 Tests
> ??? loop? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?07 Tests
> ??? meta? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 12 Tests
> ??? nbd? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 02 Tests
> ??? nvme? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?28 Tests
> ??? nvmeof-mp? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 12 Tests
> ??? scsi? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 06 Tests
> ??? srp? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?13 Tests
> ??? zbd? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 05 Tests
> ---------------------------------------------------------------- 
>            9 Categories? ? ? ? ? ? ?               ~110 Tests
> 
> This project has gathered much attention and storage stack community is actively
> participating and adding new test cases with different categories to the framework. 
> 
> For storage track, we would like to propose a session dedicated to blktests. It is a great
> opportunity for the storage developers to gather and have a discussion about:-
> 
> 1. Current status of the blktests framework.
> 2. Any new/missing features that we want to add in the blktests.
> 3. Any new kernel features that could be used to make testing easier?
> E.g. Implementing new features in the null_blk.c in order to have device
> independent complete test coverage. (e.g. adding discard command for null_blk or any
> other specific REQ_OP). Discussion about having any new tracepoint events in the block layer.
> 4. Any new test cases/categories which are lacking in the blktests framework.

One thing I'd love to see is more hardware/driver specific tests. I'm
sure Broadcom, Marvell, Huawei and all the others out there do have test
suites for their HBA drivers but not a single one of these tests is
publicly available.

We're also lacking tests for things like ioprio, persistent reservation,
bcache and so on.

Adding support for collecting gcov information after running a test case
would also be awesome (this is missing in xfstests as well).

So I think a session on blktests can help us get the gap closed.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
