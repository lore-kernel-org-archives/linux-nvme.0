From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:30:18 +0200
Subject: [PATCH 1/9] nvme: don't hold nvmf_transports_rwsem for more
 than transport lookups
In-Reply-To: <20180601071128.7630-2-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-2-hch@lst.de>
Message-ID: <20180604083018.3ba53612@pentland.suse.de>

On Fri,  1 Jun 2018 09:11:20 +0200
Christoph Hellwig <hch@lst.de> wrote:

> From: Johannes Thumshirn <jthumshirn at suse.de>
> 
> Only take nvmf_transports_rwsem when doing a lookup of registered
> transports, so that a blocking ->create_ctrl doesn't prevent other
> actions on /dev/nvme-fabrics.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> [hch: increased lock hold time a bit to be safe, added a comment
>  and updated the changelog]
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/fabrics.c | 3 ++-
>  drivers/nvme/host/fabrics.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
