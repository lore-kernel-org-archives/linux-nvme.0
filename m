From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Jan 2015 21:16:34 +0000 (UTC)
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <54C94B90.20805@ranbarg.com>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 <yq1zj93iszd.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>
 <54C94B90.20805@ranbarg.com>
Message-ID: <alpine.LNX.2.00.1501282102210.15481@localhost.lm.intel.com>

On Wed, 28 Jan 2015, Paul Grabinar wrote:
> On 28/01/15 15:11, Keith Busch wrote:
>> Thanks for the info. NVMe doesn't appear to allow disabling metadata
>> per-io except for a subset of formats. If that's correct, this driver
>> would have to provide a valid protection buffer for all IO. Checking
>> with committee comrades for clarification.
>>
>
> It is indeed a shame that they didn't define a null meta-data pointer as
> meaning there is no meta-data. Maybe 1.3?
>
> I got around this as follows.
>
> Limit the maximum transfer so that all the meta-data fits into a single
> page. As a side note, the protection information from the kernel needs
> to be set to a maximum of one page anyway, as there is only a single PRP
> entry for the meta-data and I don't think PRP lists are allowed here.

Correct, meta-data requires a single physically contiguous buffer,
so no prp lists here. It doesn't necessarilly need to be in a single
page, though. We can have the block layer split things accordingly if
we register with this:

 	blk_queue_max_integrity_segments(ns->queue, 1);

This way no command will be recieved requiring two metadata buffers.

I was trying something similar to SCSI, and I think Christoph may
approve. Instead of all the logic deciding which namespace to attach
and which to bail, attach all namespaces from NSID 1 to the max, then:

 	set_capacity(ns->disk, 0);

Wait to initialize the format in nvme_revalidate_disk. If it's a usable
format, set capacity and sector accordingly, and leave capacity at 0 if
not. For metadata formats, leave the capacity at 0 until block integrity
extensions can be registered, then rescan.

> Allocate two 1 page DMA buffers per device, one will be used for reads
> and one for writes.
> Fill the write buffer with 0xFF, which means no protection information
> is available.
> When a read occurs and there is no kernel supplied protection
> information, set the meta-data pointer to the read buffer.
> When a write occurs and there is no kernel supplied protection
> information, set the meta-data pointer to the write buffer. This will
> write all the meta-data as 0xFF.
