From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 15 Aug 2017 07:22:50 -0600
Subject: [PATCH] blk-mq: Fix queue usage on failed request allocation
In-Reply-To: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
References: <1502743211-14992-1-git-send-email-keith.busch@intel.com>
Message-ID: <5fe259b8-540e-573f-ba23-50a66712c20d@kernel.dk>

On 08/14/2017 02:40 PM, Keith Busch wrote:
> blk_mq_get_request() does not release the callers queue usage counter
> when allocation fails. The caller still needs to account for its own
> queue usage when it is unable to allocate a request.

Thanks Keith, applied.

-- 
Jens Axboe
