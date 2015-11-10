From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 Nov 2015 15:51:10 +0000
Subject: nvme: controller resets
In-Reply-To: <33aa688b8da3f41960d36e66aa1703d8@localhost>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
Message-ID: <20151110155110.GA31697@localhost.localdomain>

On Tue, Nov 10, 2015@03:30:43PM +0100, Stephan G?nther wrote:
> Hello,
> 
> recently we submitted a small patch that enabled support for the Apple
> NVMe controller. More testing revealed some interesting behavior we
> cannot explain:
> 
> 1) Formatting a partition as vfat or ext2 works fine and so far,
> arbitrary loads are handled correctly by the controller.
> 
> 2) ext3/4 fails, but may be not immediately.
> 
> 3) mkfs.btrfs fails immediately.
> 
> The error is the same every time:
> | nvme 0000:03:00.0: Failed status: 3, reset controller
> | nvme 0000:03:00.0: Cancelling I/O 38 QID 1
> | nvme 0000:03:00.0: Cancelling I/O 39 QID 1
> | nvme 0000:03:00.0: Device not ready; aborting reset
> | nvme 0000:03:00.0: Device failed to resume
> | blk_update_request: I/O error, dev nvme0n1, sector 0
> | blk_update_request: I/O error, dev nvme0n1, sector 977104768
> | Buffer I/O error on dev nvme0n1p3, logical block 120827120, async page read

It says the controller asserted an internal failure status, then failed
the reset recovery. Sounds like there are other quirks to this device
you may have to reverse engineer.

> While trying to isolate the problem we found that running 'partprobe -d'
> also causes the problem.
> 
> So we attached strace to determine the failing ioctl/syscall. However,
> running 'strace -f partprobe -d' suddenly worked fine. Similar to that
> 'strace -f mkfs.btrfs' worked. However, mounting the file system caused
> the problem again.
> 
> Due to the different behavior with and without strace we assume there
> could be some kind of race condition.
> 
> Any ideas how we can track the problem further?

Not sure really. Normally I file a f/w bug for this kind of thing. :)

But I'll throw out some potential ideas. Try trottling driver capabilities
and see if anything improves: reduce queue count to 1 and depth to 2
(requires code change).

If you're able to recreate with reduced settings, then your controller's
failure can be caused by a single command, and it's hopefully just a
matter of finding that command.

If the problem is not reproducible with reduced settings, then perhaps
it's related to concurrent queue usage or high depth, and you can play
with either to see if you discover anything interesting.

Of course, I could be way off...
