From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 10 Apr 2019 09:57:57 -0600
Subject: [PATCH V4 0/2] blk-mq/nvme: cancel request synchronously
In-Reply-To: <20190408223122.29844-1-ming.lei@redhat.com>
References: <20190408223122.29844-1-ming.lei@redhat.com>
Message-ID: <adaf6255-09a2-257d-a061-8a9b3f2b73a6@kernel.dk>

On 4/8/19 4:31 PM, Ming Lei wrote:
> Hi,
> 
> This patchset introduces blk_mq_complete_request_sync() for canceling
> request synchronously in error handler context, then one race between
> completing request remotely and destroying contoller/queues can be fixed.

Applied for 5.1, thanks.

-- 
Jens Axboe
