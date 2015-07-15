From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 15 Jul 2015 09:28:23 -0600
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <1436966356-8979-4-git-send-email-sagig@mellanox.com>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-4-git-send-email-sagig@mellanox.com>
Message-ID: <55A67C17.4080706@kernel.dk>

On 07/15/2015 07:19 AM, Sagi Grimberg wrote:
> This is only theoretical at the moment given that the only
> subsystems that generate integrity payloads are the block layer
> itself and the scsi target. But when we will expose integrity
> meta-data to user-space, we'll need to refuse appending a page
> with a gap when QUEUE_FLAG_SG_GAPS flag is on.
>
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
> ---
>   block/bio-integrity.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 5cbd5d9..a18edb8 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -140,6 +140,15 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
>
>   	iv = bip->bip_vec + bip->bip_vcnt;
>
> +	if (bip->bip_vcnt) {
> +		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> +		struct bio_vec *iv_prev = &bip->bip_vec[bip->bip_vcnt - 1];
> +
> +		if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) &&
> +		    bvec_gap_to_prev(iv_prev, offset))
> +			return 0;
> +	}

This chunk of code largely ends up being duplicated in several places 
with your patches, might be a good idea to pull that into a helper 
function. Then you can add the comment in one place as well :-)

-- 
Jens Axboe
