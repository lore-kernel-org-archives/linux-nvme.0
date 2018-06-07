From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 10:01:11 +0200
Subject: [PATCH 04/10] nvme: remove nvme_req_needs_failover
In-Reply-To: <20180606143311.23076-5-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-5-hch@lst.de>
Message-ID: <20180607100111.1f440657@pentland.suse.de>

On Wed,  6 Jun 2018 16:33:05 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Now that we just call out to blk_path_error there isn't really any
> good reason to not merge it into the only caller.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c      | 3 ++-
>  drivers/nvme/host/multipath.c | 7 -------
>  drivers/nvme/host/nvme.h      | 6 ------
>  3 files changed, 2 insertions(+), 14 deletions(-)
> 
Hmm. Have to redo my testing, then; this was one area which turned out
to be quite tricky. But anyway:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
