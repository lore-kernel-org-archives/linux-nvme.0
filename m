From: hch@lst.de (Christoph Hellwig)
Date: Tue, 2 Oct 2018 19:39:24 +0200
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <4d6336da-9441-fd97-b716-ec219489175a@suse.de>
References: <20180927230557.29444-1-hch@lst.de>
 <8b06c066-3a9a-84e6-2439-159d12ed64a2@grimberg.me>
 <20180930230144.GB20144@lst.de>
 <0a7f50ea-9da7-e9f1-8341-675db3bab396@grimberg.me>
 <4d6336da-9441-fd97-b716-ec219489175a@suse.de>
Message-ID: <20181002173924.GA19808@lst.de>

On Tue, Oct 02, 2018@07:30:02PM +0200, Hannes Reinecke wrote:
>> Fair enough... I can follow up on that.
>>
> Something like this?

As ?aid I'd rather avoid the indirect call if at all possible.

Please either add a numa_id field to struct nvme_ctrl, or a
locality_dev or something.
