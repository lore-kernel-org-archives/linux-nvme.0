From: axboe@fb.com (Jens Axboe)
Date: Sat, 20 Dec 2014 10:32:47 -0700
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
Message-ID: <5495B2BF.8070602@fb.com>

On 12/19/2014 05:54 PM, Keith Busch wrote:
> This fixes some surprise hot plug and error handling cases.
> 
> There is still one deadlock when we run out of tags and get stuck in
> bt_get, but Jens sent me a test patch that I verfied fixes that when
> used with this set.

Thanks Keith, I'll apply these for the current series. Only change I'll
make is turn the freeze/unfreeze exports into _GPL exports.


-- 
Jens Axboe
