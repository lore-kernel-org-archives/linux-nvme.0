From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Tue, 10 Nov 2015 15:30:43 +0100
Subject: nvme: controller resets
Message-ID: <33aa688b8da3f41960d36e66aa1703d8@localhost>

Hello,

recently we submitted a small patch that enabled support for the Apple
NVMe controller. More testing revealed some interesting behavior we
cannot explain:

1) Formatting a partition as vfat or ext2 works fine and so far,
arbitrary loads are handled correctly by the controller.

2) ext3/4 fails, but may be not immediately.

3) mkfs.btrfs fails immediately.

The error is the same every time:
| nvme 0000:03:00.0: Failed status: 3, reset controller
| nvme 0000:03:00.0: Cancelling I/O 38 QID 1
| nvme 0000:03:00.0: Cancelling I/O 39 QID 1
| nvme 0000:03:00.0: Device not ready; aborting reset
| nvme 0000:03:00.0: Device failed to resume
| blk_update_request: I/O error, dev nvme0n1, sector 0
| blk_update_request: I/O error, dev nvme0n1, sector 977104768
| Buffer I/O error on dev nvme0n1p3, logical block 120827120, async page read


While trying to isolate the problem we found that running 'partprobe -d'
also causes the problem.

So we attached strace to determine the failing ioctl/syscall. However,
running 'strace -f partprobe -d' suddenly worked fine. Similar to that
'strace -f mkfs.btrfs' worked. However, mounting the file system caused
the problem again.

Due to the different behavior with and without strace we assume there
could be some kind of race condition.

Any ideas how we can track the problem further?

Best,
Stephan
