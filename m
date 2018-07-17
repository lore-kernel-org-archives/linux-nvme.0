From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 17 Jul 2018 08:06:40 -0600
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <20180717012301.GB22593@ming.t460p>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-4-keith.busch@intel.com>
 <20180716110903.GC25386@ming.t460p>
 <20180716133640.GC19967@localhost.localdomain>
 <20180717012301.GB22593@ming.t460p>
Message-ID: <20180717140639.GB26925@localhost.localdomain>

On Tue, Jul 17, 2018@09:23:03AM +0800, Ming Lei wrote:
> On Mon, Jul 16, 2018@07:36:40AM -0600, Keith Busch wrote:
> > On Mon, Jul 16, 2018@07:09:04PM +0800, Ming Lei wrote:
> > > On Fri, Jul 13, 2018@02:56:08PM -0600, Keith Busch wrote:
> > > > +	if (ctrl->state == NVME_CTRL_FROZEN) {
> > > > +		nvme_wait_freeze(ctrl);
> > > > +		blk_mq_update_nr_hw_queues(ctrl->tagset, ctrl->queue_count - 1);
> > > > +		nvme_unfreeze(ctrl);
> > > > +		if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> > > > +			return;
> > > > +	}
> > > > +
> > > 
> > > Now you move unfreezing into start work function, seems this way can't
> > > guarantee that nvme_unfreeze() is strictly paired with nvme_start_freeze() done
> > > in nvme_dev_disable().
> > 
> > The state machine is supposed to guarantee this. We only start freeze
> > in certain states from nvme_dev_disable, and transition to frozen when
> > exiting those states. I agree it's not the easiest API to follow, and
> > I'll double check to see if it's correct. I think I have the
> > reset/connecting/frozen/live transitions okay for nvme-pci, but I need
> > to look again at the deleting/dead states.
> 
> I am afraid that may not work well wrt. reset vs. timeout because
> timeout still may happen during reset on admin queue, and nvme_dev_disable()
> may call nvme_start_freeze() one more time, meantime reset_work won't be
> scheduled.

The scenario you're describing is going to kill and drain the queues, so
it doesn't matter.
