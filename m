From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 19 Nov 2018 08:19:07 -0700
Subject: [PATCH 3/7] nvme-fc: remove unused poll implementation
In-Reply-To: <20181119075904.GC9622@infradead.org>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-4-axboe@kernel.dk> <20181119075904.GC9622@infradead.org>
Message-ID: <5badecdb-cd80-c1ab-bb9d-72880800bb1c@kernel.dk>

On 11/19/18 12:59 AM, Christoph Hellwig wrote:
> On Sat, Nov 17, 2018@02:43:50PM -0700, Jens Axboe wrote:
>> This relies on the fc taget ops setting ->poll_queue, which
>> nobody does. Otherwise it just checks if something has
>> completed, which isn't very useful.
> 
> Please also remove the unused ->poll_queue method.
> 
> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Sure, will do.

-- 
Jens Axboe
