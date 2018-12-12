From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 08:05:10 +0100
Subject: [PATCH v2 4/5] nvme-tcp: support separate queue maps for read
 and write
In-Reply-To: <20181211233519.9350-5-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <20181211233519.9350-5-sagi@grimberg.me>
Message-ID: <20181212070510.GA28461@lst.de>

> -	queue->io_cpu = (qid == 0) ? 0 : qid - 1;
> +	n = (qid ? qid - 1 : 0) % num_online_cpus();
> +	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);

Nitpick: can you use an if/else here?  The ? : construct just looks
like obsfucation.

If nothing else pops up I can fix that up when applying.

Otherwise:

Reviewed-by: Christoph Hellwig <hch at lst.de>
