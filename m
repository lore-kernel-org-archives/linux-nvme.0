From: axboe@fb.com (Jens Axboe)
Date: Wed, 14 Sep 2016 08:43:48 -0600
Subject: [PATCH, RFC] nvme: Do not test the read-ahead flag in cmd_flags
In-Reply-To: <20160914142306.GA28616@lst.de>
References: <30c2c70d-ec2d-607b-3f2f-5b3daa1754cd@sandisk.com>
 <20160914142306.GA28616@lst.de>
Message-ID: <448dce16-78bf-938c-7968-d92006556ecb@fb.com>

On 09/14/2016 08:23 AM, Christoph Hellwig wrote:
> On Wed, Sep 14, 2016@12:02:22PM +0200, Bart Van Assche wrote:
>> REQ_RAHEAD is a bio-only flag (bio.bi_opf) and hence is never set in
>> request.cmd_flags. Hence remove the cmd_flags & REQ_RAHEAD tests.
>> Compile-tested only.
>
> It's indeed a bug, but the questions is if why we shouldn't pass
> REQ_RAHEAD down to the request layer.  It's a useful attribute,
> and NVMe devices could make use of it.

Indeed, seems a shame to lose this hint.


-- 
Jens Axboe
