From: osandov@osandov.com (Omar Sandoval)
Date: Thu, 1 Nov 2018 14:59:57 -0700
Subject: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
In-Reply-To: <20181030183252.17857-7-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk>
Message-ID: <20181101215957.GH18005@vader>

On Tue, Oct 30, 2018@12:32:42PM -0600, Jens Axboe wrote:
> It can be useful for a user to verify what type a given hardware
> queue is, expose this information in sysfs.
> 
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Bart Van Assche <bvanassche at acm.org>
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>  block/blk-mq-sysfs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Out of curiousity, why sysfs instead of debugfs?
