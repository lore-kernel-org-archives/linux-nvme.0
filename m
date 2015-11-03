From: axboe@fb.com (Jens Axboe)
Date: Tue, 3 Nov 2015 16:02:08 -0700
Subject: [patch] nvme: lightnvm: clean up a data type
In-Reply-To: <20151103223731.GE19280@mwanda>
References: <20151103223731.GE19280@mwanda>
Message-ID: <56393CF0.9050509@fb.com>

On 11/03/2015 03:37 PM, Dan Carpenter wrote:
> "nlb_pr_rq" can't be more than u32 because "len" is a u32.  Later we
> truncate it to u32 anyway when we calculate min_t().

Thanks Dan, applied.

-- 
Jens Axboe
