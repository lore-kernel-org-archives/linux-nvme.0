From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 May 2018 09:00:27 -0700
Subject: [PATCH 1/3] nvme: remove ->cq_vector == -1 check in
 nvme_queue_rq()
In-Reply-To: <9a0870ac-a16b-6f51-b4bd-06d2763dfc0e@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
 <1526569337-3489-2-git-send-email-axboe@kernel.dk>
 <20180517153204.GA23555@localhost.localdomain>
 <2d5e6a8b-b7fb-a0fa-614f-5888fdf0e8be@kernel.dk>
 <0e84a488-30cb-ec5e-95a6-65f0a9722a50@kernel.dk>
 <20180517155218.GD23555@localhost.localdomain>
 <9a0870ac-a16b-6f51-b4bd-06d2763dfc0e@kernel.dk>
Message-ID: <20180517160027.GA659@infradead.org>

On Thu, May 17, 2018@09:52:48AM -0600, Jens Axboe wrote:
> Christoph, let me know if you want me to post the whole series for your
> reshuffling. It's what's on:
> 
> http://git.kernel.dk/cgit/linux-block/log/?h=nvme-4.18

I'll cherry pick that in.
