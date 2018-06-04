From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:42:50 +0200
Subject: [PATCH 8/9] nvmet: support configuring additional ANA groups
In-Reply-To: <20180601071128.7630-9-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-9-hch@lst.de>
Message-ID: <20180604084250.302284cf@pentland.suse.de>

On Fri,  1 Jun 2018 09:11:27 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Allow creating non-default ANA groups (group ID > 1).  Groups are
> created either by assigning the group ID to a namespace, or by
> creating a configfs group object under a specific port.  All
> namespaces assigned to a group that doesn't have a configfs object
> for a given port are marked as inaccessible.
> 
> For all changes in ANA configuration the ANA change AEN is sent.  We
> only keep a global changecount instead of additional per-group
> changecounts to keep the implementation as simple as possible.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/admin-cmd.c |   1 +
>  drivers/nvme/target/configfs.c  | 170
> +++++++++++++++++++++++++++++++- drivers/nvme/target/core.c      |
> 24 +++++ drivers/nvme/target/nvmet.h     |  29 +++++-
>  4 files changed, 220 insertions(+), 4 deletions(-)
> 

I'm not particularly keen of having the default ANA group _not_ being
present in configfs, but that can be fixed with a later patch.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
