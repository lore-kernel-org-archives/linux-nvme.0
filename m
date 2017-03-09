From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 9 Mar 2017 16:30:54 +0000
Subject: [PATCH rfc 06/10] IB/cq: Don't force IB_POLL_DIRECT poll
 context for ib_process_cq_direct
In-Reply-To: <1489065402-14757-7-git-send-email-sagi@grimberg.me>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
 <1489065402-14757-7-git-send-email-sagi@grimberg.me>
Message-ID: <1489077040.2597.3.camel@sandisk.com>

On Thu, 2017-03-09@15:16 +0200, Sagi Grimberg wrote:
> polling the completion queue directly does not interfere
> with the existing polling logic, hence drop the requirement.
> 
> This can be used for polling mode ULPs.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/infiniband/core/cq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 21d1a38af489..7f6ae0ecb0c5 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -64,8 +64,6 @@ static int __ib_process_cq(struct ib_cq *cq, int budget)
>   */
>  int ib_process_cq_direct(struct ib_cq *cq, int budget)
>  {
> -	WARN_ON_ONCE(cq->poll_ctx != IB_POLL_DIRECT);
> -
>  	return __ib_process_cq(cq, budget);
>  }
>  EXPORT_SYMBOL(ib_process_cq_direct);

Using ib_process_cq_direct() for queues that have another type than
IB_POLL_DIRECT may trigger concurrent CQ processing. Before this patch
the completions from each CQ were processed sequentially. That's a big
change so I think this should be mentioned clearly in the header above
ib_process_cq_direct().

Bart.
