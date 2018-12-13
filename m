From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 13 Dec 2018 09:28:14 -0600
Subject: [PATCH v2 5/6] nvme-rdma: implement polling queue map
In-Reply-To: <20181213063819.13614-6-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-6-sagi@grimberg.me>
Message-ID: <8ae11687-ad3f-953d-883e-98ac45aecfea@opengridcomputing.com>


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> When passed with nr_poll_queues setup additional queues with cq polling
> context IB_POLL_DIRECT (no interrupts) and make sure to set
> QUEUE_FLAG_POLL on the connect_q. In addition add the third queue
> mapping for polling queues.
>
> nvmf connect on this queue is polled for like all other requests so make
> nvmf_connect_io_queue poll for polling queues.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>


Looks good.

Reviewed-by: Steve Wise <swise at opengridcomputing.com>
