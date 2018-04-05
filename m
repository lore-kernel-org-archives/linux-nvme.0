From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 Apr 2018 16:48:30 -0600
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <20180405224138.GH10098@localhost.localdomain>
References: <5d6d1a8c-6490-4046-0fba-da0a0df3d00c@gmail.com>
 <20180405213847.GG10098@localhost.localdomain>
 <20180405212205.33dqwqck2co25a3x@sbauer-Z170X-UD5>
 <719ea777-e57d-511e-52c5-cf83027d1fd0@gmail.com>
 <20180405224138.GH10098@localhost.localdomain>
Message-ID: <20180405224830.GI10098@localhost.localdomain>

On Thu, Apr 05, 2018@04:41:39PM -0600, Keith Busch wrote:
> I take it this doesn't happen without the MD raid. Could you try with
> the following patch?
> 
> ---
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index bf0b840645cc..d377643b5d06 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -366,7 +366,7 @@ static void dm_complete_request(struct request *rq, blk_status_t error)
>  	if (!rq->q->mq_ops)
>  		blk_complete_request(rq);
>  	else
> -		blk_mq_complete_request(rq);
> +		blk_mq_end_request(rq);
>  }
>  
>  /*
> --

Actually, scratch this for a moment. I don't know this path well enough
to suggest the above.

What I really want is for a failed queue_rq to not call the nvme
driver's softirq_done for that request, and it looks like that may be
happening. I need to stare at this a little longer.
