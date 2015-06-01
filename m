From: axboe@fb.com (Jens Axboe)
Date: Mon, 1 Jun 2015 14:35:31 -0600
Subject: [PATCHv2 1/2] blk-mq: Shared tag enhancements
In-Reply-To: <1433172594-32127-1-git-send-email-keith.busch@intel.com>
References: <1433172594-32127-1-git-send-email-keith.busch@intel.com>
Message-ID: <556CC213.5020808@fb.com>

On 06/01/2015 09:29 AM, Keith Busch wrote:
> Storage controllers may expose multiple block devices that share hardware
> resources managed by blk-mq. This patch enhances the shared tags so a
> low-level driver can access the shared resources not tied to the unshared
> h/w contexts. This way the LLD can dynamically add and delete disks and
> request queues without having to track all the request_queue hctx's to
> iterate outstanding tags.

v2 looks good to me. I'll apply 1/2 to core, and 2/2 to drivers for 4.2.

-- 
Jens Axboe
