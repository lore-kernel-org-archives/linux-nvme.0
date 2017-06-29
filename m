From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Jun 2017 16:53:10 +0200
Subject: [PATCH 5/7] nvme-rdma: update tagset nr_hw_queues after
 reconnecting/resetting
In-Reply-To: <1498734552-14845-6-git-send-email-sagi@grimberg.me>
References: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
 <1498734552-14845-6-git-send-email-sagi@grimberg.me>
Message-ID: <20170629145310.GE18028@lst.de>

On Thu, Jun 29, 2017@02:09:10PM +0300, Sagi Grimberg wrote:
> We might have more/less queues once we reconnect/reset. For
> example due to cpu going online/offline or controller constraints.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
