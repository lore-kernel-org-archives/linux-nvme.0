From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Feb 2018 08:27:41 -0700
Subject: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
In-Reply-To: <9252f0a1-f3e5-414b-db49-e8053dfa48a6@oracle.com>
References: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180227151311.GD10832@localhost.localdomain>
 <9252f0a1-f3e5-414b-db49-e8053dfa48a6@oracle.com>
Message-ID: <20180228152741.GA16002@localhost.localdomain>

On Wed, Feb 28, 2018@10:53:31AM +0800, jianchao.wang wrote:
> On 02/27/2018 11:13 PM, Keith Busch wrote:
> > On Tue, Feb 27, 2018@04:46:17PM +0800, Jianchao Wang wrote:
> >> Currently, adminq and ioq0 share the same irq vector. This is
> >> unfair for both amdinq and ioq0.
> >>  - For adminq, its completion irq has to be bound on cpu0.
> >>  - For ioq0, when the irq fires for io completion, the adminq irq
> >>    action has to be checked also.
> > 
> > This change log could use some improvements. Why is it bad if admin
> > interrupts affinity is with cpu0?
> 
> adminq interrupts should be able to fire everywhere.
> do we have any reason to bound it on cpu0 ?

Your patch will have the admin vector CPU affinity mask set to
0xff..ff. The first set bit for an online CPU is the one the IRQ handler
will run on, so the admin queue will still only run on CPU 0.
 
> > Are you able to measure _any_ performance difference on IO queue 1 vs IO
> > queue 2 that you can attribute to IO queue 1's sharing vector 0?
> 
> Actually, I didn't get any performance improving on my own NVMe card.
> But it may be needed on some enterprise card, especially the media is persist memory.
> nvme_irq will be invoked twice when ioq0 irq fires, this will introduce another unnecessary DMA
> accessing on cq entry.

A CPU reading its own memory isn't a DMA. It's just a cheap memory read.
