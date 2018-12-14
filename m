From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 14 Dec 2018 09:47:38 -0700
Subject: [PATCH] nvme-pci: only set nr_maps to 2 if poll queues are
 supported
In-Reply-To: <20181214162019.14847-1-hch@lst.de>
References: <20181214162019.14847-1-hch@lst.de>
Message-ID: <233e6550-efd6-68eb-4b40-3324c34db944@kernel.dk>

On 12/14/18 9:20 AM, Christoph Hellwig wrote:
> The block layer now enables polling support on a queue if nr_maps
> includes the poll map, so we should only set that if we actually
> support poll queues.

Looks good to me. Do you want to carry it? If so:

Reviewed-by: Jens Axboe <axboe at kernel.dk>

or I can take it directly. Let me know.

-- 
Jens Axboe
