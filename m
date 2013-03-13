From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 13 Mar 2013 02:48:47 -0400
Subject: [PATCH] NVMe: SQ/CQ NUMA locality
In-Reply-To: <1359422441-26433-1-git-send-email-keith.busch@intel.com>
References: <1359422441-26433-1-git-send-email-keith.busch@intel.com>
Message-ID: <20130313064847.GH4530@linux.intel.com>

On Mon, Jan 28, 2013@06:20:41PM -0700, Keith Busch wrote:
> This is related to an item off the "TODO" list that suggests experimenting
> with NUMA locality. There is no dma alloc routine that takes a NUMA node id, so
> the allocations are done a bit different. I am not sure if this is the correct
> way to use dma_map/umap_single, but it seems to work fine. 

Ah ... works fine on Intel architectures ... not so fine on
other architectures.  We'd have to add in explicit calls to
dma_sync_single_for_cpu() and dma_sync_single_for_device(), and that's
just not going to be efficient.

> I tested this on an Intel SC2600C0 server with two E5-2600 Xeons (32 total
> cpu threads) with all memory sockets fully populated and giving two NUMA
> domains.  The only NVMe device I can test with is a pre-alpha level with an
> FPGA, so it doesn't run as fast as it could, but I could still measure a
> small difference using fio, though not a very significant difference.
> 
> With NUMA:
> 
>    READ: io=65534MB, aggrb=262669KB/s, minb=8203KB/s, maxb=13821KB/s, mint=152006msec, maxt=255482msec
>   WRITE: io=65538MB, aggrb=262681KB/s, minb=8213KB/s, maxb=13792KB/s, mint=152006msec, maxt=255482msec
> 
> Without NUMA:
> 
>    READ: io=65535MB, aggrb=257995KB/s, minb=8014KB/s, maxb=13217KB/s, mint=159122msec, maxt=264339msec
>   WRITE: io=65537MB, aggrb=258001KB/s, minb=8035KB/s, maxb=13198KB/s, mint=159122msec, maxt=264339msec

I think we can get in trouble for posting raw numbers ... so let's
pretend you simply said "About a 2% performance improvement".  Now, OK,
that doesn't sound like much, but that's significant enough to make this
worth pursuing.

So ... I think we need to add a dma_alloc_attrs_node() or something,
and pass the nid all the way down to the ->alloc routine.

Another thing I'd like you to try is allocating *only* the completion
queue local to the node.  ie allocate the submission queue on the node
local to the device and the completion queue on the node local to the
CPU that is using it.

My reason for thinking this is a good idea is the assumption that
cross-node writes are cheaper than reads.  So having the CPU write to
remote memory, the device read from local memory, then the device write
to remote memory and the CPU read from local memory should work out
better than either allocating both the submission & completion queues
local to the CPU or local to the device.

I think that dma_alloc_coherent currently allocates memory local to the
device, so all you need to do to test this theory is revert the half of
your patch which allocates the submission queue local to the CPU.

Thanks for trying this out!
