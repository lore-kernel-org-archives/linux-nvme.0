From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 11 Jul 2017 22:13:40 +0000
Subject: [PATCH v7 for-4.13 6/7] block: Add rdma affinity based queue
 mapping helper
In-Reply-To: <1499671054-23899-7-git-send-email-sagi@grimberg.me>
References: <1499671054-23899-1-git-send-email-sagi@grimberg.me>
 <1499671054-23899-7-git-send-email-sagi@grimberg.me>
Message-ID: <1499811219.2586.45.camel@wdc.com>

On Mon, 2017-07-10@10:17 +0300, Sagi Grimberg wrote:
> +int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
> +		struct ib_device *dev, int first_vec)
> +{
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +
> +	if (set->nr_hw_queues > dev->num_comp_vectors)
> +		goto fallback;

Should this perhaps have been "if (first_vec + set->nr_hw_queues >
dev->num_comp_vectors)"? Additionally, since the return value of
ib_get_vector_affinity() is tested inside the loop, can this test be left out?

> +
> +	for (queue = 0; queue < set->nr_hw_queues; queue++) {
> +		mask = ib_get_vector_affinity(dev, first_vec + queue);
> +		if (!mask)
> +			goto fallback;
> +
> +		for_each_cpu(cpu, mask)
> +			set->mq_map[cpu] = queue;
> +	}
> +
> +	return 0;
> +fallback:
> +	return blk_mq_map_queues(set);

If you have to repost this patch, please insert a blank line above the
"fallback" label.

Thanks,

Bart.
