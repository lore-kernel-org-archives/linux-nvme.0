From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 19:49:50 +0300
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <20170615163502.10548-7-hch@lst.de>
References: <20170615163502.10548-1-hch@lst.de>
 <20170615163502.10548-7-hch@lst.de>
Message-ID: <d1fe0701-6667-512e-59af-f2339ca1e52d@grimberg.me>

Christoph,

> Verify that our IDs match for shared namespaces in a subystem, and link
> them up in a headless queue so that we can find siblings easily.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 57e48d893173..a67a850ef7db 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2249,6 +2249,89 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	return ret;
>   }
>   
> +static int nvme_ns_link_siblings(struct nvme_ns *ns, struct nvme_id_ns *id,
> +		struct nvme_ns *cur)
> +{

The fact that this can also not link sibling makes me think that
the name is a bit confusing. I'm wandering if it would be a good
idea to split the id check (and comparison) and the actual link
itself?
