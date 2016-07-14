From: axboe@fb.com (Jens Axboe)
Date: Thu, 14 Jul 2016 08:51:45 -0700
Subject: [PATCH v4] nvme: Remove RCU namespace protection
In-Reply-To: <1468431902-9699-1-git-send-email-keith.busch@intel.com>
References: <1468431902-9699-1-git-send-email-keith.busch@intel.com>
Message-ID: <5787B511.2010107@fb.com>

On 07/13/2016 10:45 AM, Keith Busch wrote:
> We can't sleep with RCU read lock held, but we need to do potentially
> blocking stuff to namespace queues when iterating the list. This patch
> removes the RCU locking and holds a mutex instead.
>
> To prevent deadlocks, this patch removes holding the mutex during
> namespace scanning and removal. The unlocked namespace scanning is made
> safe by holding a reference to the namespace being scanned.
>
> List iteration that does IO has to be unlocked to allow error recovery.
> The caller must ensure the list can not be manipulated during such an
> event, so this patch adds a comment explaining this requirement to the
> only function that iterates an unlocked list. All callers currently
> meet this requirement, so no further changes required.
>
> List iterations that do not do IO can safely use the lock since it couldn't
> block recovery from missing forced IO completions.

Added for 4.7. And thankfully, looks like we're dodging most of the 
merging bullet here.

-- 
Jens Axboe
