From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 22 Jan 2018 23:42:45 +0530
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
In-Reply-To: <20180122180515.GN12043@localhost.localdomain>
References: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>
 <20180122171437.GL12043@localhost.localdomain>
 <CAKTKpr59h-PXz60BNkx4_80gHyeFawcJW17dt9Y5VRrmHRsSQA@mail.gmail.com>
 <20180122173239.GM12043@localhost.localdomain>
 <CAKTKpr4pbpKoojLVb8jCBFLOY67xbV7Q2j95EaOjEOiGMPhFCA@mail.gmail.com>
 <20180122180515.GN12043@localhost.localdomain>
Message-ID: <CAKTKpr68UnMAv2ePu7P3Gv8--av7hei16cygCnVcCdABfNb51Q@mail.gmail.com>

On Mon, Jan 22, 2018@11:35 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Jan 22, 2018@11:25:45PM +0530, Ganapatrao Kulkarni wrote:
>> what was the need to use flag PCI_IRQ_AFFINITY in NVMe driver?
>> i dont see this flag being used widely.
>
> The flag is how we get the affinity set in the first place. Without it,
> we'd have to rely on user space to set irq affinities.

AFAIK, usually drivers sets default affinity and it is likely be node
affinity for NUMA systems.
Later, it is the user-space(like irqbalance etc) which decides the
affinity not the driver.
