From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 13 Dec 2018 09:26:36 -0600
Subject: [PATCH v2 4/6] nvme-fabrics: allow user to pass in nr_poll_queues
In-Reply-To: <20181213063819.13614-5-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-5-sagi@grimberg.me>
Message-ID: <19dbe333-55cb-d16c-f9b3-4aa2b1ce2ca1@opengridcomputing.com>


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> This argument will specify how many polling I/O queues
> to connect when creating the controller. These I/O queues
> will host I/O that is set with REQ_HIPRI.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Is there a default if none is specified on the 'nvme connect' command?

Reviewed-by: Steve Wise <swise at opengridcomputing.com>
