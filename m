From: xgchenshy@gmail.com (=?UTF-8?B?6ZmI5pmT5YWJ?=)
Date: Thu, 13 Oct 2016 10:26:39 +0800
Subject: SM951 SSD always see "failed status 3, reset controller" on nvme
Message-ID: <CAEj2FWNzJ1KHe-25afDmbMOBzMwRHaQhrWX2j=BRdQbvMS8ipA@mail.gmail.com>

Guys
I'm using nvme with SM951 SSD and I see "failed status, reset
controller" again and again, I'm wondering if I missed any config for
this device, does any body see such errors before?

[  961.284092] nvme 0000:01:00.0: Failed status: 0x3, reset controller.
[  961.640310] nvme 0000:01:00.0: async event result 00010000
[  992.274323] nvme 0000:01:00.0: I/O 6 QID 1 timeout, disable controller
[  992.296774] blk_update_request: I/O error, dev nvme0n1, sector 38458
[  992.298834] blk_update_request: I/O error, dev nvme0n1, sector 37690
[  992.300373] EXT4-fs warning (device nvme0n1p1): ext4_end_bio:329:
I/O error -5 writing to inode 14 (offset 274432 size 262144 starting
block 18973)
[  992.304710] Buffer I/O error on device nvme0n1p1, logical block 18701
[  992.306057] Buffer I/O error on device nvme0n1p1, logical block 18702
[  992.307361] Buffer I/O error on device nvme0n1p1, logical block 18703
[  992.308668] Buffer I/O error on device nvme0n1p1, logical block 18704
[  992.320937] Buffer I/O error on device nvme0n1p1, logical block 18705
[  992.322307] Buffer I/O error on device nvme0n1p1, logical block 18706
[  992.323625] Buffer I/O error on device nvme0n1p1, logical block 18707
[  992.324935] Buffer I/O error on device nvme0n1p1, logical block 18708
[  992.326897] Buffer I/O error on device nvme0n1p1, logical block 18709
[  992.328238] Buffer I/O error on device nvme0n1p1, logical block 18710
