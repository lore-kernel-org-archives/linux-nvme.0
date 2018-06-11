From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 11 Jun 2018 15:14:32 -0700
Subject: [PATCH V2 00/14] blktests: NVMeOF new testcases for file and
 bdev ns
In-Reply-To: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611221432.GB25795@vader>

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

The flush tests fail for me, and Johannes still has some comments on the
last two, so I applied patches 1-10. The flush tests fail like this:

nvme/014 (flush a NVMeOF block device-backed ns)             [failed]
runtime  0.788s  ...  0.803s
    --- tests/nvme/014.out      2018-06-11 15:01:41.449896278 -0700
    +++ results/nodev/nvme/014.out.bad  2018-06-11 15:07:31.425480955 -0700
    @@ -1,6 +1,6 @@
     Running nvme/014
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NVMe Flush: success
    +NVME IO command error:INVALID_NS(400b)
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete

Any idea what that is?

Thanks for the tests!

> Chaitanya Kulkarni (14):
>   blktests: common/nvme export ns-mgmt interfaces
>   blktests: add NVMeOF bdev-ns target creation test
>   blktests: add NVMeOF file-ns target creation test
>   blktests: add NVMeOF bdev-ns host creation
>   blktests: add NVMeOF file-ns host creation
>   blktests: add fio data verification routine
>   blktests: add NVMeoF data verification test for bdev-ns
>   blktests: add NVMeOF data verification test for file-ns
>   blktests: add NVMeOF mkfs test for bdev-ns
>   blktests: add NVMeOF mkfs test for file-ns
>   blktests: add NVMeOF flush test for bdev-ns
>   blktests: add NVMeOF flush test for file-ns
>   blktests: add NVMeOF many bdev-ns creation test
>   blktests: add NVMeOF many file-ns creation test
