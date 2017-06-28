From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 17:58:53 +0300
Subject: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Message-ID: <e9cccad7-804a-f68b-b184-46cc5be2f01d@grimberg.me>


> +static int cpu_to_queue_index(unsigned int nr_queues, const int cpu,
> +			      const struct cpumask *online_mask)
>   {
> -	return cpu * nr_queues / nr_cpus;
> +	/*
> +	 * Non online CPU will be mapped to queue index 0.
> +	 */
> +	if (!cpumask_test_cpu(cpu, online_mask))
> +		return 0;

Why not map offline cpus to what they would've map to if they were
online?

> +		if (cpu < nr_queues) {
> +			map[cpu] = cpu_to_queue_index(nr_queues, cpu, online_mask);
> +		} else {
> +			first_sibling = get_first_sibling(cpu);
> +			if (first_sibling == cpu)
> +				map[cpu] = cpu_to_queue_index(nr_queues, cpu, online_mask);

This seems to be the only reference to online_mask left (on each side of
the if statement. I think you can just not pass it and use
cpu_online_mask in cpu_to_queue_index.
