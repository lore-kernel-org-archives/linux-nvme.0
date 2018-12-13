From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 13 Dec 2018 09:29:54 -0600
Subject: [PATCH v2 nvme-cli 7/6] fabrics: pass in number of polling queues
In-Reply-To: <20181213063819.13614-8-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-8-sagi@grimberg.me>
Message-ID: <f9731fb3-ac83-296c-609a-cff7c6261091@opengridcomputing.com>


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> nr_poll_queues specifies the number of additional queues that will
> be connected for hosting polling latency critical I/O.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>


Looks good.

Signed-off-by: Steve Wise <swise at opengridcomputing.com
