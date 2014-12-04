From: axboe@fb.com (Jens Axboe)
Date: Wed, 3 Dec 2014 19:08:46 -0700
Subject: [PATCH] NVMe: Fix command setup on IO retry
In-Reply-To: <1417651633-16862-1-git-send-email-keith.busch@intel.com>
References: <1417651633-16862-1-git-send-email-keith.busch@intel.com>
Message-ID: <547FC22E.7010609@fb.com>

On 12/03/2014 05:07 PM, Keith Busch wrote:
> On retry, the req->special is pointing to an already setup IOD, but we
> still need to setup the command context and callback, otherwise you'll
> see false twice completed errors and leak requests.

Good catch!

I'll queue this up for 3.19.

-- 
Jens Axboe
