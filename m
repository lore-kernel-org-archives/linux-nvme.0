From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 6 Jun 2018 08:59:03 -0600
Subject: [PATCH 3/6] nvme-pci: Queue creation fixes
In-Reply-To: <20180606141309.19389-4-keith.busch@intel.com>
References: <20180606141309.19389-1-keith.busch@intel.com>
 <20180606141309.19389-4-keith.busch@intel.com>
Message-ID: <890be51c-c45c-23da-fd2e-94879463e2b1@kernel.dk>

On 6/6/18 8:13 AM, Keith Busch wrote:
> We've been ignoring NVMe error status on queue creations. Fortunately they
> are uncommon, but we should handle these anyway. This patch adds checks
> for the a positive error return value that indicates an NVMe status.
> 
> If we do see a negative return, the controller isn't usable, so this
> patch returns immediately in since we can't unwind that failure.

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
