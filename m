From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Jan 2016 16:48:53 +0000
Subject: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <1452416389-19664-3-git-send-email-sagig@mellanox.com>
References: <1452416389-19664-1-git-send-email-sagig@mellanox.com>
 <1452416389-19664-3-git-send-email-sagig@mellanox.com>
Message-ID: <20160115164853.GB11165@localhost.localdomain>

On Sun, Jan 10, 2016@10:59:48AM +0200, Sagi Grimberg wrote:
> blk-mq offers a tagset iterator so let's use that
> instead of using nvme_clear_queues.
> 
> Note, we changed nvme_queue_cancel_ios name to nvme_cancel_io
> as there is no concept of a queue now in this function (we
> also lost the print).
> 
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Looks good to me.

Acked-by: Keith Busch <keith.busch at intel.com>
