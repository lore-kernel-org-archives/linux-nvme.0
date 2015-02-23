From: axboe@fb.com (Jens Axboe)
Date: Mon, 23 Feb 2015 09:19:22 -0800
Subject: [PATCH] NVMe: Fix for BLK_DEV_INTEGRITY not set
In-Reply-To: <1424708181-29579-1-git-send-email-keith.busch@intel.com>
References: <1424708181-29579-1-git-send-email-keith.busch@intel.com>
Message-ID: <54EB611A.5090403@fb.com>

On 02/23/2015 08:16 AM, Keith Busch wrote:
> Need to define and use appropriate functions for when BLK_DEV_INTEGRITY
> is not set.

Thanks Keith, that works for me too. Unfortunately this is a recurring 
problem with the integrity bits, it's more often the norm that things 
break depending on config options than not...

-- 
Jens Axboe
