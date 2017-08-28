From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 09:17:44 +0300
Subject: [PATCH 05/10] nvme: don't blindly overwrite identifiers on disk
 revalidate
In-Reply-To: <20170823175815.3646-6-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-6-hch@lst.de>
Message-ID: <e62a9b05-a02a-1846-6339-84c13248c9ce@grimberg.me>

> Instead validate that these identifiers do not change, as that is
> prohibited by the specification.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 157dbb7b328d..179ade01745b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1236,6 +1236,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>   	struct nvme_ns *ns = disk->private_data;
>   	struct nvme_ctrl *ctrl = ns->ctrl;
>   	struct nvme_id_ns *id;
> +	u8 eui64[8] = { 0 }, nguid[16] = { 0 };
> +	uuid_t uuid = uuid_null;
>   	int ret = 0;
>   
>   	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> @@ -1252,7 +1254,15 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>   		goto out;
>   	}
>   
> -	nvme_report_ns_ids(ctrl, ns->ns_id, id, ns->eui, ns->nguid, &ns->uuid);
> +	nvme_report_ns_ids(ctrl, ns->ns_id, id, eui64, nguid, &uuid);
> +	if (!uuid_equal(&ns->uuid, &uuid) ||
> +	    memcmp(&ns->nguid, &nguid, sizeof(ns->nguid)) ||
> +	    memcmp(&ns->eui, &eui64, sizeof(ns->eui))) {

Shouldn't uuid,nguid,eui64 record the previous values prior to calling
nvme_report_ns_ids?
