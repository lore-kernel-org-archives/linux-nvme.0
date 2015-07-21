From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 21 Jul 2015 05:21:16 -0700
Subject: [PATCHv5 2/2] NVMe: Use CMB for the IO SQes if available
In-Reply-To: <1437408849-4099-3-git-send-email-jonathan.derrick@intel.com>
References: <1437408849-4099-1-git-send-email-jonathan.derrick@intel.com>
 <1437408849-4099-3-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20150721122116.GB7430@infradead.org>

On Mon, Jul 20, 2015@10:14:09AM -0600, Jon Derrick wrote:
> Some controllers have a controller-side memory buffer available for use
> for submissions, completions, lists, or data.
> 
> If a CMB is available, the entire CMB will be ioremapped and it will
> attempt to map the IO SQes onto the CMB. The queues will be shrunk as
> needed. The CMB will not be used if the queue depth is shrunk below some
> threshold where it may have reduced performance over a larger queue
> in system memory.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
