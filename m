From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Apr 2017 18:25:13 -0400
Subject: [PATCH 1/2] nvme: enable SG gaps support
In-Reply-To: <1491948109-9224-1-git-send-email-maxg@mellanox.com>
References: <1491948109-9224-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170411222512.GB623@localhost.localdomain>

On Wed, Apr 12, 2017@01:01:48AM +0300, Max Gurtovoy wrote:
> For controllers that can handle arbitrarily sized bios (e.g advanced
> RDMA ctrls) we can allow the block layer to pass us gaps by skip
> setting the queue virt_boundary.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Looks fine.

Reviewed-by: Keith Busch <keith.busch at intel.com>
