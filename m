From: hare@suse.de (Hannes Reinecke)
Date: Tue, 12 Jun 2018 08:02:15 +0200
Subject: [PATCH 01/10] nvme: don't rely on the changed namespace list log
In-Reply-To: <20180611141139.30462-2-hch@lst.de>
References: <20180611141139.30462-1-hch@lst.de>
 <20180611141139.30462-2-hch@lst.de>
Message-ID: <20180612080215.7da06e9b@pentland.suse.de>

On Mon, 11 Jun 2018 16:11:30 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Don't optimize our namespace rescan based on the changed namespace
> list log page as userspace might have changed the content through
> reading it.
> 
> Suggested-by: Keith Busch <keith.busch at linux.intel.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
