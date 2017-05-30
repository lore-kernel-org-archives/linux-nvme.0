From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 30 May 2017 18:09:22 +0000
Subject: WARNING triggers at blk_mq_update_nr_hw_queues during
 nvme_reset_work
In-Reply-To: <20170530175549.GC2845@localhost.localdomain>
References: <8760giqnyb.fsf@dilma.collabora.co.uk>
 <20170530175549.GC2845@localhost.localdomain>
Message-ID: <1496167761.2627.22.camel@sandisk.com>

On Tue, 2017-05-30@13:55 -0400, Keith Busch wrote:
> On Tue, May 30, 2017@02:00:44PM -0300, Gabriel Krisman Bertazi wrote:
> > Since the merge window for 4.12, one of the machines in Intel's CI
> > started to hit the WARN_ON below at blk_mq_update_nr_hw_queues during an
> > nvme_reset_work.  The issue persists with the latest 4.12-rc3, and full
> > dmesg from boot, up to the moment where the WARN_ON triggers is
> > available at the following link:
> > 
> > https://intel-gfx-ci.01.org/CI/CI_DRM_2672/fi-kbl-7500u/igt at kms_pipe_crc_basic@suspend-read-crc-pipe-a.html
> > 
> > Please notice that the test we do in the CI involves putting the
> > machine to sleep (PM), and the issue triggers when resuming execution.
> > 
> > I have not been able to get my hands on the machine yet to do an actual
> > bisect, but I'm wondering if you guys might have an idea of what is
> > wrong.
> > 
> > Any help is appreciated :)
> 
> Hi Gabriel,
> 
> This appears to be new behavior in blk-mq's tag set update with commit
> 705cda97e. This is asserting a lock is held, but none of the drivers
> that call the export are take that lock.
> 
> I think the below should fix it (CC'ing block list and developers).
> 
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f2224ffd..1bccced 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2641,7 +2641,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  	return ret;
>  }
>  
> -void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
> +static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> +							int nr_hw_queues)
>  {
>  	struct request_queue *q;
>  
> @@ -2665,6 +2666,13 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_unfreeze_queue(q);
>  }
> +
> +void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
> +{
> +	mutex_lock(&set->tag_list_lock);
> +	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
> +	mutex_unlock(&set->tag_list_lock);
> +}
>  EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);

These changes look fine to me, hence:

Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
