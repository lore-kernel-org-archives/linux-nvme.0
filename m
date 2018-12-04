From: axboe@fb.com (Jens Axboe)
Date: Tue, 4 Dec 2018 18:19:20 +0000
Subject: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
In-Reply-To: <687e3fd9-fe73-5205-5656-d4861d7dd274@grimberg.me>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-6-hch@lst.de>
 <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
 <20181204150449.GB3630@lst.de>
 <687e3fd9-fe73-5205-5656-d4861d7dd274@grimberg.me>
Message-ID: <275863f0-bb1f-8939-f6ba-6059b463d10a@fb.com>

On 12/4/18 10:13 AM, Sagi Grimberg wrote:
> 
>>>> +static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
>>>
>>> Do we still need to carry the tag around?
>>
>> Yes, the timeout handler polls for a specific tag.
> 
> Does it have to? the documentation suggests that we missed
> an interrupt, so it is probably waiting on the completion queue.
> 
> I'd say that it'd be better if the tag search would be implemented
> on the timeout handler alone so we don't have to pass the tag around
> for everyone... Thoughts?

Without that you don't know if that's the request that completed. You
have to be able to look that up from the timeout handler.

-- 
Jens Axboe
