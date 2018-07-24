From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 24 Jul 2018 13:42:19 -0700
Subject: [PATCHv2 1/2] blk-mq: export setting request completion state
In-Reply-To: <20180723143751.10843-1-keith.busch@intel.com>
References: <20180723143751.10843-1-keith.busch@intel.com>
Message-ID: <90649cd7-6e8a-c87c-4773-eb6881e85d72@kernel.dk>

On 7/23/18 7:37 AM, Keith Busch wrote:
> This is preparing for drivers that want to directly alter the state of
> their requests. No functional change here.

Added this (and 2/2) for 4.18...

-- 
Jens Axboe
