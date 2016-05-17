From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 May 2016 11:05:11 -0400
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <CAF1ivSaOMqLP=a9KgNy0Gbn9w_KkCzwbuY80e=sCJR+4Vg2kNw@mail.gmail.com>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
 <1461619219-18144-2-git-send-email-mlin@kernel.org>
 <1463295520.5272.4.camel@kernel.org>
 <CAF1ivSaOMqLP=a9KgNy0Gbn9w_KkCzwbuY80e=sCJR+4Vg2kNw@mail.gmail.com>
Message-ID: <20160517150511.GB14260@localhost.localdomain>

On Mon, May 16, 2016@03:38:38PM -0700, Ming Lin wrote:
> On Sat, May 14, 2016@11:58 PM, Ming Lin <mlin@kernel.org> wrote:
> > On Mon, 2016-04-25@14:20 -0700, Ming Lin wrote:
> >>
> >> @@ -1654,8 +1655,8 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
> >>  {
> >>       struct nvme_ns *ns;
> >>
> >> -     mutex_lock(&ctrl->namespaces_mutex);
> >> -     list_for_each_entry(ns, &ctrl->namespaces, list) {
> >> +     rcu_read_lock();
> >> +     list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
> >>               spin_lock_irq(ns->queue->queue_lock);
> >>               queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
> >>               spin_unlock_irq(ns->queue->queue_lock);
> >> @@ -1663,7 +1664,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
> >>               blk_mq_cancel_requeue_work(ns->queue);
> 
> Hi Keith,
> 
> I haven't found a way to fix below bug.
> Could you help me to understand why blk_mq_cancel_requeue_work() here?

We cancel the work because blk_mq_requeue_work starts all the h/w queues,
negating the whole point of the driver request blk-mq stop sending more
commands during a reset.

Today, though, the driver has newer checks so it doesn't crash when
blk-mq submits a command the driver can't handle. If we change the nvme
pci driver's nvme_queue_rq to stop hw queues before returning
BLK_MQ_RQ_QUEUE_BUSY (scsi_queue_rq() in scsi_lib.c might be a good
example), we could skip cancelling requeue work in "nvme_stop_queues()"
if we're sure it won't race with the reset work's nvme_start_queues().
