From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 26 May 2018 06:54:18 -0600
Subject: [PATCH] nvme-pci: simplify __nvme_submit_cmd
In-Reply-To: <20180526114555.8881-1-hch@lst.de>
References: <20180526114555.8881-1-hch@lst.de>
Message-ID: <c830723e-ee63-12a0-a794-3946293d5fb0@kernel.dk>

On 5/26/18 5:45 AM, Christoph Hellwig wrote:
> With recent CQ handling improvements we can now move the locking into
> __nvme_submit_cmd.  Also remove the local tail variable to make the code
> more obvious, remove the __ prefix in the name, and fix the comments
> describing the function.

Looks good to me.

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
