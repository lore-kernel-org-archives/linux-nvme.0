From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Tue, 10 Nov 2015 21:45:11 +0100
Subject: nvme: controller resets
In-Reply-To: <20151110155110.GA31697@localhost.localdomain>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
Message-ID: <3dda89a86dbd6c8ede4057884c43170c@localhost>

On 2015/November/10 03:51, Keith Busch wrote:
> On Tue, Nov 10, 2015@03:30:43PM +0100, Stephan G?nther wrote:
> > Hello,
> > 
> > recently we submitted a small patch that enabled support for the Apple
> > NVMe controller. More testing revealed some interesting behavior we
> > cannot explain:
> > 
> > 1) Formatting a partition as vfat or ext2 works fine and so far,
> > arbitrary loads are handled correctly by the controller.
> > 
> > 2) ext3/4 fails, but may be not immediately.
> > 
> > 3) mkfs.btrfs fails immediately.
> > 
> > The error is the same every time:
> > | nvme 0000:03:00.0: Failed status: 3, reset controller
> > | nvme 0000:03:00.0: Cancelling I/O 38 QID 1
> > | nvme 0000:03:00.0: Cancelling I/O 39 QID 1
> > | nvme 0000:03:00.0: Device not ready; aborting reset
> > | nvme 0000:03:00.0: Device failed to resume
> > | blk_update_request: I/O error, dev nvme0n1, sector 0
> > | blk_update_request: I/O error, dev nvme0n1, sector 977104768
> > | Buffer I/O error on dev nvme0n1p3, logical block 120827120, async page read
> 
> It says the controller asserted an internal failure status, then failed
> the reset recovery. Sounds like there are other quirks to this device
> you may have to reverse engineer.

We figured that one out: NVME_CSTS_CFS = Controller Fatal State ...

> 
> > While trying to isolate the problem we found that running 'partprobe -d'
> > also causes the problem.
> > 
> > So we attached strace to determine the failing ioctl/syscall. However,
> > running 'strace -f partprobe -d' suddenly worked fine. Similar to that
> > 'strace -f mkfs.btrfs' worked. However, mounting the file system caused
> > the problem again.
> > 
> > Due to the different behavior with and without strace we assume there
> > could be some kind of race condition.
> > 
> > Any ideas how we can track the problem further?
> 
> Not sure really. Normally I file a f/w bug for this kind of thing. :)

I would file one if there were any hope of an answer...

> 
> But I'll throw out some potential ideas. Try trottling driver capabilities

That's the next thing we will try.

> and see if anything improves: reduce queue count to 1 and depth to 2
> (requires code change).

Reducing the queue count rendered the controller unable to resume. Maybe
we missed something. However, since the errors always hint at QID 1, I
don't think that too many queues are the problem.

Reducing the queue depth to 32/16 resulted in the same error. Reduction 
to 2/2 failed.

> 
> If you're able to recreate with reduced settings, then your controller's
> failure can be caused by a single command, and it's hopefully just a
> matter of finding that command.
> 
> If the problem is not reproducible with reduced settings, then perhaps
> it's related to concurrent queue usage or high depth, and you can play
> with either to see if you discover anything interesting.

Starting the kernel with nr_cpus=1 didn't change anything although race 
conditions are probably still possible due to async signalling or
interrupts.


The only thing that might still explain something: 'nvme show-regs'
suffers from the same problems with readq. If for any reason other
userspace tools work in a similar way to read the controller's
capabilities, it has to fail.

But I know of no reason why, e.g. mkfs.btrfs should do somehting like
that.

Best,
Stephan
