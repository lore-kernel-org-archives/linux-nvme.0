From: keith.busch@intel.com (Keith Busch)
Date: Mon, 7 Nov 2016 13:45:42 -0500
Subject: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
In-Reply-To: <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
Message-ID: <20161107184541.GA21698@localhost.localdomain>

On Tue, Nov 01, 2016@10:18:13AM +0200, Sagi Grimberg wrote:
> > -	spin_lock_irq(&nvmeq->q_lock);
> > +	spin_lock_irqsave(&nvmeq->q_lock, flags);
> >  	if (unlikely(nvmeq->cq_vector < 0)) {
> >  		if (ns && !test_bit(NVME_NS_DEAD, &ns->flags))
> >  			ret = BLK_MQ_RQ_QUEUE_BUSY;
> >  		else
> >  			ret = BLK_MQ_RQ_QUEUE_ERROR;
> > -		spin_unlock_irq(&nvmeq->q_lock);
> > +		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
> >  		goto out;
> >  	}
> >  	__nvme_submit_cmd(nvmeq, &cmnd);
> >  	nvme_process_cq(nvmeq);
> > -	spin_unlock_irq(&nvmeq->q_lock);
> > +	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
> 
> No documentation why this is needed...

Let's forget documenting why it's needed; this solution should instead
figure out a way to make it so it's not needed.
