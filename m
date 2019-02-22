From: jonathan.cameron@huawei.com (Jonathan Cameron)
Date: Fri, 22 Feb 2019 13:48:54 +0000
Subject: [LSF/MM ATTEND ] memory reclaim with NUMA rebalancing
In-Reply-To: <01000168c431dbc5-65c68c0c-e853-4dda-9eef-8a9346834e59-000000@email.amazonses.com>
References: <20190130174847.GD18811@dhcp22.suse.cz>
 <87h8dpnwxg.fsf@linux.ibm.com>
 <01000168c431dbc5-65c68c0c-e853-4dda-9eef-8a9346834e59-000000@email.amazonses.com>
Message-ID: <20190222134854.000039f7@huawei.com>

On Wed, 6 Feb 2019 19:03:48 +0000
Christopher Lameter <cl@linux.com> wrote:

> On Thu, 31 Jan 2019, Aneesh Kumar K.V wrote:
> 
> > I would be interested in this topic too. I would like to
> > understand the API and how it can help exploit the different type of
> > devices we have on OpenCAPI.  

I'll second this from CCIX as well ;)  We get more crazy with topologies than
even OpenCAPI but thankfully it'll probably be a little while before full plug
in and play topology building occurs, so we have time to get this right.

> 
> So am I. We may want to rethink the whole NUMA API and the way we handle
> different types of memory with their divergent performance
> characteristics.
> 
> We need some way to allow a better selection of memory from the kernel
> without creating too much complexity. We have new characteristics to
> cover:
> 
> 1. Persistence (NVRAM) or generally a storage device that allows access to
>    the medium via a RAM like interface.

We definitely have this one, with all the usecases that turn up anywhere
including importantly the cheap extremely large ram option.

> 
> 2. Coprocessor memory that can be shuffled back and forth to a device
>    (HMM).

I'm not sure how this applies to fully coherent device memory.  In those
cases you 'might' want to shuffle the memory to the device, but it is
incredibly usecase dependent on whether that makes more sense than
simply relying on your coherent caches at the device to deal with it.

One key thing here is access to the information on who is using
the memory.  NUMA balancing is fine, but often much finer, or more
long term statistical data info is needed.  So basically similar
to the hot page tracking work, but with tracking of 'who' accessed
it (needs hardware support to avoid the cost of current NUMA
balancing?)

Performance measurement units can help with this where present, but we
need a means to poke that information into what ever is handling placement
/migration decisions.
(I do like the user space aspect of the Intel hot page migration patch
as it lets us play a lot more in this area - particularly prior to any
standards being defined.)

For us (allowing for hardware tracking of ATCs) etc the recent
migration of hot / cold pages set in and out of NVDIMMs only covers
the simplest of cases (expansion memory) where the topology if really
straight forward. It's a good step, but perhaps only a first one...

> 
> 3. On Device memory (important since PCIe limitations are currently a
>    problem and Intel is stuck on PCIe3 and devices start to bypass the
>    processor to gain performance)

Whilst it's not so bad on CCIX or our platforms in general, PCIe 5.0+ is
still some way off and I'm sure there are already applications that
are bandwidth limited at 64GBit/S.  However, having said that, we are
interested in peer 2 peer migration of memory between devices
(probably all still coherent but in theory doesn't have to be).
Once we get complex accelerator interactions on large Fabrics, knowing
what to do here gets really tricky.  You can do some of this with aware
user space code and current NUMA interfaces.  There are also fun side
decisions such as where to put your pagetables in such a system as
the walker and the translation user may not be anywhere near each other
or anywhere near the memory being used.

> 
> 4. High Density RAM (GDDR f.e.) with different caching behavior
>    and/or different cacheline sizes.

That is an interesting one, particularly when we have caches out
in the interconnect. Gets really interesting if those caches are
shared by multiple memories and you may or may not have partitioning +
really complex cache implementations and hardware trickery.

Basically it's more memory heterogeneity, just wrt to caches in the
path.

> 
> 5. Modifying access characteristics by reserving slice of a cache (f.e.
>    L3) for a specific memory region.

A possible complexity, as is reservations for particular process groups.

> 
> 6. SRAM support (high speed memory on the processor itself or by using
>    the processor cache to persist a cacheline)
> 
> And then the old NUMA stuff where only the latency to memory varies. But
> that was a particular solution targeted at scaling SMP system through
> interconnects. This was a mostly symmetric approach. The use of
> accellerators etc etc and the above characteristics lead to more complex
> assymmetric memory approaches that may be difficult to manage and use from
> kernel space.
> 

Agreed entirely on this last point.  This stuff is getting really complex,
and people have an annoying habit of just expecting it to work well.  Moving
the burden of memory placement to user space (with enough description
of the hardware for it to make a good decision) seems a good idea to me.

This is particularly true whilst some of the hardware design decisions
are still up in the air.  Clearly there are aspects that we want to 'just
work' that make sense in kernel, but how do we ensure we have enough hooks
to allow smart userspace code to make the decisions without having to work
around the the in kernel management?

It's worth noting the hardware people are often open to suggestions for what
info software will actually used.  Some of the complexity of that decision
space could definitely be reduced if we get some agreement on what the kernel
needs to know, so we can push for hardware that can self describe.
There are also cases where specifications wait on the kernel community coming to
some consensus so to ensure the hardware matches the requirements.

It is also worth noting that the kernel community has various paths (including
some on this list) to feedback into the firmware specifications etc.  If
there are things the kernel needs to magically know, then we propose
changes at all levels: Hardware specs, firmware, (kernel obviously), user space.

It has been raised before in a number of related threads, but it is worth
keeping in mind the questions:

1) How much effort will userspace put into using any controls we give it?
   HPC people might well, but their platforms tend to be repeated a lot,
   so they will sometimes take the time to hand tune to a particular hardware
   configuration.

2) Does the 'normal' user need this complexity soon?  We need to make sure
   things work well with defaults, if this heterogeneous hardware starts
   turning up in highly varied configurations in workstations / servers.

While I'm highly interested in this area, I'm not an mm specialist. I want
solutions, but I'm sure most of the ideas I have are crazy ;)  Seeing the
hardware coming down the line, crazy may be needed.

Jonathan
