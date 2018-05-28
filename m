From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 28 May 2018 16:12:16 +0300
Subject: [PATCH] nvme-pci: simplify __nvme_submit_cmd
In-Reply-To: <20180526114555.8881-1-hch@lst.de>
References: <20180526114555.8881-1-hch@lst.de>
Message-ID: <a41da633-a8ab-9f24-d455-058ae93be311@mellanox.com>



On 5/26/2018 2:45 PM, Christoph Hellwig wrote:
> With recent CQ handling improvements we can now move the locking into
> __nvme_submit_cmd.  Also remove the local tail variable to make the code
> more obvious, remove the __ prefix in the name, and fix the comments
> describing the function.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 37 ++++++++++++++-----------------------
>   1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 79b48052ea11..3fe41b2594a1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
