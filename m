From: keith.busch@intel.com (Busch, Keith)
Date: Wed, 19 Aug 2015 19:12:28 +0000
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <20150806135018.GA8666@infradead.org>
References: <1438716733-566-1-git-send-email-keith.busch@intel.com>
 <20150806135018.GA8666@infradead.org>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93CBE3F9E@fmsmsx104.amr.corp.intel.com>

Hi,

Can this be applied for 4.3?


> On Tue, Aug 04, 2015@01:32:13PM -0600, Keith Busch wrote:
> > The SG_GAPS queue flag caused checks for bio vector alignment against
> > PAGE_SIZE, but the device may have different constraints. This patch
> > adds a queue limits so a driver with such constraints can set to allow
> > requests that would have been unnecessarily split. The new gaps check
> > takes the request_queue as a parameter to simplify the logic around
> > invoking this function.
> >
> > This new limit makes the queue flag redundant, so removing it and
> > all usage. Device-mappers will inherit the correct settings through
> > blk_stack_limits().
> >
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
