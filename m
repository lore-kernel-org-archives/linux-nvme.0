From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 May 2016 00:55:35 -0700
Subject: [PATCH] NVMe: Delete only created queues
In-Reply-To: <1462554949-14699-1-git-send-email-keith.busch@intel.com>
References: <1462554949-14699-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160508075534.GA24381@infradead.org>

On Fri, May 06, 2016@11:15:49AM -0600, Keith Busch wrote:
> Use the online queue count instead of the number of allocated queues. The
> controller should just return an invalid queue identifier error to the
> commands if a queue wasn't created. While it's not harmful, it's still
> not correct.
> 
> Reported-by: Saar Gross <saar at annapurnalabs.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
