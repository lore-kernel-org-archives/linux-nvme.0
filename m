From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Sep 2018 16:27:45 -0700
Subject: nvmet: Kernel v4.19-rc4 circular locking complaint
In-Reply-To: <1537465780.224533.19.camel@acm.org>
References: <1537465780.224533.19.camel@acm.org>
Message-ID: <20180925232745.GA28388@infradead.org>

On Thu, Sep 20, 2018@10:49:40AM -0700, Bart Van Assche wrote:
> Hello,
> 
> Here is another complaint that appeared while running the nvmeof-mp tests.
> Sagi, I have Cc-ed you because I think that this complaint may be related
> to the flush_scheduled_work() call that was inserted in
> nvmet_rdma_queue_connect() by commit 777dc82395de ("nvmet-rdma: occasionally
> flush ongoing controller teardown"). It seems weird to me that work is
> flushed from the context of an RDMA/CM handler, which is running in the
> context of a work item itself.

Yes, this seems pretty dangerous.  For now I'm tempted to revert the
commit.  Sagi?
