From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 22 May 2018 16:27:55 +0000
Subject: [RFC PATCH 2/3] blk-mq: Fix timeout and state order
In-Reply-To: <20180522152437.GB18664@lst.de>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-3-keith.busch@intel.com>
 <20180522152437.GB18664@lst.de>
Message-ID: <3d14e88b2bb22ac929d2aa007b4ad9eaee6def56.camel@wdc.com>

On Tue, 2018-05-22@17:24 +0200, Christoph Hellwig wrote:
> On Mon, May 21, 2018@05:11:30PM -0600, Keith Busch wrote:
> > The block layer had been setting the state to in-flight prior to updating
> > the timer. This is the wrong order since the timeout handler could observe
> > the in-flight state with the older timeout, believing the request had
> > expired when in fact it is just getting started.
> > 
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> 
> The way I understood Barts comments to my comments on his patch we
> actually need the two updates to be atomic.  I haven't had much time
> to follow up, but I'd like to hear Barts opinion.  Either way we
> clearly need to document our assumptions here in comments.

After we discussed request state updating I have been thinking further about
this. I think now that it is safe to update the request deadline first because
the timeout code ignores requests anyway that have another state than
MQ_RQ_IN_FLIGHT. Additionally, it is unlikely that the request timer will fire
before the request state has been updated. And if that would happen the request
timeout will be handled the next time request timeouts are examined.

Bart.
