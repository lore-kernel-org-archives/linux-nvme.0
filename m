From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 09:35:27 -0600
Subject: [PATCH] nvme: handle completions outside of the queue lock
In-Reply-To: <20180517153505.GA28489@infradead.org>
References: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>
 <20180517034750.GA22063@localhost.localdomain>
 <20180517071651.GC30079@infradead.org>
 <20180517142159.GC22063@localhost.localdomain>
 <39c39949-1aea-4892-1d80-5ea58d1ced24@kernel.dk>
 <20180517153007.GB19042@infradead.org>
 <6df24c77-bdc8-4265-30ea-8140eedc1fbd@kernel.dk>
 <20180517153505.GA28489@infradead.org>
Message-ID: <62c43a03-a913-5623-1205-e7b8fd8bee9f@kernel.dk>

On 5/17/18 9:35 AM, Christoph Hellwig wrote:
> On Thu, May 17, 2018@09:33:34AM -0600, Jens Axboe wrote:
>> The poll issue is almost moot imho, unless you have a ton of other
>> IO on the same hardware queue while you poll. It'll work fine, the
>> testing I ran didn't find anything. Agree the volatile should have
>> been a prep, but again not really a major thing.
> 
> But it's not a whole lot of work to redo it either.  I'll volunteer
> doing it while spending time on a call :)

Alright, sold :-)

-- 
Jens Axboe
