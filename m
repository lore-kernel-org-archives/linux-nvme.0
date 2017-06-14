From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Jun 2017 18:39:05 +0300
Subject: [PATCH 2/4] nvme-rdma: merge init_request and exit_request methods
In-Reply-To: <20170613071521.5191-2-hch@lst.de>
References: <20170613071521.5191-1-hch@lst.de>
 <20170613071521.5191-2-hch@lst.de>
Message-ID: <58ae7743-a4ff-3371-5df1-caf2f4f80f35@mellanox.com>



On 6/13/2017 10:15 AM, Christoph Hellwig wrote:
> Now that we get the tagset passed we can have a single implementation for
> the I/O and admin queues.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/rdma.c | 43 +++++++++++--------------------------------
>  1 file changed, 11 insertions(+), 32 deletions(-)
>

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
