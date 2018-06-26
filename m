From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 26 Jun 2018 12:18:49 -0600
Subject: [PATCH] block: Fix transfer when chuck sectors exceeds max
In-Reply-To: <20180626151458.6675-1-keith.busch@intel.com>
References: <20180626151458.6675-1-keith.busch@intel.com>
Message-ID: <599a0ffd-66dc-9604-856e-cfa0210ebc51@kernel.dk>

On 6/26/18 9:14 AM, Keith Busch wrote:
> A device may have boundary restrictions where the number of sectors
> between boundaries exceeds its max transfer size. In this case, we need
> to cap the max size to the smaller of the two limits.

Applied, with the subject typo fixed.

-- 
Jens Axboe
