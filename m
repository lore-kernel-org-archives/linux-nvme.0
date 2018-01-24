From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Jan 2018 08:48:42 -0700
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
In-Reply-To: <CAKTKpr45pNcEtruqemwEm0uoDHizCJNNosiNbavz9+6LTttrVg@mail.gmail.com>
References: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>
 <20180122171437.GL12043@localhost.localdomain>
 <CAKTKpr59h-PXz60BNkx4_80gHyeFawcJW17dt9Y5VRrmHRsSQA@mail.gmail.com>
 <20180122173239.GM12043@localhost.localdomain>
 <CAKTKpr4pbpKoojLVb8jCBFLOY67xbV7Q2j95EaOjEOiGMPhFCA@mail.gmail.com>
 <20180122180515.GN12043@localhost.localdomain>
 <CAKTKpr68UnMAv2ePu7P3Gv8--av7hei16cygCnVcCdABfNb51Q@mail.gmail.com>
 <20180122182017.GO12043@localhost.localdomain>
 <dda171e0-6c24-ebf7-e6ad-3958cf3de9b9@grimberg.me>
 <CAKTKpr45pNcEtruqemwEm0uoDHizCJNNosiNbavz9+6LTttrVg@mail.gmail.com>
Message-ID: <20180124154841.GC14790@localhost.localdomain>

On Wed, Jan 24, 2018@07:47:44AM +0530, Ganapatrao Kulkarni wrote:
> application uses libnuma to align to numa locality.
> here the driver is breaking the affinity.
> certainly having affinity with remote node cpu will add latency to
> interrupt response time.
> here it is for some NVMe queues.

I bet you can't come up with an IRQ CPU affinity map that performs better
than the current setup.
