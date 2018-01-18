From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 18 Jan 2018 18:06:09 +0000
Subject: [PATCH 1/4] IB/core: add support for draining Shared receive
 queues
In-Reply-To: <02bd01d38fa8$c09a9430$41cfbc90$@opengridcomputing.com>
References: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
 <1516197178-26493-2-git-send-email-maxg@mellanox.com>
 <02bd01d38fa8$c09a9430$41cfbc90$@opengridcomputing.com>
Message-ID: <1516298766.2676.29.camel@wdc.com>

On Wed, 2018-01-17@09:35 -0600, Steve Wise wrote:
> > +	if (wait_for_completion_timeout(&qp->srq_completion, 10 * HZ) > 0)
> > +		ib_process_cq_direct(cq, -1);
> > +}
> 
> Perhaps a WARN_ONCE is warranted? 

Agreed. I would also like to see a WARN_ONCE() if the timeout expires before
the completion has been signaled.

Bart.
