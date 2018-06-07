From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 10:02:31 +0200
Subject: [PATCH 07/10] nvmet: track and limit the number of namespaces
 per subsystem
In-Reply-To: <20180606143311.23076-8-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-8-hch@lst.de>
Message-ID: <20180607100231.6cb5ac8f@pentland.suse.de>

On Wed,  6 Jun 2018 16:33:08 +0200
Christoph Hellwig <hch@lst.de> wrote:

> TP 4004 introduces a new 'Maximum Number of Allocated Namespaces'
> field in the Identify controller data to help the host size
> resources.  Put an upper limit on the supported namespaces to be able
> to support this value as supporting 32-bits worth of namespaces would
> lead to very large buffers.  The limit is completely arbitrary at
> this point.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 1 +
>  drivers/nvme/target/core.c      | 8 +++++++-
>  drivers/nvme/target/nvmet.h     | 8 ++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
