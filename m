From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 14:46:43 +0200
Subject: [PATCH 2/2] nvme: no need to wait for the reset when keepalive
 fails
In-Reply-To: <e26a5920-3625-1876-3a89-e85a74846f5d@grimberg.me>
References: <20170612162738.19022-1-hch@lst.de>
 <20170612162738.19022-2-hch@lst.de>
 <b9348f66-2530-6e3c-67e4-7f0a56b7fc5a@grimberg.me>
 <20170615121647.GA18698@infradead.org>
 <e26a5920-3625-1876-3a89-e85a74846f5d@grimberg.me>
Message-ID: <20170615124643.GA23852@lst.de>

On Thu, Jun 15, 2017@03:46:01PM +0300, Sagi Grimberg wrote:
>>> Thanks,
>>>
>>> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>>
>> Can you give me a review for the updated patch 1 as well?
>
> What was updated in it?

I dropped the admin_queue checks as request by you.
