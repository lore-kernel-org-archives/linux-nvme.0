From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Jan 2018 15:30:12 +0200
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
In-Reply-To: <20180122182017.GO12043@localhost.localdomain>
References: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>
 <20180122171437.GL12043@localhost.localdomain>
 <CAKTKpr59h-PXz60BNkx4_80gHyeFawcJW17dt9Y5VRrmHRsSQA@mail.gmail.com>
 <20180122173239.GM12043@localhost.localdomain>
 <CAKTKpr4pbpKoojLVb8jCBFLOY67xbV7Q2j95EaOjEOiGMPhFCA@mail.gmail.com>
 <20180122180515.GN12043@localhost.localdomain>
 <CAKTKpr68UnMAv2ePu7P3Gv8--av7hei16cygCnVcCdABfNb51Q@mail.gmail.com>
 <20180122182017.GO12043@localhost.localdomain>
Message-ID: <dda171e0-6c24-ebf7-e6ad-3958cf3de9b9@grimberg.me>


>> AFAIK, usually drivers sets default affinity and it is likely be node
>> affinity for NUMA systems.
>> Later, it is the user-space(like irqbalance etc) which decides the
>> affinity not the driver.
> 
> Relying on userspace to provide an optimal setting is a bad idea,
> especially for NVMe where we have submission queue cpu affinity that
> doesn't work very efficiently if the completion affinity doesn't match.

I tend to agree, also application locality is equally as important as
device locality. so spreading across numa nodes will help applications
running on the far numa node as well.

Also, a recent thread [1] related to PCI_IRQ_AFFINITY not allowing
userspace to modify irq affinity suggested that maybe that can be
supported, but not sure what happened to it.

[1] https://www.spinics.net/lists/netdev/msg464301.html
