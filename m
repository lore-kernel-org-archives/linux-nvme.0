From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 15:02:51 +0100
Subject: [PATCH 2/3] nvme: shorten race window in nvme_ns_remove()
In-Reply-To: <20190327080929.27918-3-hare@suse.de>
References: <20190327080929.27918-1-hare@suse.de>
 <20190327080929.27918-3-hare@suse.de>
Message-ID: <20190327140251.GA25990@lst.de>

On Wed, Mar 27, 2019@09:09:28AM +0100, Hannes Reinecke wrote:
> nvme_ns_remove() sets the 'NVME_NS_REMOVING' bit at first, but
> only removes the namespace from the list at the very end.
> This opens a rether large race window during which other processes
> traversing the namespaces via list_for_each() will access partially
> deleted namespaces, causing unpredictable results.
> This patch shortens the race window by removing the namespace
> from the list as early as possible.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>

With this patch I don't see any reason for your patch 1, given that
the window between setting the REMOVING bit and removing from the
list is so tiny.

That being said I think we really should also remove the namespace
from ->siblings and clear the current path ASAP as well, which might
remove the need for patch 3 as well.
