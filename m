From: james.smart@broadcom.com (James Smart)
Date: Tue, 18 Apr 2017 14:08:33 -0700
Subject: nvme-fc: fix status code handling in nvme_fc_fcpio_done
In-Reply-To: <20170418155229.5977-3-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
 <20170418155229.5977-3-hch@bombadil.infradead.org>
Message-ID: <96441c26-93b1-751d-6995-d9d0fab00eee@broadcom.com>


On 4/18/2017 8:52 AM, Christoph Hellwig wrote:
> From: Christoph Hellwig <hch at lst.de>
>
> nvme_complete_async_event expects the little endian status code
> including the phase bit, and a new completion handler I plan to
> introduce will do so as well.
>
> Change the status variable into the little endian format with the
> phase bit used in the NVMe CQE to fix / enable this.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>

look good

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
