From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Oct 2015 21:19:23 +0000 (UTC)
Subject: [PATCH 2/8] nvme: use the block layer for userspace passthrough
 metadata
In-Reply-To: <1444633811-28319-3-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
 <1444633811-28319-3-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510142038370.27742@localhost.lm.intel.com>

On Mon, 12 Oct 2015, Christoph Hellwig wrote:
> @@ -94,26 +97,76 @@ int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
> +			bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
> +			if (!bip) {
> +				ret = -ENOMEM;
> +				goto out_free_meta;
> +			}
> +
> +			bip->bip_iter.bi_size = meta_len;
> +			bip->bip_iter.bi_sector = meta_seed;
> +
> +			ret = bio_integrity_add_page(bio, virt_to_page(meta),
> +					meta_len, offset_in_page(meta));
> +			if (ret != meta_len) {
> +				ret = -ENOMEM;
> +				goto out_free_meta;
> +			}
> +		}

We need to set REQ_INTEGRITY in req->cmd_flags here since requests
submitted through blk_execute_rq don't copy the bio flags.

> 	}
>
> 	blk_execute_rq(req->q, NULL, req, 0);

And need to provide the gendisk instead of NULL so the nvme_map_data()
-> nvme_dif_remap() doesn't dereference NULL to get the namespace's PI
type; there are other ways to get to this, but setting the disk here
looks the simplist from: ((struct nvme_ns *)q->queuedata)->disk;

Similarly, we need to set bio->bi_bdev to 'bdev_get(ns->disk, 0)' to
fix a NULL pointer in bio_integrity_advance in the completion path.


Other than this and the other two issues I mentioned, the rest of
the series has gone very well. Considering the size of this plus the
"queue_rq updates", that's pretty darn awesome!
