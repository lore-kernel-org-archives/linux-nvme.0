From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:14:10 +0200
Subject: [PATCH 04/12] nvmet: add a new nvmet_zero_sgl helper
In-Reply-To: <20180530164600.26856-5-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-5-hch@lst.de>
Message-ID: <20180604081410.0ad79325@pentland.suse.de>

On Wed, 30 May 2018 18:45:52 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Zeroes the SGL in the payload.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/core.c  | 7 +++++++
>  drivers/nvme/target/nvmet.h | 1 +
>  2 files changed, 8 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
