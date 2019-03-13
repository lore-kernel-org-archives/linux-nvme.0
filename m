From: james.smart@broadcom.com (James Smart)
Date: Wed, 13 Mar 2019 11:53:00 -0700
Subject: [PATCH 10/17] nvmet-fc: fix issues with targetport assoc_list
 list walking
In-Reply-To: <20190313175510.20725-11-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
 <20190313175510.20725-11-hch@lst.de>
Message-ID: <73182b96-5113-005a-fb18-7cc126de8b69@broadcom.com>

On 3/13/2019 10:55 AM, Christoph Hellwig wrote:
> From: James Smart <jsmart2021 at gmail.com>
>
> There are two changes:
>
> 1) The logic in the __nvmet_fc_free_assoc() routine is bad. It uses
> "safe" routines assuming pointers will come back valid.  However, the
> intervening next structure being linked can be removed from the list and
> the resulting safe pointers are bad, resulting in NULL ptrs being hit.
>
> Correct by scheduling a work element to perform the association delete,
> which can be done while under lock.
>
> 2) Prior patch that added the work element scheduling left a possible
> reference on the object if the work element couldn't be scheduled.
>
> Correct by doing the put on a failing schedule_work() call.
>
> Signed-off-by: Nigel Kirkland <nigel.kirkland at broadcom.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> Reviewed-by: Ewan D. Milne <emilne at redhat.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/target/fc.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 1e9654f04c60..8d34aa573d5b 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1143,10 +1143,8 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
>   				&tgtport->assoc_list, a_list) {
>   		if (!nvmet_fc_tgt_a_get(assoc))
>   			continue;
> -		spin_unlock_irqrestore(&tgtport->lock, flags);
> -		nvmet_fc_delete_target_assoc(assoc);
> -		nvmet_fc_tgt_a_put(assoc);
> -		spin_lock_irqsave(&tgtport->lock, flags);
> +		if (!schedule_work(&assoc->del_work))
> +			nvmet_fc_tgt_a_put(assoc);
>   	}
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   }
> @@ -1185,7 +1183,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
>   		nvmet_fc_tgtport_put(tgtport);
>   
>   		if (found_ctrl) {
> -			schedule_work(&assoc->del_work);
> +			if (schedule_work(&assoc->del_work))
> +				nvmet_fc_tgt_a_put(assoc);
>   			return;
>   		}
>   
V1 was checked in 
(http://lists.infradead.org/pipermail/linux-nvme/2019-February/022193.html
V2 was skipped 
(http://lists.infradead.org/pipermail/linux-nvme/2019-February/022540.html)

V2 changes the last
+??? ??? ??? if (schedule_work(&assoc->del_work))
to
+??? ??? ??? if (!schedule_work(&assoc->del_work))


Jens - can you do this manual fixup ?

-- james
