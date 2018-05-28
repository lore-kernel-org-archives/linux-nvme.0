From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:25:20 +0200
Subject: [PATCH 09/17] nvme: reduce the metadata size in case the ctrl
 doesn't support it
In-Reply-To: <1527436222-15494-10-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-10-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072520.GH5618@lst.de>

On Sun, May 27, 2018@06:50:14PM +0300, Max Gurtovoy wrote:
> There is no reason for setting metadata size while the controller is
> not capable to perform command with metadata.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  drivers/nvme/host/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e81e898..1830978 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1461,6 +1461,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  		}
>  	}
>  
> +	/* Reduce the metadata size in case the ctrl doesn't support it */
> +	if (!ns->ctrl->max_integrity_segments)
> +		ns->ms = 0;

You already had the reduce wording in a previous patch, and I think it
is rather confusing.  By setting ns->ms to 0 you do not reduce the size,
but you disable metadata, so it should reflect that.
