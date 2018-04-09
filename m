From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 9 Apr 2018 19:58:48 +0300
Subject: [PATCH] nvme: avoid flush dependency in delete controller flow
In-Reply-To: <20180409164808.GK3948@linux.vnet.ibm.com>
References: <20180409065007.GA7760@lst.de>
 <1523285426-26526-1-git-send-email-nitzanc@mellanox.com>
 <20180409164808.GK3948@linux.vnet.ibm.com>
Message-ID: <c43ce416-244d-808d-bbf9-5e6b28674eb0@mellanox.com>



On 4/9/2018 7:48 PM, Paul E. McKenney wrote:
> On Mon, Apr 09, 2018@05:50:26PM +0300, Nitzan Carmi wrote:
>> nvme_delete_ctrl queues a work on a MEM_RECLAIM queue
>> (nvme_delete_wq), which eventually calls cleanup_srcu_struct,
>> which in turn flushes a delayed work from an !MEM_RECLAIM
>> queue. This is unsafe as we might trigger deadlocks under
>> severe memory pressure.
>>
>> Since we don't ever invoke call_srcu(), it is safe
>> to use the _quiesced() version of srcu cleanup, and
>> avoid that flush dependency.
>>
>> Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
> 
> Very good, thank you!
> 
> I queued this with a few edits to the commit log (please see below),
> so please let me know if I messed anything up.
> 
> Given that it only happens under high memory pressure, I am assuming
> that sending this up the v4.18 merge window (not this one, but the next
> one) will work.  Please let me know if this is more urgent than that.
> (If it is not more urgent, I would like to allow the extra time for
> people to get used to yet another addition to the SRCU API.)

I guess we can wait to v4.18 but not sure we actually need to wait that 
long, Christoph ?

> 
> ------------------------------------------------------------------------
> 
> commit 6fde861519fc6e4be50c130272be556ef5656324
> Author: Nitzan Carmi <nitzanc at mellanox.com>
> Date:   Mon Apr 9 17:50:26 2018 +0300
> 
>      nvme: Avoid flush dependency in delete controller flow
>      
>      The nvme_delete_ctrl() function queues a work item on a MEM_RECLAIM
>      queue (nvme_delete_wq), which eventually calls cleanup_srcu_struct(),
>      which in turn flushes a delayed work from an !MEM_RECLAIM queue. This
>      is unsafe as we might trigger deadlocks under severe memory pressure.
>      
>      Since we don't ever invoke call_srcu(), it is safe to use the shiny new
>      _quiesced() version of srcu cleanup, thus avoiding that flush dependency.
>      This commit makes that change.
>      
>      Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
>      Signed-off-by: Paul E. McKenney <paulmck at linux.vnet.ibm.com>
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7aeca5db7916..40008d06c365 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -351,7 +351,7 @@ static void nvme_free_ns_head(struct kref *ref)
>   	nvme_mpath_remove_disk(head);
>   	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>   	list_del_init(&head->entry);
> -	cleanup_srcu_struct(&head->srcu);
> +	cleanup_srcu_struct_quiesced(&head->srcu);
>   	kfree(head);
>   }
>   
> 

Looks good, thanks Nitzan and Paul.
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7Cd1344fa628dc47e8a5f308d59e399a13%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636588892600812825&sdata=HTf3qkTyLUzE24yXG16UF%2BHVoA5OjykV6naG6o7M7M0%3D&reserved=0
> 
