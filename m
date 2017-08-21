From: keith.busch@intel.com (Keith Busch)
Date: Mon, 21 Aug 2017 16:04:37 -0400
Subject: NVMe driver with kernel panic
In-Reply-To: <CADcj3=5oXJzsBO7eNPNbGM+W9qKwbVBmmokY9h7-qP8butZLTg@mail.gmail.com>
References: <CADcj3=5oXJzsBO7eNPNbGM+W9qKwbVBmmokY9h7-qP8butZLTg@mail.gmail.com>
Message-ID: <20170821200436.GF21397@localhost.localdomain>

On Mon, Aug 21, 2017@03:23:09PM -0400, Felipe Arturo Polanco wrote:
> Hello,
> 
> We have been having kernel panics in our servers while using NVMe disks.
> Our setup consist of two Intel P4500 in Software Raid1 with mdadm.
> We are running KVM on top of them.
> 
> The message we see in ring buffer is the following:
> 
> [531622.412922] ------------[ cut here ]------------
> [531622.413254] kernel BUG at drivers/nvme/host/pci.c:467!
> [531622.413468] invalid opcode: 0000 [#1] SMP
> 
> Online we found a workaround to avoid using the explicit BUG_ON() and
> instead we got that changed to WARN_ONCE() to not crash the server but
> we are not entirely sure if this is a fix at all as it may cause other
> issues.

Hi,

The WARN isn't really a work-around to the BUG, but it should make it
easier to determine what's broken. You'll get IO errrors instead of a
kernel panic.
 
> We were told by a developer that this issue is caused by wrong block
> size being reported by the hardware, 4KB expected and got 512 bytes
> instead.

This should mean that the driver got a scatter list that isn't usable
under the queue constraints it registered with for PRP alignment. It's a
memory alignment problem rather than a block size problem.

> Has anyone seen this before or has applied a patch that fixed this?
> 
> We are running VzLinux7 based on RHEL 7.3, kernel 3.10.0-514.26.1.vz7.33.22

The stacking drivers like MD RAID may have been able to submit incorrectly
merged IO in that release. Do you know if this successful in RHEL 7.4? I
think all the issues with merging were fixed there.
