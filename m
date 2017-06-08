From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Jun 2017 09:44:36 +0200
Subject: [PATCH v6 06/10] nvmet: add uuid field to nvme_ns and populate
 via configfs
In-Reply-To: <20170607094536.32419-7-jthumshirn@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-7-jthumshirn@suse.de>
Message-ID: <20170608074436.GE13953@lst.de>

On Wed, Jun 07, 2017@11:45:33AM +0200, Johannes Thumshirn wrote:
> Add the UUID field from the NVMe Namespace Identification Descriptor
> to the nvmet_ns structure and allow it's population via configfs.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
