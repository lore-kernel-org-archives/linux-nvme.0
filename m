From: hare@suse.de (Hannes Reinecke)
Date: Thu, 1 Aug 2019 09:24:53 +0200
Subject: [PATCH rfc 2/2] nvme: fix possible use-after-free condition when
 controller reset is racing namespace scanning
In-Reply-To: <fb6c9d38-32f6-a659-f3b9-1c57f28b410d@grimberg.me>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-3-sagi@grimberg.me>
 <e3b0f11f-a66f-9b1a-6790-89efcaa33140@suse.de>
 <fb6c9d38-32f6-a659-f3b9-1c57f28b410d@grimberg.me>
Message-ID: <b6b929e7-3da5-f274-f7c8-4e98f8585917@suse.de>

On 7/31/19 8:21 PM, Sagi Grimberg wrote:
> 
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 5f6970e7ba73..9f8f8f5feeae 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3406,6 +3406,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>> ????? synchronize_rcu(); /* guarantee not available in head->list */
>>> ????? nvme_mpath_clear_current_path(ns);
>>> ????? synchronize_srcu(&ns->head->srcu); /* wait for concurrent
>>> submissions */
>>> +??? nvme_mpath_check_last_path(ns);
>>> +
>>> +??? down_write(&ns->ctrl->namespaces_rwsem);
>>> +??? list_del_init(&ns->list);
>>> +??? up_write(&ns->ctrl->namespaces_rwsem);
>>> ? ????? if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
>>> ????????? del_gendisk(ns->disk);
>>> @@ -3414,11 +3419,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>> ????????????? blk_integrity_unregister(ns->disk);
>>> ????? }
>>> ? -??? down_write(&ns->ctrl->namespaces_rwsem);
>>> -??? list_del_init(&ns->list);
>>> -??? up_write(&ns->ctrl->namespaces_rwsem);
>>> -
>>> -??? nvme_mpath_check_last_path(ns);
>>> ????? nvme_put_ns(ns);
>>> ? }
>>> ?
>> How does this one play with nvme_stop_queues()/nvme_start_queues() we're
>> doing during reset?
>> IE what happens if this is called after nvme_stop_queues(), but before
>> nvme_start_queues()?
>> We'll end up having a stopped queue when deleting the disk; from what
>> I've seen blk_cleanup_queue() will just freeze the queue and wait for
>> I/O to complete, which it'll never will as the queue is stopped ...
> 
> nvme_stop/start_queue are quiescing the queue, not freezing it which
> does not block requests in blk_queue_enter.
> So I don't think that blk_cleanup_queue will hang for unquiesced queues.

My worry here is for quiesced queues; they are not unquiesced when
blk_clean_queue() is running. So I'm not sure if we're able to flush all
commands then.

But be it as it may, I've sent a patchset for checking the NS_REMOVING
flag when traversing the namespace list. That should take care of this
issue, and should render this patch obsolete.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
