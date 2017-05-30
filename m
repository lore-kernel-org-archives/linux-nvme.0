From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 30 May 2017 12:32:59 -0600
Subject: [PATCH] blk-mq: Take tagset lock when updaing hw queues
In-Reply-To: <1496169551-26868-1-git-send-email-keith.busch@intel.com>
References: <1496169551-26868-1-git-send-email-keith.busch@intel.com>
Message-ID: <56ed7162-5397-b4dd-14d2-1e017c6b7c33@kernel.dk>

On 05/30/2017 12:39 PM, Keith Busch wrote:
> The tagset lock needs to be held when iterating the tag_list, so a
> lockdep assert was added when updating number of hardware queues. The
> drivers calling this API, however, were unaware of the new requirement,
> so are failing the assertion.
> 
> This patch takes the lock within the blk-mq function so the drivers do
> not have to be modified in order to be safe.

Thanks Keith, applied for 4.12 with the typo in the subject line fixed
up.

-- 
Jens Axboe
