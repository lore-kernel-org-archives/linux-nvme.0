From: keith.busch@intel.com (Keith Busch)
Date: Fri, 5 Jun 2015 16:22:14 +0000 (UTC)
Subject: [PATCH] NVMe: Add reset controller sysfs entry
In-Reply-To: <5571C373.80808@fb.com>
References: <D195D453.84EA%brandon.schulz@hgst.com>
 <alpine.LNX.2.00.1506041518030.15930@localhost.lm.intel.com>
 <20150604153909.GA18137@infradead.org> <5570AE5E.6030407@fb.com>
 <5570B149.3050901@fb.com>
 <alpine.LNX.2.00.1506042142310.15930@localhost.lm.intel.com>
 <5571C373.80808@fb.com>
Message-ID: <alpine.LNX.2.00.1506051614280.15930@localhost.lm.intel.com>

On Fri, 5 Jun 2015, Jens Axboe wrote:
> On 06/04/2015 04:08 PM, Keith Busch wrote:
>> Thanks for fixing the merge. This tests successfully on my machine. I
>> didn't have a strong opinion either way on what a user sees when
>> requesting resets while a reset is in progress, and what you've merged
>> looks good to me.
>
> Great, thanks Keith. Can I add your signed-off-by? It'd be most fair to 
> attribute the patch to you, since the ioctl part is now just calling your 
> reset function and all I did was shuffle some stuff around.

Sounds good to me. Thanks!
