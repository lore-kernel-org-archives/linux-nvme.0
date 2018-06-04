From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 12:21:02 +0200
Subject: [PATCH 9/9] nvmet: make ANATT configurable
In-Reply-To: <20180601071128.7630-10-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-10-hch@lst.de>
Message-ID: <20180604122102.4bfcd154@pentland.suse.de>

On Fri,  1 Jun 2018 09:11:28 +0200
Christoph Hellwig <hch@lst.de> wrote:

> From: Hannes Reinecke <hare at suse.de>
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/admin-cmd.c |  2 +-
>  drivers/nvme/target/configfs.c  | 29 +++++++++++++++++++++++++++++
>  drivers/nvme/target/core.c      |  1 +
>  drivers/nvme/target/nvmet.h     |  2 ++
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 

_Actually_ I would like to retract this patch.

I've been working on implementing ANA TT on the target, and found this
particular implementation unworkable.

The problem is that with the current implementation the ANA state is
pretty much tied to the _port_, which might be shared across several
subsystems. Consequently any state change might affect namespaces
on several subsystems, too.

But if the anatt value is tied to the subsystem we'd need to have
different timers/workqueue items per port and subsystem/namespace, which
doesn't really scale. Plus we're not giving anything away by making the
anatt per port, not per subsys.

Please?

Cheers,

Hannes
