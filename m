From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Jun 2017 09:46:13 +0200
Subject: [PATCH v6 07/10] nvme: get list of namespace descriptors
In-Reply-To: <20170607094536.32419-8-jthumshirn@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-8-jthumshirn@suse.de>
Message-ID: <20170608074613.GF13953@lst.de>

On Wed, Jun 07, 2017@11:45:34AM +0200, Johannes Thumshirn wrote:
> If a target identifies itself as NVMe 1.3 compliant, try to get the
> list of Namespace Identification Descriptors and populate the UUID,
> NGUID and EUI64 fileds in the NVMe namespace structure with these
> values.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
