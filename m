From: hare@suse.de (Hannes Reinecke)
Date: Wed, 3 Oct 2018 10:56:12 +0200
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <20181002173924.GA19808@lst.de>
References: <20180927230557.29444-1-hch@lst.de>
 <8b06c066-3a9a-84e6-2439-159d12ed64a2@grimberg.me>
 <20180930230144.GB20144@lst.de>
 <0a7f50ea-9da7-e9f1-8341-675db3bab396@grimberg.me>
 <4d6336da-9441-fd97-b716-ec219489175a@suse.de>
 <20181002173924.GA19808@lst.de>
Message-ID: <a033c3a2-b825-4d9a-e844-adddea2e155f@suse.de>

On 10/2/18 7:39 PM, Christoph Hellwig wrote:
> On Tue, Oct 02, 2018@07:30:02PM +0200, Hannes Reinecke wrote:
>>> Fair enough... I can follow up on that.
>>>
>> Something like this?
> 
> As ?aid I'd rather avoid the indirect call if at all possible.
> 
> Please either add a numa_id field to struct nvme_ctrl, or a
> locality_dev or something.
> 
Ah. So that should be more like it.

Cheers,

Hannes


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-nvme-NUMA-locality-information-for-fabrics.patch
Type: text/x-patch
Size: 5801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20181003/104480f2/attachment-0001.bin>
