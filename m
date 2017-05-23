From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 23 May 2017 00:20:08 -0700
Subject: [PATCH 0/8] nvme_fc: add dev_loss_tmo support
In-Reply-To: <20170513190722.25536-1-jsmart2021@gmail.com>
References: <20170513190722.25536-1-jsmart2021@gmail.com>
Message-ID: <20170523072008.GB31698@infradead.org>

On Sat, May 13, 2017@12:07:14PM -0700, James Smart wrote:
> As the fabrics implementation already has a similar behavior
> introduced on rdma, the ctrl_loss_tmo, which may be set on a
> controller basis (finer granularity than the FC port used for the
> connection), the nvme_fc transport will mediate and choose the lesser
> of the controllers value and the remoteports value.

I would much prefer if nvme-fc could stick to the same controller
concept as rdma.  Especially as it needs to be synchronized with
the reconnect delay and the keep alive timeout (and we need to
do a better job on synchronize the latter to start with I think).
