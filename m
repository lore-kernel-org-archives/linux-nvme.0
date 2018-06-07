From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 10:03:40 +0200
Subject: [PATCH 08/10] nvmet: add minimal ANA support
In-Reply-To: <20180606143311.23076-9-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-9-hch@lst.de>
Message-ID: <20180607100340.5af09f88@pentland.suse.de>

On Wed,  6 Jun 2018 16:33:09 +0200
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
> +++++++++++++++++++++++++++++++++++++++--
> drivers/nvme/target/configfs.c  | 10 +++++
> drivers/nvme/target/core.c      | 33 ++++++++++++++++
> drivers/nvme/target/nvmet.h     | 15 +++++++ 4 files changed, 141
> insertions(+), 4 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
