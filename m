From: hch@lst.de (Christoph Hellwig)
Date: Fri, 27 Apr 2018 07:21:44 +0200
Subject: [PATCH 2/2] nvme/multipath: Fix multipath disabled naming
 collisions
In-Reply-To: <20180426214956.3377-3-keith.busch@intel.com>
References: <20180426214956.3377-1-keith.busch@intel.com>
 <20180426214956.3377-3-keith.busch@intel.com>
Message-ID: <20180427052144.GC9698@lst.de>

On Thu, Apr 26, 2018@03:49:56PM -0600, Keith Busch wrote:
> When CONFIG_NVME_MULTIPATH is set, but we're not using nvme to multipath,
> namespaces with multiple paths were not creating unique names due to
> reusing the same instance number from the namespace's head.
> 
> This patch fixes this by falling back to the non-multipath naming method
> when the parameter disabled using multipath.
> 
> Reported-by: Mike Snitzer <snitzer at redhat.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
