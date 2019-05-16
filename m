From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 May 2019 08:29:59 +0200
Subject: [PATCH 4/6] nvme-pci: Sync queues on reset
In-Reply-To: <20190515163625.21776-4-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-4-keith.busch@intel.com>
Message-ID: <20190516062959.GF29930@lst.de>

On Wed, May 15, 2019@10:36:23AM -0600, Keith Busch wrote:
> A controller with multiple namespaces may have multiple request_queues
> with their own timeout work. If a live controller fails with IO
> outstanding to diffent namespaces, each request queue may attempt to
> disable and reset the controller in different threads. Synchronize each
> queue prior to starting the controller to ensure there no previously
> scheduled timeout work is running.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>

I wonder if we should move the timeouts to a per-tagset single threaded
workqueue in the block layer, so that we don't process them in parallel?
