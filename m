From: hch@lst.de (Christoph Hellwig)
Date: Tue, 11 Dec 2018 08:08:55 +0100
Subject: [PATCH] nvme: fix irq vs io_queue calculations
In-Reply-To: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
References: <0d463400-f954-7588-1ae9-2c68e52e9082@kernel.dk>
Message-ID: <20181211070855.GA13999@lst.de>

> +		if (!(result < 0 || irq_queues == 1))
> +			irq_queues = irq_sets[0] + irq_sets[1] + 1;

Maybe its just me, but I hate this style of conditions, why not:

		if (result >= 0 && irq_queues > 1)
			irq_queues = irq_sets[0] + irq_sets[1] + 1;

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
