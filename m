From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 17 May 2018 09:44:31 -0600
Subject: [PATCH 1/3] nvme: remove ->cq_vector == -1 check in
 nvme_queue_rq()
In-Reply-To: <2d5e6a8b-b7fb-a0fa-614f-5888fdf0e8be@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
 <1526569337-3489-2-git-send-email-axboe@kernel.dk>
 <20180517153204.GA23555@localhost.localdomain>
 <2d5e6a8b-b7fb-a0fa-614f-5888fdf0e8be@kernel.dk>
Message-ID: <20180517154431.GC23555@localhost.localdomain>

On Thu, May 17, 2018@09:36:58AM -0600, Jens Axboe wrote:
> I'd suggest we just move it to the top and get it out of the way instead,
> and ensure that the ->cq_vector to -1 includes an mb(). Then we can just
> make it:
> 
> if (unlikely(nvmeq->cq_vector < 0))
>         return BLK_STS_IOERR;

Yes, I like that!
