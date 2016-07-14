From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 14 Jul 2016 16:27:27 -0500
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
 nvme_rdma_free_ctrl
In-Reply-To: <014a01d1dde4$10663230$31329690$@opengridcomputing.com>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
 <1468445196-6915-3-git-send-email-mlin@kernel.org>
 <57875835.5050001@grimberg.me>
 <011301d1dde0$4450e4e0$ccf2aea0$@opengridcomputing.com>
 <011c01d1dde0$cc2f74d0$648e5e70$@opengridcomputing.com>
 <014a01d1dde4$10663230$31329690$@opengridcomputing.com>
Message-ID: <03c001d1de16$856e7330$904b5990$@opengridcomputing.com>

> > > > This patch introduces asymmetry between create and destroy
> > > > of the admin queue. Does this alternative patch solve
> > > > the problem?
> > > >
> > > > The patch changes the order of device removal flow from:
> > > > 1. delete controller
> > > > 2. destroy queue
> > > >
> > > > to:
> > > > 1. destroy queue
> > > > 2. delete controller
> > > >
> > > > Or more specifically:
> > > > 1. own the controller deletion (make sure we are not
> > > > competing with anyone)
> > > > 2. get rid of inflight reconnects (which also destroy and
> > > > create queues)
> > > > 3. destroy the queue
> > > > 4. safely queue controller deletion
> > > >
> > > > Thoughts?
> > > >
> > >
> > > Your patch causes a deadlock during device removal.
> > >
> > > The controller delete work thread is stuck in c4iw_destroy_qp waiting on
> > > all references to go away.  Either nvmf/rdma or the rdma-cm or both.
> > >
> > > (gdb) list *c4iw_destroy_qp+0x155
> > > 0x15af5 is in c4iw_destroy_qp (drivers/infiniband/hw/cxgb4/qp.c:1596).
> > > 1591                    c4iw_modify_qp(rhp, qhp, C4IW_QP_ATTR_NEXT_STATE,
> > > &attrs, 0);
> > > 1592            wait_event(qhp->wait, !qhp->ep);
> > > 1593
> > > 1594            remove_handle(rhp, &rhp->qpidr, qhp->wq.sq.qid);
> > > 1595            atomic_dec(&qhp->refcnt);
> > > 1596            wait_event(qhp->wait, !atomic_read(&qhp->refcnt));
> > > 1597
> > > 1598            spin_lock_irq(&rhp->lock);
> > > 1599            if (!list_empty(&qhp->db_fc_entry))
> > > 1600                    list_del_init(&qhp->db_fc_entry);
> > >
> > > The rdma-cm work thread is stuck trying to grab the cm_id mutex:
> > >
> > > (gdb) list *cma_disable_callback+0x2e
> > > 0x29e is in cma_disable_callback (drivers/infiniband/core/cma.c:715).
> > > 710
> > > 711     static int cma_disable_callback(struct rdma_id_private *id_priv,
> > > 712                                     enum rdma_cm_state state)
> > > 713     {
> > > 714             mutex_lock(&id_priv->handler_mutex);
> > > 715             if (id_priv->state != state) {
> > > 716                     mutex_unlock(&id_priv->handler_mutex);
> > > 717                     return -EINVAL;
> > > 718             }
> > > 719             return 0;
> > >
> > > And the nvmf cm event handler is stuck waiting for the controller delete
> > > to finish:
> > >
> > > (gdb) list *nvme_rdma_device_unplug+0x97
> > > 0x1027 is in nvme_rdma_device_unplug (drivers/nvme/host/rdma.c:1358).
> > > warning: Source file is more recent than executable.
> > > 1353    queue_delete:
> > > 1354            /* queue controller deletion */
> > > 1355            queue_work(nvme_rdma_wq, &ctrl->delete_work);
> > > 1356            flush_work(&ctrl->delete_work);
> > > 1357            return ret;
> > > 1358    }
> > > 1359
> > > 1360    static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
> > > 1361                    struct rdma_cm_event *ev)
> > > 1362    {
> > >
> > > Seems like the rdma-cm work thread is trying to grab the cm_id lock for
> > > the cm_id that is handling the DEVICE_REMOVAL event.
> > >
> >
> > And, the nvmf/rdma delete controller work thread is trying to delete the
cm_id
> > that received the DEVICE_REMOVAL event, which is the crux o' the biscuit,
> > methinks...
> >
> 
> Correction: the del controller work thread is trying to destroy the qp
> associated with the cm_id.  But the point is this cm_id/qp should NOT be
touched
> by the del controller thread because the unplug thread should have cleared the
> Q_CONNECTED bit and thus took ownership of destroy it.  I'll add some debug
> prints to see which path is being taken by nvme_rdma_device_unplug().
> 

After further debug, the del controller work thread is not trying to destroy the
qp/cm_id that received the event.  That qp/cm_id is successfully deleted by the
unplug thread.  However the first cm_id/qp that is destroyed by the del
controller work thread gets stuck in c4iw_destroy_qp() due to the deadlock.   So
I need to understand more about the deadlock...

Steve.
