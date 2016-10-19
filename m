From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 15:00:09 +0200
Subject: Disconnecting nvmet-rdma
In-Reply-To: <26c343fe-23a8-e482-0b28-0b4a8c2ac70e@sandisk.com>
References: <26c343fe-23a8-e482-0b28-0b4a8c2ac70e@sandisk.com>
Message-ID: <20161019130009.GA5876@lst.de>

On Tue, Oct 18, 2016@03:02:03PM -0700, Bart Van Assche wrote:
> Hello Christoph,
> 
> Without the patch below I can easily trigger a NULL pointer dereference in
> nvmet_rdma_queue_disconnect(). However, I don't think that that patch is
> correct. Can you have a look at this?

Hi Bart,

how do you reproduce the timedwait condition?  My RDMA test setup is
still being moved, so I can't reproduce it myself, but I'd like to know
for the future.

The only reason why I could see a NULL queue here is if RDMA/CM
also calls the timedwait exit handler for the listener CM ids,
in which case your patch would be correct.  Can you check for that
theory by printing the cm_id address in nvmet_rdma_add_port and in
nvmet_rdma_cm_handler?

Also is there any chance you could try your reproducer with the iSER target
as well?  It also seems to blindly derference the queue.
