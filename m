From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 11:20:17 -0700
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
In-Reply-To: <CAKTKpr68UnMAv2ePu7P3Gv8--av7hei16cygCnVcCdABfNb51Q@mail.gmail.com>
References: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>
 <20180122171437.GL12043@localhost.localdomain>
 <CAKTKpr59h-PXz60BNkx4_80gHyeFawcJW17dt9Y5VRrmHRsSQA@mail.gmail.com>
 <20180122173239.GM12043@localhost.localdomain>
 <CAKTKpr4pbpKoojLVb8jCBFLOY67xbV7Q2j95EaOjEOiGMPhFCA@mail.gmail.com>
 <20180122180515.GN12043@localhost.localdomain>
 <CAKTKpr68UnMAv2ePu7P3Gv8--av7hei16cygCnVcCdABfNb51Q@mail.gmail.com>
Message-ID: <20180122182017.GO12043@localhost.localdomain>

On Mon, Jan 22, 2018@11:42:45PM +0530, Ganapatrao Kulkarni wrote:
> 
> AFAIK, usually drivers sets default affinity and it is likely be node
> affinity for NUMA systems.
> Later, it is the user-space(like irqbalance etc) which decides the
> affinity not the driver.

Relying on userspace to provide an optimal setting is a bad idea,
especially for NVMe where we have submission queue cpu affinity that
doesn't work very efficiently if the completion affinity doesn't match.
