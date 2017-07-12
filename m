From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Jul 2017 13:36:19 +0300
Subject: [PATCH v7 for-4.13 6/7] block: Add rdma affinity based queue
 mapping helper
In-Reply-To: <1499811219.2586.45.camel@wdc.com>
References: <1499671054-23899-1-git-send-email-sagi@grimberg.me>
 <1499671054-23899-7-git-send-email-sagi@grimberg.me>
 <1499811219.2586.45.camel@wdc.com>
Message-ID: <70eeee7c-f227-4471-5eb9-492f77f7e8cf@grimberg.me>


>> +int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
>> +		struct ib_device *dev, int first_vec)
>> +{
>> +	const struct cpumask *mask;
>> +	unsigned int queue, cpu;
>> +
>> +	if (set->nr_hw_queues > dev->num_comp_vectors)
>> +		goto fallback;
> 
> Should this perhaps have been "if (first_vec + set->nr_hw_queues >
> dev->num_comp_vectors)"? Additionally, since the return value of
> ib_get_vector_affinity() is tested inside the loop, can this test be left out?

I guess it can...

>> +	return 0;
>> +fallback:
>> +	return blk_mq_map_queues(set);
> 
> If you have to repost this patch, please insert a blank line above the
> "fallback" label.

Will do, thanks!
