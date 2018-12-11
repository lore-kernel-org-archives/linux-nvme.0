From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 11 Dec 2018 06:24:07 -0700
Subject: [PATCH] nvme: fix irq vs io_queue calculations
In-Reply-To: <20181211070855.GA13999@lst.de>
References: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
 <20181211070855.GA13999@lst.de>
Message-ID: <1545181f-d083-0935-93fe-0f4f83ee7567@kernel.dk>

On 12/11/18 12:08 AM, Christoph Hellwig wrote:
>> +		if (!(result < 0 || irq_queues == 1))
>> +			irq_queues = irq_sets[0] + irq_sets[1] + 1;
> 
> Maybe its just me, but I hate this style of conditions, why not:
> 
> 		if (result >= 0 && irq_queues > 1)
> 			irq_queues = irq_sets[0] + irq_sets[1] + 1;

I'll change it, that is more readable (and logically identical).

-- 
Jens Axboe
