From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 14 Dec 2018 08:45:02 -0700
Subject: [PATCH] nvme-pci: only set nr_maps to 2 if poll queues are
 supported
In-Reply-To: <20181214154233.14354-1-hch@lst.de>
References: <20181214154233.14354-1-hch@lst.de>
Message-ID: <1aeb230f-a292-f824-71b6-d17fb754504e@kernel.dk>

On 12/14/18 8:42 AM, Christoph Hellwig wrote:
> The block layer now enables polling support on a queue if nr_maps
> includes the poll map, so we should only set that if we actually
> support poll queues.

Looks good to me, but needs a Fixes line.

-- 
Jens Axboe
