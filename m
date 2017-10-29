From: hch@lst.de (Christoph Hellwig)
Date: Sun, 29 Oct 2017 09:57:52 +0100
Subject: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
In-Reply-To: <99f3c781-71ce-f915-d6f4-88d6dd115876@huawei.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com>
 <20171028063825.GA14261@lst.de>
 <dc988a8a-8c88-fe20-34a0-de5cdd615b6b@huawei.com>
 <20171028074245.GA15510@lst.de>
 <99f3c781-71ce-f915-d6f4-88d6dd115876@huawei.com>
Message-ID: <20171029085751.GA8793@lst.de>

On Sat, Oct 28, 2017@06:09:46PM +0800, Guan Junxiong wrote:
> Does it mean some extra works such as:
> 1) showing the path topology of nvme multipath device

It's in sysfs.  And Johannes volunteered to also add nvme-cli
support.

> 2) daemon to implement immediate and delayed failback

The whole point is to not have a daemon.

> 3) detecting sub-healthy path due to shaky link

We can do this in kernel space.  It just needs someone to implement it.

> 4) grouping paths besides ANA

We don't want to do non-standard grouping.  Please work with the
NVMe working group for your grouping ideas.
