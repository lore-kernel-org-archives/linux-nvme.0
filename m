From: axboe@fb.com (Jens Axboe)
Date: Fri, 30 Nov 2018 15:20:51 +0000
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <20181130075603.GA18936@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <c20e4d66-0fc5-ab65-2805-c4b22012c1c5@fb.com> <20181130075603.GA18936@lst.de>
Message-ID: <9b289631-6c4f-e410-f63c-d1e1f54dc1c5@fb.com>

On 11/30/18 12:56 AM, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018@07:50:09PM +0000, Jens Axboe wrote:
>>> in our post-spectre world.  Also having too many queue type is just
>>> going to create confusion, so I'd rather manage them centrally.
>>>
>>> Note that the queue type naming and ordering changes a bit - the
>>> first index now is the defauly queue for everything not explicitly
>>                          ^^^^^^^
>>
>> default
> 
> Fixed.
> 
>> Side not, should probably make the sysfs 'type' attribute a string
>> at this point.
> 
> Fixed as well.

Thanks - are you going to post a v3? Would like to get this staged.


-- 
Jens Axboe
