From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 28 Mar 2019 19:07:11 +0800
Subject: [PATCH 2/3] nvme: shorten race window in nvme_ns_remove()
In-Reply-To: <7c112deb-e8c3-eeca-7bda-771c793cb9c6@suse.de>
References: <20190327080929.27918-1-hare@suse.de>
 <20190327080929.27918-3-hare@suse.de>
 <20190327142044.GB8448@localhost.localdomain>
 <7c724e84-519e-e0f9-f82d-31a89ec37680@suse.com>
 <9500d83c-c5da-d87c-c5ef-d67e2c9f8898@broadcom.com>
 <7c112deb-e8c3-eeca-7bda-771c793cb9c6@suse.de>
Message-ID: <CACVXFVM0SW1CMzJRr2HwSvfbYYwR19eR_whxYjn+GiYgZOQb5g@mail.gmail.com>

On Thu, Mar 28, 2019@5:28 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 3/27/19 7:50 PM, James Smart wrote:
> > On 3/27/2019 8:12 AM, Hannes Reinecke wrote:
> >> On 3/27/19 3:20 PM, Keith Busch wrote:
> >>> On Wed, Mar 27, 2019@01:09:28AM -0700, Hannes Reinecke wrote:
> >>>> @@ -3316,6 +3316,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> >>>>       if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
> >>>>           return;
> >>>>   +    down_write(&ns->ctrl->namespaces_rwsem);
> >>>> +    list_del_init(&ns->list);
> >>>> +    up_write(&ns->ctrl->namespaces_rwsem);
> >>>> +
> >>>>       nvme_fault_inject_fini(ns);
> >>>>       if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
> >>>>           del_gendisk(ns->disk);
> >>>
> >>> I think I understand the problem you've described, but I'm a little
> >>> concerned with the early removal. This will call blk_cleanup_queue
> >>> after the namespace is removed from our lists, and that does a blocking
> >>> queue_freeze. If commands happen to be dispatched to that namespace,
> >>> and the controller for some reason stops responding, we may not be able
> >>> to recover during reset when the namespace queue is removed from the
> >>> controller list. That's at least problematic if we have to go with the
> >>> per-queue tag iterators that Jianchao proposed.
> >>>
> >> Hmm. I sort of see where you coming from.
> >> But I was slightly worried about all the other callers where we iterate
> >> the namespace list; one would need to to a _really_ careful audit
> >> which are safe to traverse even with namespace removal running; some
> >> have to, others must not, and some simply don't care.
> >> Hence this approach to make things easier.
> >
> > I like and agree with Hannes's later points.
> >
> > But, Keiths statements make me nervous. With Hannes's patches, I could
> > easily see the case where the ns->queue was quiesced when ns_remove is
> > called, which I think causes issues with blk_freeze_queue. We would need
> > to have ns_remove, after unlinking, to release the queue. is this right ?
> >
> Hmm. But maybe it's as simple as this:
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4e5ad111b68b..67451e5eec31 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -131,6 +131,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>   {
>          if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>                  return -EBUSY;
> +       flush_work(&ctrl->scan_work);
>          if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
>                  return -EBUSY;
>

This way might cause deadlock because there is sync IO in scan
work context.

thanks,
Ming
