From: hare@suse.de (Hannes Reinecke)
Date: Fri, 22 Mar 2019 22:14:11 +0100
Subject: [PATCH] nvme: schedule requeue whenever a LIVE state is entered
In-Reply-To: <8fa7e09f-3621-f37b-9830-64377ce8cfd6@grimberg.me>
References: <20190321141033.131308-1-hare@suse.de>
 <da58a1e4-14cd-2587-6350-dccabb6632f1@grimberg.me>
 <0ccee425-93bb-ad04-5b20-f8a792f1aafa@suse.com>
 <8fa7e09f-3621-f37b-9830-64377ce8cfd6@grimberg.me>
Message-ID: <e03e9ab7-8973-097e-6ffb-60eec0ab47e5@suse.de>

On 3/22/19 7:57 PM, Sagi Grimberg wrote:
>>>> When undergoing state transitions I/O might be requeued, hence
>>>> we always have to schedule requeue_work whenever the nvme device
>>>> is live, independent on whether the old state was live or not.
>>>
>>> Any reason why not simply update from live to live?
>>>
>> ?
>>
>> I somewhat fail to parse the answer.
>> Care to elaborate?
> 
> -- 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2839bb70badf..f0716f6ce41f 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -404,15 +404,12 @@ static inline bool nvme_state_is_live(enum 
> nvme_ana_state state)
>  ?static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>  ??????????????? struct nvme_ns *ns)
>  ?{
> -?????? enum nvme_ana_state old;
> -
>  ??????? mutex_lock(&ns->head->lock);
> -?????? old = ns->ana_state;
>  ??????? ns->ana_grpid = le32_to_cpu(desc->grpid);
>  ??????? ns->ana_state = desc->state;
>  ??????? clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
> 
> -?????? if (nvme_state_is_live(ns->ana_state) && !nvme_state_is_live(old))
> +?????? if (nvme_state_is_live(ns->ana_state))
>  ??????????????? nvme_mpath_set_live(ns);
>  ??????? mutex_unlock(&ns->head->lock);
>  ?}
> -- 
That's what we tried initially (cf thread "[PATCH] nvme-multipath: relax 
ANA state check"), but got rejected by Christoph.

Cheers,

Hannes
