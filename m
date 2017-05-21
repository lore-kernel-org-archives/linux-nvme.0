From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 21 May 2017 20:31:47 +0200 (CEST)
Subject: [PATCH 2/7] genirq/affinity: assign vectors to all present
 CPUs
In-Reply-To: <20170519085756.29742-3-hch@lst.de>
References: <20170519085756.29742-1-hch@lst.de>
 <20170519085756.29742-3-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1705212028280.3023@nanos>

On Fri, 19 May 2017, Christoph Hellwig wrote:
> -	/* Stabilize the cpumasks */
> -	get_online_cpus();

How is that protected against physical CPU hotplug? Physical CPU hotplug
manipulates the present mask.

> -	nodes = get_nodes_in_cpumask(cpu_online_mask, &nodemsk);
> +	nodes = get_nodes_in_cpumask(cpu_present_mask, &nodemsk);
> +static int __init irq_build_cpumap(void)
> +{
> +	int node, cpu;
> +
> +	for (node = 0; node < nr_node_ids; node++) {
> +		if (!zalloc_cpumask_var(&node_to_present_cpumask[node],
> +				GFP_KERNEL))
> +			panic("can't allocate early memory\n");
> +	}
>  
> -	return min(cpus, vecs) + resv;
> +	for_each_present_cpu(cpu) {
> +		node = cpu_to_node(cpu);
> +		cpumask_set_cpu(cpu, node_to_present_cpumask[node]);
> +	}

This mask needs updating on physical hotplug as well.

Thanks,

	tglx
