From: adilger@dilger.ca (Andreas Dilger)
Date: Sat, 30 Mar 2019 11:48:38 -0600
Subject: [PATCH v3 1/7] block: extend stream count for in-kernel use
In-Reply-To: <1553846032-4451-2-git-send-email-joshi.k@samsung.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075743epcas1p12f1d290e65ddf84eb74ed94a5ae6eb74@epcas1p1.samsung.com>
 <1553846032-4451-2-git-send-email-joshi.k@samsung.com>
Message-ID: <FCE37AF6-FAD4-4968-B5DE-64399A8D5C9A@dilger.ca>

On Mar 29, 2019,@1:53 AM, Kanchan Joshi <joshi.k@samsung.com> wrote:
> 
> This patch bumps up stream count to suppor in-kernel hints. It also
> adds 'streamid' member in 'request' and declares new API for driver
> to register stream-info with block layer.
> 
> Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
> ---
> include/linux/blkdev.h | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 338604d..4088e21 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -214,6 +214,7 @@ struct request {
> #endif
> 
> 	unsigned short write_hint;
> +	unsigned short streamid;
> 	unsigned short ioprio;
> 
> 	void *special;		/* opaque pointer available for LLD use */
> @@ -341,6 +342,8 @@ struct queue_limits {
> 	unsigned char		misaligned;
> 	unsigned char		discard_misaligned;
> 	unsigned char		raid_partial_stripes_expensive;
> +
> +	unsigned short		nr_streams;
> 	enum blk_zoned_model	zoned;
> };
> 
> @@ -567,8 +570,9 @@ struct request_queue {
> 	size_t			cmd_size;
> 
> 	struct work_struct	release_work;
> -
> -#define BLK_MAX_WRITE_HINTS	5
> +#define BLK_MAX_USER_HINTS	(WRITE_LIFE_KERN_MIN - 2)
> +#define BLK_MAX_KERN_HINTS	4
> +#define BLK_MAX_WRITE_HINTS	(1 + BLK_MAX_USER_HINTS + BLK_MAX_KERN_HINTS)
> 	u64			write_hints[BLK_MAX_WRITE_HINTS];
> };
> 
> @@ -1071,6 +1075,7 @@ extern void blk_queue_update_dma_alignment(struct request_queue *, int);
> extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
> extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
> extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
> +extern void blk_queue_stream_limits(struct request_queue *, unsigned short);

This declaration should be in the 2/7 patch where the function is added.


Cheers, Andreas





-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 873 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190330/29188d0d/attachment.sig>
