From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Jun 2019 09:00:38 +0200
Subject: [PATCH v4 1/3] nvme: Introduce NVMe 1.4 Identify Namespace
 fields in struct nvme_id_ns
In-Reply-To: <20190627143215.27443-2-bvanassche@acm.org>
References: <20190627143215.27443-1-bvanassche@acm.org>
 <20190627143215.27443-2-bvanassche@acm.org>
Message-ID: <20190628070038.GA28268@lst.de>

On Thu, Jun 27, 2019@07:32:13AM -0700, Bart Van Assche wrote:
> Several new fields have been introduced in version 1.4 of the NVMe spec
> at offsets that were defined as reserved in version 1.3d of the NVMe
> spec. Update the definition of the nvme_id_ns data structure such that
> it is in sync with version 1.4 of the NVMe spec. This change preserves
> backwards compatibility.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reviewed-by: Keith Busch <kbusch at kernel.org>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
