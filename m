From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:41:40 +0200
Subject: [PATCH 7/9] nvmet: add minimal ANA support
In-Reply-To: <20180601071128.7630-8-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-8-hch@lst.de>
Message-ID: <20180604084140.5ec25b46@pentland.suse.de>

On Fri,  1 Jun 2018 09:11:26 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Add support for Asynchronous Namespace Access as specified in NVMe 1.3
> TP 4004.
> 
> Just add a default ANA group 1 that is optimized on all ports.  This
> is (and will remain) the default assignment for any namespace not
> epxlicitly assigned to another ANA group.  The ANA state can be
> manually changed through the configfs interface, including the change
> state.
> 
> Includes fixes and improvements from Hannes Reinecke.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 87
> +++++++++++++++++++++++++++++++-- drivers/nvme/target/configfs.c  |
> 10 ++++ drivers/nvme/target/core.c      | 34 +++++++++++++
>  drivers/nvme/target/nvmet.h     | 15 ++++++
>  4 files changed, 142 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
