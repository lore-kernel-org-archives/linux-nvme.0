From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 13 Nov 2018 20:52:37 -0800
Subject: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
In-Reply-To: <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
References: <20181114004148.GA29545@roeck-us.net>
 <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
Message-ID: <20181114045237.GA6456@roeck-us.net>

On Tue, Nov 13, 2018@05:51:08PM -0700, Jens Axboe wrote:
> On 11/13/18 5:41 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > On Wed, Oct 31, 2018@08:36:31AM -0600, Jens Axboe wrote:
> >> NVMe does round-robin between queues by default, which means that
> >> sharing a queue map for both reads and writes can be problematic
> >> in terms of read servicing. It's much easier to flood the queue
> >> with writes and reduce the read servicing.
> >>
> >> Implement two queue maps, one for reads and one for writes. The
> >> write queue count is configurable through the 'write_queues'
> >> parameter.
> >>
> >> By default, we retain the previous behavior of having a single
> >> queue set, shared between reads and writes. Setting 'write_queues'
> >> to a non-zero value will create two queue sets, one for reads and
> >> one for writes, the latter using the configurable number of
> >> queues (hardware queue counts permitting).
> >>
> >> Reviewed-by: Hannes Reinecke <hare at suse.com>
> >> Reviewed-by: Keith Busch <keith.busch at intel.com>
> >> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> > 
> > This patch causes hangs when running recent versions of
> > -next with several architectures; see the -next column at
> > kerneltests.org/builders for details.  Bisect log below; this
> > was run with qemu on alpha. Reverting this patch as well as
> > "nvme: add separate poll queue map" fixes the problem.
> 
> I don't see anything related to what hung, the trace, and so on.
> Can you clue me in? Where are the test results with dmesg?
> 
alpha just stalls during boot. parisc reports a hung task
in nvme_reset_work. sparc64 reports EIO when instantiating
the nvme driver, called from nvme_reset_work, and then stalls.
In all three cases, reverting the two mentioned patches fixes
the problem.

https://kerneltests.org/builders/qemu-parisc-next/builds/173/steps/qemubuildcommand_1/logs/stdio

is an example log for parisc.

I didn't check if the other boot failures (ppc looks bad)
have the same root cause.

> How to reproduce?
> 
parisc:

qemu-system-hppa -kernel vmlinux -no-reboot \
	-snapshot -device nvme,serial=foo,drive=d0 \
	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0,115200 ' \
	-nographic -monitor null

alpha:

qemu-system-alpha -M clipper -kernel arch/alpha/boot/vmlinux -no-reboot \
	-snapshot -device nvme,serial=foo,drive=d0 \
	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0' \
	-m 128M -nographic -monitor null -serial stdio

sparc64:

qemu-system-sparc64 -M sun4u -cpu 'TI UltraSparc IIi' -m 512 \
	-snapshot -device nvme,serial=foo,drive=d0,bus=pciB \
	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
	-kernel arch/sparc/boot/image -no-reboot \
	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0' \
	-nographic -monitor none

The root file systems are available from the respective subdirectories
of:

https://github.com/groeck/linux-build-test/tree/master/rootfs

Guenter
