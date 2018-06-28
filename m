From: hch@lst.de (Christoph Hellwig)
Date: Thu, 28 Jun 2018 16:30:54 +0200
Subject: [PATCH 4.18-rc] nvme-rdma: fix possible double free of
 controller async event buffer
In-Reply-To: <20180625175817.6739-1-sagi@grimberg.me>
References: <20180625175817.6739-1-sagi@grimberg.me>
Message-ID: <20180628143054.GA16547@lst.de>

On Mon, Jun 25, 2018@08:58:17PM +0300, Sagi Grimberg wrote:
> If reconnect/reset failed where the controller async event buffer
> was freed, we might end up freeing it again as we call
> nvme_rdma_destroy_admin_queue again in the remove path. Given that
> the sequence is guaranteed to serialize by .ctrl_stop, we simply
> set ctrl->async_event_sqe.data to NULL and don't free it in future
> visits.

Thanks,

applied to nvme-4.18.
