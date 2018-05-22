From: hch@lst.de (Christoph Hellwig)
Date: Tue, 22 May 2018 17:24:37 +0200
Subject: [RFC PATCH 2/3] blk-mq: Fix timeout and state order
In-Reply-To: <20180521231131.6685-3-keith.busch@intel.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-3-keith.busch@intel.com>
Message-ID: <20180522152437.GB18664@lst.de>

On Mon, May 21, 2018@05:11:30PM -0600, Keith Busch wrote:
> The block layer had been setting the state to in-flight prior to updating
> the timer. This is the wrong order since the timeout handler could observe
> the in-flight state with the older timeout, believing the request had
> expired when in fact it is just getting started.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

The way I understood Barts comments to my comments on his patch we
actually need the two updates to be atomic.  I haven't had much time
to follow up, but I'd like to hear Barts opinion.  Either way we
clearly need to document our assumptions here in comments.
