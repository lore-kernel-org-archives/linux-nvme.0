From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:27:56 +0100
Subject: [PATCH v2 3/6] nvme-fabrics: allow nvmf_connect_io_queue to poll
In-Reply-To: <20181213063819.13614-4-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-4-sagi@grimberg.me>
Message-ID: <20181213082756.GC869@lst.de>

On Wed, Dec 12, 2018@10:38:15PM -0800, Sagi Grimberg wrote:
> Preparation for polling support for fabrics. Polling support
> means that our completion queues are not generating any interrupts
> which means we need to poll for the nvmf io queue connect as well.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
