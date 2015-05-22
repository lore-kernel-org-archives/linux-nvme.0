From: axboe@fb.com (Jens Axboe)
Date: Fri, 22 May 2015 14:14:00 -0600
Subject: [PATCH] NVMe: Fix obtaining command result
In-Reply-To: <1432319311-2895-1-git-send-email-keith.busch@intel.com>
References: <1432319311-2895-1-git-send-email-keith.busch@intel.com>
Message-ID: <555F8E08.8050300@fb.com>

On 05/22/2015 12:28 PM, Keith Busch wrote:
> Replaces req->sense_len usage, which is not owned by the LLD, to
> req->special to contain the command result for driver created commands,
> and sets the result unconditionally on completion.

Thanks Keith, added. I added a Fixes tag too.

-- 
Jens Axboe
