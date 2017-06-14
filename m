From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Jun 2017 18:40:43 +0300
Subject: [PATCH 3/4] nvme-fc: merge init_request methods
In-Reply-To: <20170613071521.5191-3-hch@lst.de>
References: <20170613071521.5191-1-hch@lst.de>
 <20170613071521.5191-3-hch@lst.de>
Message-ID: <41be21d5-41cd-eee1-1612-37f287122884@mellanox.com>



On 6/13/2017 10:15 AM, Christoph Hellwig wrote:
> Now that we get the tagset passed we can have a single implementation for
> the I/O and admin queues.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/fc.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
