From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 17 Aug 2016 11:51:27 -0700
Subject: [PATCH v3 1/4] nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
In-Reply-To: <2f2b6a4e-f1b2-8ff3-0c02-06ba87cd346c@grimberg.me>
References: <1471377415-29337-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1471377415-29337-2-git-send-email-james_p_freyensee@linux.intel.com>
 <20160817004713.GA21992@lst.de> <1471448860.3142.4.camel@linux.intel.com>
 <2f2b6a4e-f1b2-8ff3-0c02-06ba87cd346c@grimberg.me>
Message-ID: <1471459887.6059.7.camel@linux.intel.com>

On Wed, 2016-08-17@21:36 +0300, Sagi Grimberg wrote:
> > 
> > > 
> > > > 
> > > > ?	/*
> > > > -	?* req->hsqsize corresponds to our recv queue size
> > > > -	?* req->hrqsize corresponds to our send queue size
> > > > +	?* req->hsqsize corresponds to our recv queue size
> > > > plus 1
> > > > +	?* req->hrqsize corresponds to our send queue size
> > > > plus 1
> > > > ?	?*/
> > > > -	queue->recv_queue_size = le16_to_cpu(req->hsqsize);
> > > > -	queue->send_queue_size = le16_to_cpu(req->hrqsize);
> > > > +	queue->recv_queue_size = le16_to_cpu(req->hsqsize) +
> > > > 1;
> > > > +	queue->send_queue_size = le16_to_cpu(req->hrqsize) +
> > > > 1;
> > > 
> > > I brought this up on the nvme-technical list and the consensus is
> > > that hrqsize doesn't use the one off notation.??hsqsize refers to
> > > the sqsize which is marked as "0's based", while hrqsize only
> > > has a short and not very meaningful explanation, which implies
> > > that
> > > it's '1's based' in NVMe terms (which, btw I think are utterly
> > > misleading).
> > 
> > OK, so what is the final verdict then???Resurrect patch five again
> > and
> > resubmit the series???It makes hrqsize 1-based on both the host and
> > target.
> > http://lists.infradead.org/pipermail/linux-nvme/2016-August/005804.
> > html
> 
> I think you can just make the target take hrqsize as is in patch 1
> and have the host send hrqsize = queue->queue_size.
> 
> One more respin should do it (sorry for the exhaustion ;))

No worries, doesn't help when the spec isn't clear on something :-).
