From: hare@suse.de (Hannes Reinecke)
Date: Tue, 12 Jun 2018 08:08:32 +0200
Subject: [PATCH 10/10] nvmet: support configuring ANA groups
In-Reply-To: <20180611141139.30462-11-hch@lst.de>
References: <20180611141139.30462-1-hch@lst.de>
 <20180611141139.30462-11-hch@lst.de>
Message-ID: <20180612080832.37d604df@pentland.suse.de>

On Mon, 11 Jun 2018 16:11:39 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Allow creating non-default ANA groups (group ID > 1).  Groups are
> created either by assigning the group ID to a namespace, or by
> creating a configfs group object under a specific port.  All
> namespaces assigned to a group that doesn't have a configfs object
> for a given port are marked as inaccessible.
> 
> Allow changing the ANA state on a per-port basis by creating an
> ana_groups directory under each port, and another directory with an
> ana_state file in it.  The default ANA group 1 directory is created
> automatically for each port.
> 
> For all changes in ANA configuration the ANA change AEN is sent.  We
> only keep a global changecount instead of additional per-group
> changecounts to keep the implementation as simple as possible.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/admin-cmd.c |   1 +
>  drivers/nvme/target/configfs.c  | 182
> +++++++++++++++++++++++++++++++- drivers/nvme/target/core.c      |
> 27 +++++ drivers/nvme/target/nvmet.h     |  30 +++++-
>  4 files changed, 236 insertions(+), 4 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
