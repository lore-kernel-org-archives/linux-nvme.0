From: axboe@fb.com (Jens Axboe)
Date: Tue, 24 Nov 2015 18:39:54 -0700
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
Message-ID: <5655116A.4060407@fb.com>

On 11/24/2015 04:30 PM, Keith Busch wrote:
> The controller must be disabled prior to completing a presumed lost
> command. This patch makes the shutdown safe to simultaneous invocations
> using mutex, and directly calls shutdown from the timeout handler if
> timeout occurs.
>
> The driver must directly set req->errors to get the appropriate status
> propogated to the caller, since the timeout handler already set the
> targeted request to "complete". The shutdown unconditionally clears
> all outstanding commands, so it is safe to return "EH_HANDLED" from the
> timeout handler and assume the command was completed.

Much better, looks good to me.

-- 
Jens Axboe
