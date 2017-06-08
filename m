From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 8 Jun 2017 08:53:44 -0600
Subject: [PATCH] nvme: move reset workqueue handling to common code
In-Reply-To: <20170608130836.31891-1-hch@lst.de>
References: <20170608130836.31891-1-hch@lst.de>
Message-ID: <bbdd175f-2d37-e0f5-2004-705122b399d9@kernel.dk>

On 06/08/2017 07:08 AM, Christoph Hellwig wrote:
> This moves the nvme_reset function from the PCIe driver to common code,
> renaming it to nvme_reset_ctrl in the process.  Additionally a new
> helper nvme_reset_ctrl_sync is added for the case where we want to
> wait for the reset.  To facilitate that the reset_work work structure is
> move to the common nvme_ctrl structure and the ->reset_ctrl method is
> removed.  For now the drivers initialize the reset_work with their own
> callback, but longer term we should move to callouts for specific
> parts of the reset process and move even more code to the core.

Nice cleanup.

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
