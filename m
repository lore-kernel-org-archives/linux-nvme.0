From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jun 2017 12:49:10 -0400
Subject: [PATCH 1/6] nvme: remove a misleading comment on strut nvme_ns
In-Reply-To: <20170619095754.4602-2-hch@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-2-hch@lst.de>
Message-ID: <20170619164910.GF21765@localhost.localdomain>

On Mon, Jun 19, 2017@11:57:49AM +0200, Christoph Hellwig wrote:
> While a NVMe Namespace is somewhat similar to a SCSI Logical Unit (and not
> a Logical Unit Number anyway) there are subtile differences.  Remove the
> misleading comment.

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
