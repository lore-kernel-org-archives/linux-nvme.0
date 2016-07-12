From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 12 Jul 2016 16:15:13 -0700
Subject: [PATCHv3 for-4.7] nvme: Remove RCU namespace protection
In-Reply-To: <20160709010754.GA28997@localhost.localdomain>
References: <1467825770-27355-1-git-send-email-keith.busch@intel.com>
 <20160709010754.GA28997@localhost.localdomain>
Message-ID: <57857A01.1080004@kernel.dk>

On 07/08/2016 06:07 PM, Keith Busch wrote:
> On Wed, Jul 06, 2016@11:22:50AM -0600, Keith Busch wrote:
>> We can't block with RCU read lock held, but we need to do potentially
>> blocking stuff to namespace queues when iterating the list. This patch
>> removes the rcu read locking.
>>
>> Any list iteration that does IO has to be done unlocked to allow recovery.
>> The caller must ensure the list can not be manipulated under such
>> conditions. List iterations that do not issue IO can safely use the lock
>> since it wouldn't block recovery from missing IO completions.
>
> Ping? Would hate to release a kernel with obvious bugs.

I'm going back and forth on this... This isn't a regression for 4.7, is 
it? If so, I'd be a lot more comfortable queuing this up for 4.8 (marked 
stable) instead. It'll be another late addition, causing issues when it 
comes time to merge for-4.8/drivers in the next merge window.

-- 
Jens Axboe
