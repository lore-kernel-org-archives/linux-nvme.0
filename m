From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Sep 2018 23:53:51 +0000
Subject: [PATCH V2 blktests 03/12] nvme: add NVMeOF write-zeroes test for
 bdev-ns
In-Reply-To: <20180912223705.GB6052@vader>
References: <20180904193304.13350-1-chaitanya.kulkarni@wdc.com>
 <20180904193304.13350-4-chaitanya.kulkarni@wdc.com>,
 <20180912223705.GB6052@vader>
Message-ID: <SN6PR04MB4510EE2BECEFD9643D3ADD18861B0@SN6PR04MB4510.namprd04.prod.outlook.com>

Let me test again, I'll send out the next version with the fix.





From: Omar Sandoval <osandov@osandov.com>
Sent: Wednesday, September 12, 2018 3:37 PM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; osandov at fb.com
Subject: Re: [PATCH V2 blktests 03/12] nvme: add NVMeOF write-zeroes test for bdev-ns
? 
 
On Tue, Sep 04, 2018@12:32:55PM -0700, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>? tests/nvme/021???? | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>? tests/nvme/021.out |? 6 ++++
>? 2 files changed, 84 insertions(+)
>? create mode 100755 tests/nvme/021
>? create mode 100644 tests/nvme/021.out


This test is still failing for me sometimes. If I apply the following
patch:

diff --git a/tests/nvme/021 b/tests/nvme/021
index efcbb3f..137e89e 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -59,6 +59,10 @@ test() {
???????? cat "/sys/block/${nvmedev}n1/uuid"
???????? cat "/sys/block/${nvmedev}n1/wwid"
?
+?????? nvme write-zeroes "/dev/${nvmedev}" -n 1 -d -s "${sblk}" -c "${nblk}"
+?????? nvme write-zeroes "/dev/${nvmedev}" -n 1 -d -s "${sblk}" -c "${nblk}"
+?????? nvme write-zeroes "/dev/${nvmedev}" -n 1 -d -s "${sblk}" -c "${nblk}"
+?????? nvme write-zeroes "/dev/${nvmedev}" -n 1 -d -s "${sblk}" -c "${nblk}"
???????? nvme write-zeroes "/dev/${nvmedev}" -n 1 -d -s "${sblk}" -c "${nblk}"
?
???????? nvme disconnect -n "${subsys_name}"
diff --git a/tests/nvme/021.out b/tests/nvme/021.out
index 29939e6..658be05 100644
--- a/tests/nvme/021.out
+++ b/tests/nvme/021.out
@@ -2,5 +2,9 @@ Running nvme/021
?91fdba0d-f87b-4c25-b80f-db7be1418b9e
?uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
?NVME Write Zeroes Success
+NVME Write Zeroes Success
+NVME Write Zeroes Success
+NVME Write Zeroes Success
+NVME Write Zeroes Success
?NQN:blktests-subsystem-1 disconnected 1 controller(s)
?Test complete

Then some of the commands pass and some fail:

--- tests/nvme/021.out? 2018-09-12 14:41:29.563976539 -0700
+++ /home/vmuser/linux/blktests/results/nodev/nvme/021.out.bad? 2018-09-12 15:30:43.037900569 -0700
@@ -1,10 +1,10 @@
?Running nvme/021
?91fdba0d-f87b-4c25-b80f-db7be1418b9e
?uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+NVME IO command error:Unknown(400f)
?NVME Write Zeroes Success
+NVME IO command error:Unknown(400f)
?NVME Write Zeroes Success
-NVME Write Zeroes Success
-NVME Write Zeroes Success
-NVME Write Zeroes Success
+NVME IO command error:Unknown(400f)
?NQN:blktests-subsystem-1 disconnected 1 controller(s)
?Test complete

I'll look a bit more, but do you know what might be causing this? This
is on v4.19-rc3 with nvme-cli 1.6.
using nvme
    
