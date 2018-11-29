From: axboe@fb.com (Jens Axboe)
Date: Thu, 29 Nov 2018 19:50:09 +0000
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <20181129191310.9795-2-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
Message-ID: <c20e4d66-0fc5-ab65-2805-c4b22012c1c5@fb.com>

On 11/29/18 12:12 PM, Christoph Hellwig wrote:
> Having another indirect all in the fast path doesn't really help
> in our post-spectre world.  Also having too many queue type is just
> going to create confusion, so I'd rather manage them centrally.
> 
> Note that the queue type naming and ordering changes a bit - the
> first index now is the defauly queue for everything not explicitly
                         ^^^^^^^

default

> marked, the optional ones are read and poll queues.

Looks fine to me, was hoping NOT to bring this into the core, but
I guess it might be more manageable there in the long run. And it's
hard to argue with getting rid of the flags_to_type indirect.

Side not, should probably make the sysfs 'type' attribute a string
at this point.

-- 
Jens Axboe
