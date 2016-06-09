From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Jun 2016 16:10:12 +0200
Subject: [PATCH 2/2] nvme-rdma: check the number of hw queues mapped
In-Reply-To: <575950DB.6080701@lightbits.io>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
 <1465415292-9416-3-git-send-email-mlin@kernel.org>
 <575950DB.6080701@lightbits.io>
Message-ID: <20160609141012.GB30293@lst.de>

On Thu, Jun 09, 2016@02:19:55PM +0300, Sagi Grimberg wrote:
> This needs documentation in the form of:
>
> /*
>  * XXX: blk-mq might not map all our hw contexts but this is a must for
>  * us for fabric connects. So until we can fix blk-mq we check that.
>  */

I think the right thing to do is to have a member of actually mapped
queues in the block layer, and I also don't think we need the XXX comment
as there are valid reasons for not mapping all queues.
