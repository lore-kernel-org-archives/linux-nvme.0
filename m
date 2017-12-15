From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 14 Dec 2017 22:45:50 -0500
Subject: [PATCH] nvme: Check hw sectors before setting chunk sectors
In-Reply-To: <20171214182014.4715-1-keith.busch@intel.com> (Keith Busch's
 message of "Thu, 14 Dec 2017 11:20:14 -0700")
References: <20171214182014.4715-1-keith.busch@intel.com>
Message-ID: <yq1o9n0mz69.fsf@oracle.com>


Keith,

> Some devices with IDs matching the "stripe" quirk don't actually have
> this quirk, and don't have an MDTS value. When MDTS is not set, the
> driver sets the max sectors to UINT_MAX, which is not a power of 2,
> hitting a BUG_ON from blk_queue_chunk_sectors. This patch skips
> setting chunk sectors for such devices.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
