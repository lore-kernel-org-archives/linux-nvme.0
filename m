From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Jun 2017 18:51:31 +0300
Subject: [PATCH 4/4] nvme-loop: merge init_request methods
In-Reply-To: <20170613071521.5191-4-hch@lst.de>
References: <20170613071521.5191-1-hch@lst.de>
 <20170613071521.5191-4-hch@lst.de>
Message-ID: <5e33d60c-e62c-e0b8-4116-783e2a59fdfa@mellanox.com>



On 6/13/2017 10:15 AM, Christoph Hellwig wrote:
> Now that we get the tagset passed we can have a single implementation for
> the I/O and admin queues.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/loop.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
