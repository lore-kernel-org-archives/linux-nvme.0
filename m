From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 16 May 2018 17:49:23 +0800
Subject: [PATCH] nvme-rdma: clear NVME_RDMA_Q_LIVE before free the queue
In-Reply-To: <7096b02a-956a-6765-7839-227c154d8336@grimberg.me>
References: <1525420958-9537-1-git-send-email-jianchao.w.wang@oracle.com>
 <7096b02a-956a-6765-7839-227c154d8336@grimberg.me>
Message-ID: <8bba6171-cfe8-3442-7b03-693e34dc096d@oracle.com>

Hi Sagi

On 05/09/2018 11:06 PM, Sagi Grimberg wrote:
> The correct fix would be to add a tag for stop_queue and call
> nvme_rdma_stop_queue() in all the failure cases after
> nvme_rdma_start_queue.

Would you please look at the V2 in following link ?
http://lists.infradead.org/pipermail/linux-nvme/2018-May/017330.html

Thanks in advance
Jianchao
