From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Jan 2018 21:39:02 +0200
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
In-Reply-To: <20180124154841.GC14790@localhost.localdomain>
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
 <20180124154841.GC14790@localhost.localdomain>
Message-ID: <00b6171e-bc74-9123-a132-14e56f9133dd@grimberg.me>


>> application uses libnuma to align to numa locality.
>> here the driver is breaking the affinity.
>> certainly having affinity with remote node cpu will add latency to
>> interrupt response time.
>> here it is for some NVMe queues.
> 
> I bet you can't come up with an IRQ CPU affinity map that performs better
> than the current setup.

:)

While I agree that managed affinity will probably get the optimal
affinitization in 99% of the cases, this is the second complaint we've
had that managed affinity breaks an existing user interface (even though
it was a sure way to allow userspace to screw up for years).

My mlx5 conversion ended up reverted due to that...
