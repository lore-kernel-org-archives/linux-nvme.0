From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 15 Nov 2015 21:18:34 +0200
Subject: [PATCH 8/8] nvme-loop: add a NVMe loopback device
In-Reply-To: <1446915643-21175-9-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-9-git-send-email-hch@lst.de>
Message-ID: <5648DA8A.6060705@dev.mellanox.co.il>


> +	ctrl->queue_count = 1; /* admin queue */;
> +	if (nr_io_queues > 0)
> +		ctrl->queue_count += nr_io_queues;
> +	else
> +		ctrl->queue_count += num_possible_cpus();

This should really be num_online_cpus(), I get way more than
I need with num_possible_cpus()...
