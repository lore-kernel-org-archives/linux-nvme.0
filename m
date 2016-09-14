From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Sep 2016 16:47:15 +0200
Subject: [PATCH, RFC] nvme: Do not test the read-ahead flag in cmd_flags
In-Reply-To: <448dce16-78bf-938c-7968-d92006556ecb@fb.com>
References: <30c2c70d-ec2d-607b-3f2f-5b3daa1754cd@sandisk.com>
 <20160914142306.GA28616@lst.de> <448dce16-78bf-938c-7968-d92006556ecb@fb.com>
Message-ID: <20160914144715.GA29336@lst.de>

On Wed, Sep 14, 2016@08:43:48AM -0600, Jens Axboe wrote:
>> It's indeed a bug, but the questions is if why we shouldn't pass
>> REQ_RAHEAD down to the request layer.  It's a useful attribute,
>> and NVMe devices could make use of it.
>
> Indeed, seems a shame to lose this hint.

It currently doesn't work.  But it would be useful to actually pass
it through.  That being said we currently have a complete mess with
the common vs request only flags, both about their placement in the
enum and inclusion in the common mask.  Making it worse it seems
like REQ_NOMERGE actually is used in both currently and not actually
expecting propagation.
