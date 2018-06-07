From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 09:59:50 +0200
Subject: [PATCH 03/10] nvme: simplify the API for getting log pages
In-Reply-To: <20180606143311.23076-4-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-4-hch@lst.de>
Message-ID: <20180607095950.2b2ec2ea@pentland.suse.de>

On Wed,  6 Jun 2018 16:33:04 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Merge nvme_get_log and nvme_get_log_ext into a single helper, which
> takes a plain nsid instead of the nvme_ns pointer.  Also add support
> for the log specific field while we're at it.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c     | 32 +++++++++++---------------------
>  drivers/nvme/host/lightnvm.c |  5 +++--
>  drivers/nvme/host/nvme.h     |  4 ++--
>  3 files changed, 16 insertions(+), 25 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
