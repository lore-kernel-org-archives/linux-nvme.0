From: axboe@fb.com (Jens Axboe)
Date: Thu, 11 Feb 2016 08:21:24 -0700
Subject: [PATCH] block: Initialize max_dev_sectors to 0
In-Reply-To: <1455148367-25208-1-git-send-email-keith.busch@intel.com>
References: <1455148367-25208-1-git-send-email-keith.busch@intel.com>
Message-ID: <56BCA6F4.6030807@fb.com>

On 02/10/2016 04:52 PM, Keith Busch wrote:
> The new queue limit is not used by the majority of block drivers, and
> should be initialized to 0 for the driver's requested settings to be used.

That's much better, thanks.


-- 
Jens Axboe
