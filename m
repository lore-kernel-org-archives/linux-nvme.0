From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:17:06 +0200
Subject: [PATCH 12/12] nvme: limit warnings from nvme_identify_ns
In-Reply-To: <20180530164600.26856-13-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-13-hch@lst.de>
Message-ID: <20180604081706.7be35b3e@pentland.suse.de>

On Wed, 30 May 2018 18:46:00 +0200
Christoph Hellwig <hch@lst.de> wrote:

> When rescanning namespaces after an AEN we will issue Identify
> Namespace comands to namespaces that have gone away, so don't warn
> for this specific case.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
