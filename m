From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Apr 2016 09:51:33 +0200
Subject: [PATCH 3/5] nvme: tighten up state check for namespace scanning
In-Reply-To: <20160426164043.GA13369@localhost.localdomain>
References: <1461671520-4758-1-git-send-email-hch@lst.de>
 <1461671520-4758-4-git-send-email-hch@lst.de>
 <20160426164043.GA13369@localhost.localdomain>
Message-ID: <20160427075133.GB28726@lst.de>

On Tue, Apr 26, 2016@10:40:44AM -0600, Jon Derrick wrote:
> > +
> > +	if (dev->online_queues > 1)
> > +		nvme_queue_scan(dev);
> >  	return;
> >  
> Above this we do 'if (dev->online_queues < 2)'.
> Maybe we should change one or the other to make it consistent

I have another series that will replace all the checks of
dev->online_queues with a descriptive wrapper.  It still needs a bit
of work, but I plan to submit it soonish after this series goes in.
