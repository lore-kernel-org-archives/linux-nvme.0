From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 14 Jan 2016 12:32:32 +0200
Subject: [PATCH v3 06/12] md, dm, scsi, nvme, libnvdimm: drop
 blk_integrity_unregister() at shutdown
In-Reply-To: <20151021171955.6456.83613.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151021171955.6456.83613.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <56977940.8020001@dev.mellanox.co.il>

For the nvme, scsi bits

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
