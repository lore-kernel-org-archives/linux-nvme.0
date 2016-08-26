From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 26 Aug 2016 09:48:39 -0500
Subject: [PATCH WIP/RFC 6/6] nvme-rdma: keep a cm_id around
 during	reconnect to get events
In-Reply-To: <20160826144130.GA21923@lst.de>
References: <cover.1472219585.git.swise@opengridcomputing.com>
 <b1ee02376df44ec240dc0bff956fe055687580f8.1472219586.git.swise@opengridcomputing.com>
 <20160826144130.GA21923@lst.de>
Message-ID: <02d701d1ffa8$ee82c070$cb884150$@opengridcomputing.com>

> 
> On Fri, Aug 26, 2016@06:52:59AM -0700, Steve Wise wrote:
> > This patch adds the concept of an "unplug" cm_id for each nvme_rdma_ctrl
> > controller.  When the controller is first created and the admin qp
> > is connected to the target, the unplug_cm_id is created and address
> > resolution is done on it to bind it to the same device that the admin QP
> > is bound to.   This unplug_cm_id remains across any/all kato recovery and
> > thus will always be available for DEVICE_REMOVAL events.  This simplifies
> > the unplug handler because the cm_id isn't associated with any of the IO
> > queues nor the admin queue.  Plus it ensures a cm_id is always available
> > per controller to get the DEVICE_REMOVAL event.
> 
> I'll need some time to digest all the crazy RDMA/CM interactions here.
> Do you have any clue how other drivers handle this situation?

No.   I'm not sure the other users correctly handle device removal.   There is
another way though:  I sent out a patch earlier using the ib_client interface to
handle this.  ib_clients register with the ib core and provide add and remove
callback functions to handle device insertion/removal.  We could use that here
instead.   But the vision of the RDMA_CM was to provide a transport-independent
way to handle this I guess...
