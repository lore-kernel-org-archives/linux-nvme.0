From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 13 Dec 2018 09:25:00 -0600
Subject: [PATCH v2 3/6] nvme-fabrics: allow nvmf_connect_io_queue to poll
In-Reply-To: <20181213063819.13614-4-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-4-sagi@grimberg.me>
Message-ID: <89faa415-cbbb-d3d1-10f5-5eca509f1479@opengridcomputing.com>


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> Preparation for polling support for fabrics. Polling support
> means that our completion queues are not generating any interrupts
> which means we need to poll for the nvmf io queue connect as well.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good.

Reviewed by Steve Wise <swise at opengridcomputing.com>
