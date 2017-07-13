From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jul 2017 17:50:03 +0200
Subject: [PATCH rfc 3/3] nvmet-rdma: assign cq completion vector based
 on the port allowed cpus
In-Reply-To: <1499007694-7231-4-git-send-email-sagi@grimberg.me>
References: <1499007694-7231-1-git-send-email-sagi@grimberg.me>
 <1499007694-7231-4-git-send-email-sagi@grimberg.me>
Message-ID: <20170713155003.GB2577@lst.de>

We really shouldn't be doing any of this in NVMe I think.  We'll need
to go back to the cq pool API first.  The last version I had was here:

	http://git.infradead.org/users/hch/rdma.git/shortlog/refs/heads/rdma-cq

and then do the affinity in common code.
