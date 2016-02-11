From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 15:07:25 +0000
Subject: [PATCH for-4.5 11/13] NVMe: Dead namespace handling
In-Reply-To: <56BC859C.6030206@dev.mellanox.co.il>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-12-git-send-email-keith.busch@intel.com>
 <56BC859C.6030206@dev.mellanox.co.il>
Message-ID: <20160211150724.GB11908@localhost.localdomain>

On Thu, Feb 11, 2016@02:59:08PM +0200, Sagi Grimberg wrote:
> >This adds a "dead" state to a namespace and revalidates such a namespace
> >to 0 capacity. This will force buffered writers to stop writing pages
> >that can't be synced, and ends requests in failure if any is submitted
> >to such a namespace.
> 
> This sorta going towards a namespace state machine (like scsi). Maybe
> we need to centralize it correctly instead of adding states that are
> relevant is sporadic areas?

Yeah, we need to borrow the better ideas from scsi. Slowly moving to a
state machine.
 
> >  	if (unlikely(nvmeq->cq_vector < 0)) {
> >-		ret = BLK_MQ_RQ_QUEUE_BUSY;
> >+		ret = test_bit(NVME_NS_DEAD, &ns->flags) ?
> >+					BLK_MQ_RQ_QUEUE_ERROR :
> >+					BLK_MQ_RQ_QUEUE_BUSY;
> >  		spin_unlock_irq(&nvmeq->q_lock);
> >  		goto out;
> >  	}
> 
> I can't say I'm a fan of doing all this in queue_rq...
> 
> besides why is this state check under the cq_vector < 0 condition?
> This is really confusing...

Agreed, that's not very clear. We will potentially have an option to
disable interrupt vectors entirely in the future, so this won't be
appropriate criteria if/when that happens.

I've a follow up series that uses queue states instead of irq and
namespace states, but planned to target 4.6 unless an alternate proposal
surfaces.
