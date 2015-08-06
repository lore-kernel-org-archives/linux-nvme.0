From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 6 Aug 2015 06:50:18 -0700
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <1438716733-566-1-git-send-email-keith.busch@intel.com>
References: <1438716733-566-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150806135018.GA8666@infradead.org>

On Tue, Aug 04, 2015@01:32:13PM -0600, Keith Busch wrote:
> The SG_GAPS queue flag caused checks for bio vector alignment against
> PAGE_SIZE, but the device may have different constraints. This patch
> adds a queue limits so a driver with such constraints can set to allow
> requests that would have been unnecessarily split. The new gaps check
> takes the request_queue as a parameter to simplify the logic around
> invoking this function.
> 
> This new limit makes the queue flag redundant, so removing it and
> all usage. Device-mappers will inherit the correct settings through
> blk_stack_limits().
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
