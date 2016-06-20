From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 Jun 2016 11:44:39 -0400
Subject: [PATCH] nvme: avoid crashes when node 0 is memoryless node.
In-Reply-To: <576739CD.2010002@jp.fujitsu.com>
References: <576739CD.2010002@jp.fujitsu.com>
Message-ID: <20160620154439.GE12936@localhost.localdomain>

On Mon, Jun 20, 2016@09:33:17AM +0900, Masayoshi Mizuma wrote:
> When CONFIG_NUMA is enabled and node 0 is memoryless, the system
> crashes because nvme_probe() sets the device->numa_node to 0 by
> set_dev_node(&pdev->dev, 0), so it tries to allocate memory from node 0.
> To avoid the crash, we should change the 0 to first_memory_node.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma at jp.fujitsu.com>

Thanks for the fix.

Reviewed-by: Keith Busch <keith.busch at intel.com>
