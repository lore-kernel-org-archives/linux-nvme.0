From: james.smart@broadcom.com (James Smart)
Date: Wed, 25 Jan 2017 09:14:54 -0800
Subject: [PATCH] nvme-fc: use blk_rq_nr_phys_segments
In-Reply-To: <1484841357-17539-1-git-send-email-hch@lst.de>
References: <1484841357-17539-1-git-send-email-hch@lst.de>
Message-ID: <3e53c830-d3ea-373a-cffe-597a2f6a76e7@broadcom.com>

On 1/19/2017 7:55 AM, Christoph Hellwig wrote:
> Without this deallocate won't work properly due to the mismatch
> of the bio/request size and the actual payload size.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   

looks fine to me.

Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
