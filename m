From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 14 Jul 2016 10:09:06 -0700
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
 nvme_rdma_free_ctrl
In-Reply-To: <1468478346.28573.1.camel@kernel.org>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
 <1468445196-6915-3-git-send-email-mlin@kernel.org>
 <1468451986.4105.3.camel@linux.intel.com>
 <CAF1ivSZfcnS7Hte6dKiNBerxzt9QHPHddDNyJiEe_MSfUpfLZg@mail.gmail.com>
 <1468454377.4105.18.camel@linux.intel.com>
 <1468478346.28573.1.camel@kernel.org>
Message-ID: <1468516146.4105.41.camel@linux.intel.com>

On Wed, 2016-07-13@23:39 -0700, Ming Lin wrote:
> On Wed, 2016-07-13@16:59 -0700, J Freyensee wrote:
> > On Wed, 2016-07-13@16:36 -0700, Ming Lin wrote:
> > > On Wed, Jul 13, 2016 at 4:19 PM, J Freyensee
> > > <james_p_freyensee@linux.intel.com> wrote:
> > > > 
> > > > >  static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
> > > > > @@ -687,6 +684,10 @@ static void nvme_rdma_free_ctrl(struct
> > > > > nvme_ctrl
> > > > > *nctrl)
> > > > >       list_del(&ctrl->list);
> > > > >       mutex_unlock(&nvme_rdma_ctrl_mutex);
> > > > > 
> > > > > +     blk_cleanup_queue(ctrl->ctrl.admin_q);
> > > > > +     blk_mq_free_tag_set(&ctrl->admin_tag_set);
> > > > > +     nvme_rdma_dev_put(ctrl->device);
> > > > > +
> > > > >       if (ctrl->ctrl.tagset) {
> > > > >               blk_cleanup_queue(ctrl->ctrl.connect_q);
> > > > >               blk_mq_free_tag_set(&ctrl->tag_set);
> > > > 
> > > > This patch does not remove the second
> > > > 
> > > > nvme_rdma_dev_put(ctrl->device);
> > > > 
> > > > call that happens within the if() statement above if it
> > > > evaluates
> > > > to
> > > > TRUE.  Should that have been removed or moved elsewhere?
> > > 
> > > Not sure I understand your question.
> > > Did you mean line 694?
> > 
> > Yes I mean line 694.
> > 
> > > 
> > > For discovery controller, there is no IO queues. So ctrl-
> > > > ctrl.tagset
> > > is NULL.
> > > 
> > > The first bulk of
> > > "blk_cleanup_queue/blk_mq_free_tag_set/nvme_rdma_dev_put" is for
> > > admin
> > > queue.
> > > And the second is for IO queues.
> > 
> > I'm just confused when nvme_free_ctrl() in core.c calls:
> > 
> > ctrl->ops->free_ctrl(ctrl);
> > 
> > which looks like would be the only call that would free both the
> > admin
> > and I/O rdma queues, why there would be the potential to do a
> > _put()
> > twice in nvme_rdma_free_ctrl() via:
> > 
> > nvme_rdma_dev_put(ctrl->device);
> > 
> > one for the admin section:
> > 
> > 687         blk_cleanup_queue(ctrl>ctrl.admin_q);
> > 688         blk_mq_free_tag_set(&ctrl->admin_tag_set);
> > 689         nvme_rdma_dev_put(ctrl->device);
> 
> This put paired with the get in nvme_rdma_configure_admin_queue()
> 
> > 
> > and one for the I/O section (assuming "if (ctrl->ctrl.tagset)"
> > evaluate
> > s to TRUE in that call):
> > 
> > 691         if (ctrl->ctrl.tagset) {
> > 692                 blk_cleanup_queue(ctrl->ctrl.connect_q);
> > 693                 blk_mq_free_tag_set(&ctrl->tag_set);
> > 694                 nvme_rdma_dev_put(ctrl->device);
> 
> This put paired with the get in nvme_rdma_create_io_queues()
> 
> > 695         }
> > 
> > 
> > My assumption would be that the correct path for this case would be
> > such that 
> > 
> > nvme_rdma_dev_put(ctrl->device); 
> > 
> > would only be called one time, for a single device.
> 
> As above, need put for each get.

OK, thanks for the clarification on this.

Would it then be worth to have an if() check around the new admin
logic, as the assumption with the added code is it will always need to
free the admin_queue when called, something like:

if (ctrl->admin_tag_set) {
	blk_cleanup_queue(ctrl->ctrl.admin_q);
	blk_mq_free_tag_set(&ctrl->admin_tag_set);
	nvme_rdma_dev_put(ctrl->device); 
}

blk_mq_free_tag_set() does assume its parameter is not NULL.



> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
