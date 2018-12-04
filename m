From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Dec 2018 09:11:27 -0800
Subject: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue enabled
In-Reply-To: <20181204150403.GA3630@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-3-hch@lst.de>
 <1ad65e6d-8b42-6f8e-8eb7-0b28b04e5dd4@grimberg.me>
 <20181204150403.GA3630@lst.de>
Message-ID: <93e33763-ca30-2995-7040-9bfd92a09d7d@grimberg.me>


>>> @@ -2173,6 +2157,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>>      	if (nr_io_queues == 0)
>>>    		return 0;
>>> +	
>>> +	clear_bit(NVMEQ_ENABLED, &adminq->flags);
>>>    
>>
>> This is a change of behavior, looks correct though as we can fail
>> nvme_setup_irqs after we freed the admin vector. Needs documentation
>> though..
> 
> I have a hard time parsing the above, can you point to where the problem
> is?

This flag replaces cq_vector = -1 for indicating the queue state so I'd
expect that it would not appear where the former didn't. In this case
we clear the flag in a place that before we did not set the cq_vector
before, which seems correct to me though.
