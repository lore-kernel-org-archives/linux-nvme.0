From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Jan 2015 01:21:02 +0000 (UTC)
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
Message-ID: <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>

Hi Jens and Martin,

Slightly unrelated to this original thread, but go me rethinking of
adding protection infromation support to NVMe to make use of metadata.

I can't register with the blk-integrity extentions until after add_disk
is completed because the disk's kobj needs to be initialized before
blk_integrity_register. The 'add_disk' itself submits a lot of reads,
though. Am I missing something, or how could those succeed when the
block device's required integrity format hasn't been setup?

Thanks,
Keith

On Tue, 27 Jan 2015, Keith Busch wrote:
> On Tue, 27 Jan 2015, David Darrington wrote:
>> What happens if a namespace includes metadata that is not interleaved 
>> (flbas
>> bit 4 = 0)? Won't the reads/writes through the normal block io path cause
>> metadata to be read/written to/from MPTR, which is not set in
>> nvme_submit_iod() so will point to address 0.
>
> You're absolutely right. I'm not sure what happens (I don't have a device
> with separate metadata capabilities) but was hoping the device wouldn't
> try to DMA to/from 0, or it would be aborted by the root complex if it
> made it that far. Wishful thinking, probably not aligned with reality.
>
> The nvme_submit_io() path enforces correct MPTR usage, though!
