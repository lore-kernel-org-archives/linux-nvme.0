From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:13:01 +0200
Subject: [PATCH 01/12] nvme.h: untangle AEN notice definitions
In-Reply-To: <20180530164600.26856-2-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-2-hch@lst.de>
Message-ID: <20180604081301.2a6ecec5@pentland.suse.de>

On Wed, 30 May 2018 18:45:49 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Stop including the event type in the definitions for the notice type.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 30 ++++++++++++++++++------------
>  include/linux/nvme.h     |  8 ++++++--
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
