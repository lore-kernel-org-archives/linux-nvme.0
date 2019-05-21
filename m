From: hch@lst.de (Christoph Hellwig)
Date: Tue, 21 May 2019 08:47:38 +0200
Subject: [PATCH 2/4] nvme-fc: track state change failures during reconnect
In-Reply-To: <20190520063624.50338-3-hare@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-3-hare@suse.de>
Message-ID: <20190521064738.GC30402@lst.de>

On Mon, May 20, 2019@08:36:22AM +0200, Hannes Reinecke wrote:
> The nvme-fc driver has several situation under which an expected
> state transition fails, but doesn't print out any messages if
> this happens.
> The patch adds logging for these situations.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: James Smart <james.smart at broadcom.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
