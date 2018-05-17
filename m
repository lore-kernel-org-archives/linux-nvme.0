From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 May 2018 18:44:58 +0200
Subject: RFC: handle completions outside the queue lock and split the
 queue lock
In-Reply-To: <53c0cd3f-2683-0142-cf7e-b28122aaf5db@kernel.dk>
References: <20180517163152.23155-1-hch@lst.de>
 <53c0cd3f-2683-0142-cf7e-b28122aaf5db@kernel.dk>
Message-ID: <20180517164458.GA4565@lst.de>

On Thu, May 17, 2018@10:36:23AM -0600, Jens Axboe wrote:
> On 5/17/18 10:31 AM, Christoph Hellwig wrote:
> > Mostly the previous work from Jens, just with random cleanups from me
> > thrown in.  Based on nvme/nvme-4.18 minus the two top-most commits,
> > very lightly tested.
> 
> Looks good to me, 1+2 are fine as prep patches. You can add my
> Reviewed-by to those.
> 
> You messed up the attributions on 5+6 though.

Sigh.  I don't know why, but everytime git sees a conflict during
rebase I get these messed up.  I blame it on Linus..

> 
> -- 
> Jens Axboe
---end quoted text---
