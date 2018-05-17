From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 10:36:23 -0600
Subject: RFC: handle completions outside the queue lock and split the
 queue lock
In-Reply-To: <20180517163152.23155-1-hch@lst.de>
References: <20180517163152.23155-1-hch@lst.de>
Message-ID: <53c0cd3f-2683-0142-cf7e-b28122aaf5db@kernel.dk>

On 5/17/18 10:31 AM, Christoph Hellwig wrote:
> Mostly the previous work from Jens, just with random cleanups from me
> thrown in.  Based on nvme/nvme-4.18 minus the two top-most commits,
> very lightly tested.

Looks good to me, 1+2 are fine as prep patches. You can add my
Reviewed-by to those.

You messed up the attributions on 5+6 though.

-- 
Jens Axboe
