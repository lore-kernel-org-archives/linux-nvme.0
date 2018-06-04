From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:35:33 +0200
Subject: [PATCH 6/9] nvmet: track and limit the number of namespaces per
 subsystem
In-Reply-To: <20180601071128.7630-7-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-7-hch@lst.de>
Message-ID: <20180604083533.14300c78@pentland.suse.de>

On Fri,  1 Jun 2018 09:11:25 +0200
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
