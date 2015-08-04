From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 4 Aug 2015 14:05:59 -0400
Subject: [PATCH 5/6] dm: split out a helper to find the ioctl target
In-Reply-To: <1438672271-11309-6-git-send-email-hch@lst.de>
References: <1438672271-11309-1-git-send-email-hch@lst.de>
 <1438672271-11309-6-git-send-email-hch@lst.de>
Message-ID: <20150804180558.GB28971@redhat.com>

On Tue, Aug 04 2015 at  3:11am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> We want to reuse this code for the persistent reservation handling,
> so move it into a helper.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/md/dm.c | 50 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index c68eb91..8dfc760 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -556,18 +556,16 @@ static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>  	return dm_get_geometry(md, geo);
>  }
>  
> -static int dm_blk_ioctl(struct block_device *bdev, fmode_t mode,
> -			unsigned int cmd, unsigned long arg)
> +static int dm_get_ioctl_table(struct mapped_device *md,
> +		struct dm_target **tgt, struct block_device **bdev,
> +		fmode_t *mode, int *srcu_idx)

Would prefer to see something like:

static int dm_get_live_table_for_ioctl(struct mapped_device *md, int *srcu_idx,
	     struct dm_target **tgt, struct block_device **bdev, fmode_t *mode)

Otherwise, looks good.
