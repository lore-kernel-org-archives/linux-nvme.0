From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 21 Dec 2017 13:57:37 -0700
Subject: [PATCH 3/3] block: Polling completion performance optimization
In-Reply-To: <20171221204636.2924-4-keith.busch@intel.com>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
Message-ID: <5e69c9fe-b0ae-fc1a-637d-9a3816faa506@kernel.dk>

On 12/21/17 1:46 PM, Keith Busch wrote:
> When a request completion is polled, the completion task wakes itself
> up. This is unnecessary, as the task can just set itself back to
> running.

Looks good to me, I can take it for 4.16 in the block tree.

-- 
Jens Axboe
