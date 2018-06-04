From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:31:05 +0200
Subject: [PATCH 3/9] nvme: add support for the log specific field
In-Reply-To: <20180601071128.7630-4-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-4-hch@lst.de>
Message-ID: <20180604083105.702605fd@pentland.suse.de>

On Fri,  1 Jun 2018 09:11:22 +0200
Christoph Hellwig <hch@lst.de> wrote:

> NVMe 1.3 added a new log specific field to the get log page CQ
> defintion.  Add the field and support passing it to nvme_get_log_ext.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c     | 6 +++---
>  drivers/nvme/host/lightnvm.c | 2 +-
>  drivers/nvme/host/nvme.h     | 2 +-
>  include/linux/nvme.h         | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
