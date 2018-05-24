From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 May 2018 10:04:15 +0200
Subject: [PATCH] nvmet: allow file backed ns to use cache
In-Reply-To: <20180523220016.6500-1-chaitanya.kulkarni@wdc.com>
References: <20180523220016.6500-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180524080415.GB11149@lst.de>

I think this is mixing up two different issues - not using O_DIRECT
vs using O_SYNC.  The first seems to useful to deal with things
like VDI setup, the latter doesn't really seem useful at all.

Note that for buffered I/O the kernel doesn't support asynch I/O,
so we really want to offload to a workqueue, except for posisbly
trying a RWF_NOWAIT attempt for reads first.
