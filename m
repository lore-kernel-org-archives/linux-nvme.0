From: keith.busch@intel.com (Keith Busch)
Date: Wed, 9 Dec 2015 22:43:28 +0000
Subject: kernel BUG at drivers/block/nvme-core.c:732!
In-Reply-To: <3AAC62DB-A747-48D7-9D9F-F96433D71FFE@roche.com>
References: <3AAC62DB-A747-48D7-9D9F-F96433D71FFE@roche.com>
Message-ID: <20151209224328.GA4617@localhost.localdomain>

On Wed, Dec 09, 2015@02:14:37PM -0800, Seufert, Tim wrote:
> Computer: i7-6700k CPU, Supermicro X11SS-Q motherboard, and a Samsung 950 Pro NVME SSD
> Linux version: CentOS 6.7 with ElRepo kernel-ml 4.3.0
> 
> What led up to the event: This is a very new system and I had just put it together and copied over a KVM guest (the guest OS is also CentOS 6.7).  At the time the ?kernel BUG? occurred, the guest was midway through updating itself, so yum/rpm was generating plenty of I/O. Since its disk image file was located on the host?s 950 Pro, this was generating NVME traffic.  The BUG resulted in the guest hanging forever (couldn?t open new terminals, make SSH connections, or do anything else that required disk I/O), but oddly enough the host did not hang even though its root FS was on the same NVME SSD partition containing the guest image.  I had to reboot the host to recover.
> 
> I have since replaced the host OS installation with a fresh install of CentOS 7, but am still running kernel-ml 4.3.0.  So far I have not seen a repetition of this BUG.

The BUG_ON below means the driver detected the SGL list it was provided
is not PRP'able. In the past, this has meant that the virtual address
page offset does not match the DMA address offset.

I've not seen this repeat on x86 architectures before. If you can find
a test case that reproduces this, we should be able to figure out what
is making this happen.

> A side question: Is the advice to not enable discard in Intel?s NVME driver reference guide (https://downloadmirror.intel.com/23929/eng/Intel_Linux_NVMe_Driver_Reference_Guide_330602-002.pdf) still considered valid? It claims "You want to allow the SSD manage blocks and its activity between the NVM (non-volatile memory) and host with more advanced and consistent approaches in the SSD Controller? but it?s not clear to me how the SSD controller can have a more advanced and consistent approach if it isn?t ever notified when blocks are okay to throw away.

Not sure what the guide taking about. I'll check with the author.
 
> Dec  1 19:08:52 verra kernel: ------------[ cut here ]------------
> Dec  1 19:08:52 verra kernel: kernel BUG at drivers/block/nvme-core.c:732!
