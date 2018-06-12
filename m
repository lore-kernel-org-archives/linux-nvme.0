From: hare@suse.de (Hannes Reinecke)
Date: Tue, 12 Jun 2018 08:02:42 +0200
Subject: [PATCH 07/10] nvmet: keep a port pointer in nvmet_ctrl
In-Reply-To: <20180611141139.30462-8-hch@lst.de>
References: <20180611141139.30462-1-hch@lst.de>
 <20180611141139.30462-8-hch@lst.de>
Message-ID: <20180612080242.538cfb57@pentland.suse.de>

On Mon, 11 Jun 2018 16:11:36 +0200
Christoph Hellwig <hch@lst.de> wrote:

> This will be needed for the ANA AEN code.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/core.c  | 2 ++
>  drivers/nvme/target/nvmet.h | 2 ++
>  2 files changed, 4 insertions(+)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
