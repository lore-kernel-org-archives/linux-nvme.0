From: axboe@fb.com (Jens Axboe)
Date: Mon, 23 Mar 2015 10:16:04 -0600
Subject: [PATCH for-4.0-rc6] NVMe: Initialize device list head before
 starting
In-Reply-To: <1427124757-30384-1-git-send-email-keith.busch@intel.com>
References: <1427124757-30384-1-git-send-email-keith.busch@intel.com>
Message-ID: <55103C44.60604@fb.com>

On 03/23/2015 09:32 AM, Keith Busch wrote:
> Driver recovery requires the device's list node to have been initialized.
>
> Fixes: https://lkml.org/lkml/2015/3/22/262
>
> Reported-by: Steven Noonan <steven at uplinklabs.net>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Cc: Matthew Wilcox <willy at linux.intel.com>
> Cc: Jens Axboe <axboe at fb.com>

I have applied this for the current series.

-- 
Jens Axboe
