From: axboe@fb.com (Jens Axboe)
Date: Tue, 21 Feb 2017 19:42:55 -0700
Subject: [PATCHv4 0/4] OPAL patches, cont'd
In-Reply-To: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <a75babc1-5a9d-2979-514a-5fea19370084@fb.com>

On 02/21/2017 11:59 AM, Jon Derrick wrote:
> v3->v4:
> Passes in 'lock_held' into opal_lock_unlock() so we don't need to
> mutex_trylock(). I wasn't totally confident in that approach anyways.
> 
> v2->v3:
> Squashed 5/5 into 4/5
> Changed opal_step structs back to const
> Cleaned up opal_lock_unlock
> 
> v1->v2:
> Moved misplaced code from 5/5 to 4/5

Guys, where are we at with this? I'm shipping off some more fixes
for -rc1 soon, and I'd really like to get this wrapped up sooner
rather than later.

-- 
Jens Axboe
