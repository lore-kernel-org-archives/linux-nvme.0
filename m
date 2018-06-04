From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:14:31 +0200
Subject: [PATCH 05/12] nvmet: split log page implementation
In-Reply-To: <20180530164600.26856-6-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-6-hch@lst.de>
Message-ID: <20180604081431.374c5488@pentland.suse.de>

On Wed, 30 May 2018 18:45:53 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Remove the common code to allocate a buffer and copy it into the SGL.
> Instead the two no-op implementations just zero the SGL directly, and
> the smart log allocates a buffer on its own.  This prepares for the
> more elaborate ANA log page.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 99
> ++++++++++++--------------------- 1 file changed, 36 insertions(+),
> 63 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
