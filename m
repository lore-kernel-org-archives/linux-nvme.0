From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 18 Mar 2019 10:20:35 -0700
Subject: [PATCH 6/8] skd: use blk_mq_queue_tag_busy_iter
In-Reply-To: <1552640264-26101-7-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-7-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1552929635.152266.30.camel@acm.org>

On Fri, 2019-03-15@16:57 +0800, Jianchao Wang wrote:
> blk_mq_tagset_busy_iter is not safe that it could get stale request
> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
>  drivers/block/skd_main.c | 4 ?????????(), 2 deletions(-)
> 
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> index ab893a7..60c34ff 100644
> --- a/drivers/block/skd_main.c
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> index ab893a7..60c34ff 100644
> --- a/drivers/block/skd_main.c
> +++ b/drivers/block/skd_main.c
> @@ -395,7 +395,7 @@ static int skd_in_flight(struct skd_device *skdev)
>  {
>         int count = 0;
>  
> -       blk_mq_tagset_busy_iter(&skdev->tag_set, skd_inc_in_flight, &count);
> +       blk_mq_queue_tag_busy_iter(skdev->queue, skd_inc_in_flight, &count, true);
>  
>         return count;
>  }

Hi Jianchao,

If you have a look at the skd_in_flight() callers you will see that the above
change is not necessary.

> @@ -1916,7 +1916,7 @@ static bool skd_recover_request(struct request *req, void *data, bool reserved)
>  
>  static void skd_recover_requests(struct skd_device *skdev)
>  {
> -	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_recover_request, skdev);
> +	blk_mq_queue_tag_busy_iter(skdev->queue, skd_recover_request, skdev, true);
>  }

Same comment here. If you have a look at the callers of this function you will
see that this change is not necessary.

Thanks,

Bart.
