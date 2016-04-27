From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Apr 2016 09:50:31 +0200
Subject: [PATCH 2/5] nvme: introduce a controller state machine
In-Reply-To: <20160426161833.GA13324@localhost.localdomain>
References: <1461671520-4758-1-git-send-email-hch@lst.de>
 <1461671520-4758-3-git-send-email-hch@lst.de>
 <20160426161833.GA13324@localhost.localdomain>
Message-ID: <20160427075031.GA28726@lst.de>

On Tue, Apr 26, 2016@10:18:34AM -0600, Jon Derrick wrote:
> Hi Christoph,
> 
> > @@ -1835,7 +1829,7 @@ static void nvme_reset_work(struct work_struct *work)
> >  	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
> >  	int result = -ENODEV;
> >  
> > -	if (WARN_ON(test_bit(NVME_CTRL_RESETTING, &dev->flags)))
> > +	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
> >  		goto out;
> >  
> >  	/*
> > @@ -1845,7 +1839,8 @@ static void nvme_reset_work(struct work_struct *work)
> >  	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
> >  		nvme_dev_disable(dev, false);
> >  
> > -	set_bit(NVME_CTRL_RESETTING, &dev->flags);
> > +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> > +		goto out;
> >  
> Seems redundant to above WARN_ON test

It's not - in theory someone could change the change in the meantime.
In the long run I really want to tighten things up and introduce
a new shuttdown down state that would be set where the WARN_ON currently
is, but I'd prefer to keep things simple for now as we have a lot of
bits that depend on the basic state machine.
