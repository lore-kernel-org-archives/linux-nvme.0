From: cl@linux.com (Christopher Lameter)
Date: Wed, 6 Feb 2019 19:03:48 +0000
Subject: [LSF/MM ATTEND ] memory reclaim with NUMA rebalancing
In-Reply-To: <87h8dpnwxg.fsf@linux.ibm.com>
References: <20190130174847.GD18811@dhcp22.suse.cz>
 <87h8dpnwxg.fsf@linux.ibm.com>
Message-ID: <01000168c431dbc5-65c68c0c-e853-4dda-9eef-8a9346834e59-000000@email.amazonses.com>

On Thu, 31 Jan 2019, Aneesh Kumar K.V wrote:

> I would be interested in this topic too. I would like to
> understand the API and how it can help exploit the different type of
> devices we have on OpenCAPI.

So am I. We may want to rethink the whole NUMA API and the way we handle
different types of memory with their divergent performance
characteristics.

We need some way to allow a better selection of memory from the kernel
without creating too much complexity. We have new characteristics to
cover:

1. Persistence (NVRAM) or generally a storage device that allows access to
   the medium via a RAM like interface.

2. Coprocessor memory that can be shuffled back and forth to a device
   (HMM).

3. On Device memory (important since PCIe limitations are currently a
   problem and Intel is stuck on PCIe3 and devices start to bypass the
   processor to gain performance)

4. High Density RAM (GDDR f.e.) with different caching behavior
   and/or different cacheline sizes.

5. Modifying access characteristics by reserving slice of a cache (f.e.
   L3) for a specific memory region.

6. SRAM support (high speed memory on the processor itself or by using
   the processor cache to persist a cacheline)

And then the old NUMA stuff where only the latency to memory varies. But
that was a particular solution targeted at scaling SMP system through
interconnects. This was a mostly symmetric approach. The use of
accellerators etc etc and the above characteristics lead to more complex
assymmetric memory approaches that may be difficult to manage and use from
kernel space.
