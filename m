From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Fri, 21 Oct 2016 15:21:38 +0000
Subject: Disconnecting nvmet-rdma
In-Reply-To: <20161019130009.GA5876@lst.de>
References: <26c343fe-23a8-e482-0b28-0b4a8c2ac70e@sandisk.com>
 <20161019130009.GA5876@lst.de>
Message-ID: <1477063296.2384.1.camel@sandisk.com>

On Wed, 2016-10-19@15:00 +0200, Christoph Hellwig wrote:
> On Tue, Oct 18, 2016@03:02:03PM -0700, Bart Van Assche wrote:
> > Without the patch below I can easily trigger a NULL pointer
> > dereference in
> > nvmet_rdma_queue_disconnect(). However, I don't think that that
> > patch is
> > correct. Can you have a look at this?
> 
> how do you reproduce the timedwait condition???My RDMA test setup is
> still being moved, so I can't reproduce it myself, but I'd like to
> know for the future.

Hello Christoph and Sagi,

This issue is something I could reproduce easily about ten days ago.
However, when I removed the "if (queue)" change from my tree I could
not reproduce this issue with the current version of my NVMeOF test
script. I will try to figure out whether I can trigger this by going
back to a previous version of my test script.

Bart.
