From: hch@lst.de (Christoph Hellwig)
Date: Fri, 30 Nov 2018 08:56:03 +0100
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <c20e4d66-0fc5-ab65-2805-c4b22012c1c5@fb.com>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <c20e4d66-0fc5-ab65-2805-c4b22012c1c5@fb.com>
Message-ID: <20181130075603.GA18936@lst.de>

On Thu, Nov 29, 2018@07:50:09PM +0000, Jens Axboe wrote:
> > in our post-spectre world.  Also having too many queue type is just
> > going to create confusion, so I'd rather manage them centrally.
> > 
> > Note that the queue type naming and ordering changes a bit - the
> > first index now is the defauly queue for everything not explicitly
>                          ^^^^^^^
> 
> default

Fixed.

> Side not, should probably make the sysfs 'type' attribute a string
> at this point.

Fixed as well.
