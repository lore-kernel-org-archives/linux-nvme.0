From: hch@lst.de (Christoph Hellwig)
Date: Mon, 16 Nov 2015 09:29:46 +0100
Subject: [PATCH 8/8] nvme-loop: add a NVMe loopback device
In-Reply-To: <5648DA8A.6060705@dev.mellanox.co.il>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-9-git-send-email-hch@lst.de>
 <5648DA8A.6060705@dev.mellanox.co.il>
Message-ID: <20151116082946.GB21218@lst.de>

On Sun, Nov 15, 2015@09:18:34PM +0200, Sagi Grimberg wrote:
>
>> +	ctrl->queue_count = 1; /* admin queue */;
>> +	if (nr_io_queues > 0)
>> +		ctrl->queue_count += nr_io_queues;
>> +	else
>> +		ctrl->queue_count += num_possible_cpus();
>
> This should really be num_online_cpus(), I get way more than
> I need with num_possible_cpus()...

Maybe.  But then we'd want a hot plug event.  The whole number of
contexts thing is a bit of a mess.
