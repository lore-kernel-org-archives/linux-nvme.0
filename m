From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 15 Nov 2018 11:38:20 -0700
Subject: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
In-Reply-To: <20181115182833.GA15729@roeck-us.net>
References: <20181115182833.GA15729@roeck-us.net>
Message-ID: <77d1536f-3229-1225-c5ad-d0a928c222cb@kernel.dk>

On 11/15/18 11:28 AM, Guenter Roeck wrote:
> Hi Jens,
> 
>> I think the below patch should fix it.
>>
> Sorry I wasn't able to test this earlier. Looks like it does
> fix the problem; the problem is no longer seen in next-20181115.
> Minor comment below.

That's fine, thanks for testing!

>>  		/*
>> -		 * Need IRQs for read+write queues, and one for the admin queue
>> +		 * Need IRQs for read+write queues, and one for the admin queue.
>> +		 * If we can't get more than one vector, we have to share the
>> +		 * admin queue and IO queue vector. For that case, don't add
>> +		 * an extra vector for the admin queue, or we'll continue
>> +		 * asking for 2 and get -ENOSPC in return.
>>  		 */
>> -		nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
>> +		if (result == -ENOSPC && nr_io_queues == 1)
>> +			nr_io_queues = 1;
> 
> Setting nr_io_queues to 1 when it already is set to 1 doesn't really do
> anything. Is this for clarification ?

Guess that does look a bit odd, alternative would be to flip the
condition, but I think this one is easier to read.

-- 
Jens Axboe
