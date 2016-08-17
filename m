From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 17 Aug 2016 08:47:40 -0700
Subject: [PATCH v3 1/4] nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
In-Reply-To: <20160817004713.GA21992@lst.de>
References: <1471377415-29337-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1471377415-29337-2-git-send-email-james_p_freyensee@linux.intel.com>
 <20160817004713.GA21992@lst.de>
Message-ID: <1471448860.3142.4.camel@linux.intel.com>

On Wed, 2016-08-17@02:47 +0200, Christoph Hellwig wrote:
> On Tue, Aug 16, 2016@12:56:52PM -0700, Jay Freyensee wrote:
> > 
> > ?	/*
> > -	?* req->hsqsize corresponds to our recv queue size
> > -	?* req->hrqsize corresponds to our send queue size
> > +	?* req->hsqsize corresponds to our recv queue size plus 1
> > +	?* req->hrqsize corresponds to our send queue size plus 1
> > ?	?*/
> > -	queue->recv_queue_size = le16_to_cpu(req->hsqsize);
> > -	queue->send_queue_size = le16_to_cpu(req->hrqsize);
> > +	queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
> > +	queue->send_queue_size = le16_to_cpu(req->hrqsize) + 1;
> 
> I brought this up on the nvme-technical list and the consensus is
> that hrqsize doesn't use the one off notation.??hsqsize refers to
> the sqsize which is marked as "0's based", while hrqsize only
> has a short and not very meaningful explanation, which implies that
> it's '1's based' in NVMe terms (which, btw I think are utterly
> misleading).

OK, so what is the final verdict then? ?Resurrect patch five again and
resubmit the series? ?It makes hrqsize 1-based on both the host and
target.
http://lists.infradead.org/pipermail/linux-nvme/2016-August/005804.html

I interpret the 'explanation' it can be either solution and I don't see
an advantage for either so we should just pick one.
