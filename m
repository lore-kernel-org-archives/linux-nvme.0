From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 23:14:34 +0000
Subject: [PATCH V2 00/14] blktests: NVMeOF new testcases for file and bdev
 ns
In-Reply-To: <20180611221432.GB25795@vader>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>,
 <20180611221432.GB25795@vader>
Message-ID: <BN6PR04MB12035FB91099B3CB3976660886780@BN6PR04MB1203.namprd04.prod.outlook.com>

Hi Omar,

From: Omar Sandoval <osandov@osandov.com>
Sent: Monday, June 11, 2018 3:14 PM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; jthumshirn at suse.de
Subject: Re: [PATCH V2 00/14] blktests: NVMeOF new testcases for file and bdev ns
? 
 
On Mon, Jun 11, 2018@05:15:40AM -0400, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch series restructures the target side namespace creation code and 
> adds new testcases for NVMeOF loop target (nvme_loop). Also, we add one 
> fio helper for basic data verification, new testcases like basic
> creation/deletion of the host/target, fio based data verification testcases
> for both block device and file backed target namespace and file system
> formatting and data verification from the host side.
> 
> -Regards,
> Chaitanya
> 
> Changes Since V1:-
> 
> 1. Add fio data verification helper.
> 2. Add a new test for many namespaces creation for file-backed ns.
> 3. Minor fixes and cleanups.

Hey, Chaitanya,

I had to change TMPDIR to use the blktests repository instead of /tmp to
get the file-backed ones to pass. I also changed the descriptions to
read as "this test will..." for consistency with the other tests, and
added TIMED=1 to the data verification tests.

[CK] Sounds good and thanks.

The flush tests fail for me, and Johannes still has some comments on the
last two, so I applied patches 1-10. The flush tests fail like this:

nvme/014 (flush a NVMeOF block device-backed ns)???????????? [failed]
runtime? 0.788s? ...? 0.803s
??? --- tests/nvme/014.out????? 2018-06-11 15:01:41.449896278 -0700
??? +++ results/nodev/nvme/014.out.bad? 2018-06-11 15:07:31.425480955 -0700
??? @@ -1,6 +1,6 @@
???? Running nvme/014
???? 91fdba0d-f87b-4c25-b80f-db7be1418b9e
???? uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
??? -NVMe Flush: success
??? +NVME IO command error:INVALID_NS(400b)
???? NQN:blktests-subsystem-1 disconnected 1 controller(s)
???? Test complete

Any idea what that is?

[CK] I ran the all the tests didn't see that error:-

# for i in 006 007 008 009 010 011 012 013 014 015 016 017; do ./check tests/nvme/$i; done 
nvme/006 (unit tests for creating target with a block device ns) [passed]
    runtime  0.363s  ...  0.289s
nvme/007 (unit tests for creating target with a file backed ns) [passed]
    runtime  0.298s  ...  0.226s
nvme/008 (unit test for creating a host with one block device backed ns) [passed]
    runtime  0.667s  ...  0.552s
nvme/009 (unit test for creating a host with one file backed ns) [passed]
    runtime  0.605s  ...  0.510s
nvme/010 (data verification test for block device backed ns) [passed]
    runtime  42.825s  ...  41.327s
nvme/011 (data verification test for file backed ns)         [passed]
    runtime  274.323s  ...  201.583s
nvme/012 (test mkfs with data verification for block device backed ns) [passed]
    runtime  277.448s  ...  279.184s
nvme/013 (test mkfs with data verification for file backed ns) [passed]
    runtime  226.276s  ...  239.203s
nvme/014 (unit test for NVMe flush for block device backed ns) [passed]
    runtime  0.736s  ...  0.566s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  0.501s  ...  0.507s
nvme/016 (create/delete many bdev-ns and test discovery)     [passed]
    runtime  28.271s  ...  27.361s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  0.285s  ...  0.302s

I suspect it may be backend file creation issue when configuring the target side namespace, but not entirely sure.


Thanks for the tests!

> Chaitanya Kulkarni (14):
>?? blktests: common/nvme export ns-mgmt interfaces
>?? blktests: add NVMeOF bdev-ns target creation test
>?? blktests: add NVMeOF file-ns target creation test
>?? blktests: add NVMeOF bdev-ns host creation
>?? blktests: add NVMeOF file-ns host creation
>?? blktests: add fio data verification routine
>?? blktests: add NVMeoF data verification test for bdev-ns
>?? blktests: add NVMeOF data verification test for file-ns
>?? blktests: add NVMeOF mkfs test for bdev-ns
>?? blktests: add NVMeOF mkfs test for file-ns
>?? blktests: add NVMeOF flush test for bdev-ns
>?? blktests: add NVMeOF flush test for file-ns
>?? blktests: add NVMeOF many bdev-ns creation test
>?? blktests: add NVMeOF many file-ns creation test
    
