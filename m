From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Nov 2015 20:12:33 +0000
Subject: [PATCH 09/12] nvme: properly free resources for cancelled command
In-Reply-To: <20151109192518.GA10681@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-10-git-send-email-hch@lst.de>
 <20151109185731.GB5386@localhost.localdomain>
 <20151109192518.GA10681@lst.de>
Message-ID: <20151109201232.GC5386@localhost.localdomain>

On Mon, Nov 09, 2015@08:25:19PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 09, 2015@06:57:31PM +0000, Keith Busch wrote:
> > Whoa now, it's neither Intel nor userpace that needs this. It's to know
> > if the controller is unresponsive or returned an error. The difference
> > matters to the driver for initialization.
> 
> Haha, so we at least can root cause this now.  Can you point me
> to the caller that cares?  I'd really like to get rid of the special
> case of passing a negative errno here, so I'd like to figure out how
> we could pass this information on instead.

The "set_queue_count()" was the function that cared, but looks like
patch 8/12 makes this think a timeout is an aborted status.
