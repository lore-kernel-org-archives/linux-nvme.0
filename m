From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Dec 2018 09:13:48 -0800
Subject: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
In-Reply-To: <20181204150449.GB3630@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-6-hch@lst.de>
 <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
 <20181204150449.GB3630@lst.de>
Message-ID: <687e3fd9-fe73-5205-5656-d4861d7dd274@grimberg.me>


>>> +static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
>>
>> Do we still need to carry the tag around?
> 
> Yes, the timeout handler polls for a specific tag.

Does it have to? the documentation suggests that we missed
an interrupt, so it is probably waiting on the completion queue.

I'd say that it'd be better if the tag search would be implemented
on the timeout handler alone so we don't have to pass the tag around
for everyone... Thoughts?
