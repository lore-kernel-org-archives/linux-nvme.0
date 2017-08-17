From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 17 Aug 2017 18:46:56 +0300
Subject: [PATCH] nvme-fabrics: fix reporting of unrecognized options
In-Reply-To: <20170817115934.3999-1-hch@lst.de>
References: <20170817115934.3999-1-hch@lst.de>
Message-ID: <bd606f89-72a1-ecb6-6e67-7770624ec460@mellanox.com>



On 8/17/2017 2:59 PM, Christoph Hellwig wrote:
> Only print the specified options that are not recognized, instead
> of the whole list of options.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/fabrics.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
