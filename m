From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 13:27:59 +0200
Subject: [PATCH 3/3] nvme: bio remapping tracepoint
In-Reply-To: <20180607083847.51019-4-hare@suse.de>
References: <20180607083847.51019-1-hare@suse.de>
 <20180607083847.51019-4-hare@suse.de>
Message-ID: <20180607112759.GC10939@lst.de>

On Thu, Jun 07, 2018@10:38:47AM +0200, Hannes Reinecke wrote:
> Adding a tracepoint to trace bio remapping for native nvme multipath.

I guess we should just move the trace point into direct_make_request?

Otherwise this looks sane to me.
