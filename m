From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 17 Oct 2017 23:55:33 -0700
Subject: v4.14-rc5 NVMeOF regression?
In-Reply-To: <07f75a37-cd25-81c1-3264-2be80bb9a763@grimberg.me>
References: <1508192588.2493.60.camel@wdc.com>
 <82de6177-27f5-463e-3446-0305fd9f6790@grimberg.me>
 <5fb38923-36f7-c069-5f1d-96f4a9c98248@wdc.com>
 <07f75a37-cd25-81c1-3264-2be80bb9a763@grimberg.me>
Message-ID: <20171018065533.GA7694@infradead.org>

On Wed, Oct 18, 2017@08:26:05AM +0300, Sagi Grimberg wrote:
> > Additionally, can you explain to me why you think the above patch is
> > necessary? As far as I can see nvme_rdma_ctrl_mutex is not held around
> > the ib_register_client(&nvme_rdma_ib_client) call nor around the
> > ib_unregister_client(&nvme_rdma_ib_client) calls.
> 
> Its held under ib_unregister_client, my understanding is that the
> _nested annotation is required for the inner mutex lock acquire.

No.  Anytime we take a single lock out of order it is a bug an a
potential deadlock.  _nested only works if we have multiple instances
of a lock (say in each inode) and we have a well defined ordering
between the instances (e.g. by the address of the inode structure).
