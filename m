From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Mon, 31 Oct 2016 15:10:36 +0000
Subject: [PATCH v5 14/14] nvme: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
In-Reply-To: <540193784.5466628.1477921998345.JavaMail.zimbra@redhat.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <fe057bf0-6ede-fc9e-9a53-9d790c9782c2@sandisk.com>
 <540193784.5466628.1477921998345.JavaMail.zimbra@redhat.com>
Message-ID: <1477926635.2511.1.camel@sandisk.com>

On Mon, 2016-10-31@09:53 -0400, Laurence Oberman wrote:
> Applied all 14 patches, also corrected the part of the xen-blkfront.c 
> blkif_recover patch in patchv5-5/14.
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-
> blkfront.c
> index 9908597..60fff99 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2045,6 +2045,7 @@ static int blkif_recover(struct blkfront_info
> *info)
> ?????????????????BUG_ON(req->nr_phys_segments > segs);
> ?????????????????blk_mq_requeue_request(req);
> ?????????}
> +????????blk_mq_start_stopped_hw_queues(infrq,
> true);????????????????????*** Corrected
> ?????????blk_mq_kick_requeue_list(infrq);
> ?
> ?????????while ((bio = bio_list_pop(&infbio_list)) != NULL) {

Hello Laurence,

Sorry for the build failure. The way you changed xen-blkfront is indeed
what I intended. Apparently I forgot to enable Xen in my kernel config
...

Bart.
