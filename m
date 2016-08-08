From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 08 Aug 2016 10:48:17 -0700
Subject: [PATCH RFC] nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
In-Reply-To: <1470672588.40000.22.camel@intel.com>
References: <1470452441-4005-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470672588.40000.22.camel@intel.com>
Message-ID: <1470678497.2626.2.camel@linux.intel.com>

On Mon, 2016-08-08@16:09 +0000, Verkamp, Daniel wrote:
> Hi Jay,
> 
> On Fri, 2016-08-05@20:00 -0700, Jay Freyensee wrote:
> > 
> > -	queue->recv_queue_size = le16_to_cpu(req->hsqsize);
> > -	queue->send_queue_size = le16_to_cpu(req->hrqsize);
> > +	queue->recv_queue_size = le16_to_cpu(req->hsqsize)+1;
> > +	queue->send_queue_size = le16_to_cpu(req->hrqsize)+1;
> 
> I think the +1 needs to be inside the le16_to_cpu() in both cases.

Thanks.

This patch will be dependent on the "nvme-rdma: sqsize/hsqsize/hrqsize
is 0-based val" patch, which reading the spec again I still think it's
0-based.

> 
> -- Daniel
