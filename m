From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 6 Jun 2018 08:19:53 -0600
Subject: [PATCH 2/6] nvme-pci: Remove unnecessary completion doorbell check
In-Reply-To: <20180606141309.19389-3-keith.busch@intel.com>
References: <20180606141309.19389-1-keith.busch@intel.com>
 <20180606141309.19389-3-keith.busch@intel.com>
Message-ID: <c6357b43-1347-0768-2401-e332f3d42e85@kernel.dk>

On 6/6/18 8:13 AM, Keith Busch wrote:
> The nvme pci driver never unmaps the doorbell registers while the requests
> are active, so we can always safely update the completion queue head.

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
