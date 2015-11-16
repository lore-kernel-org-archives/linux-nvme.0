From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Mon, 16 Nov 2015 11:35:34 +0200
Subject: [PATCH 8/8] nvme-loop: add a NVMe loopback device
In-Reply-To: <20151116082946.GB21218@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-9-git-send-email-hch@lst.de>
 <5648DA8A.6060705@dev.mellanox.co.il> <20151116082946.GB21218@lst.de>
Message-ID: <5649A366.8080509@dev.mellanox.co.il>



On 16/11/2015 10:29, Christoph Hellwig wrote:
> On Sun, Nov 15, 2015@09:18:34PM +0200, Sagi Grimberg wrote:
>>
>>> +	ctrl->queue_count = 1; /* admin queue */;
>>> +	if (nr_io_queues > 0)
>>> +		ctrl->queue_count += nr_io_queues;
>>> +	else
>>> +		ctrl->queue_count += num_possible_cpus();
>>
>> This should really be num_online_cpus(), I get way more than
>> I need with num_possible_cpus()...
>
> Maybe.  But then we'd want a hot plug event.  The whole number of
> contexts thing is a bit of a mess.

Or we can just remain with more or less queues then cpus... it is
already possible if the user used nr_io_queues != num_online_cpus()...
