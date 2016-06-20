From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 20 Jun 2016 09:08:34 +0200
Subject: [PATCH] nvme: avoid crashes when node 0 is memoryless node.
In-Reply-To: <576739CD.2010002@jp.fujitsu.com>
References: <576739CD.2010002@jp.fujitsu.com>
Message-ID: <20160620070834.bt4y6d52iazsexyd@c203.arch.suse.de>

On Mon, Jun 20, 2016@09:33:17AM +0900, Masayoshi Mizuma wrote:
> When CONFIG_NUMA is enabled and node 0 is memoryless, the system
> crashes because nvme_probe() sets the device->numa_node to 0 by
> set_dev_node(&pdev->dev, 0), so it tries to allocate memory from node 0.
> To avoid the crash, we should change the 0 to first_memory_node.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma at jp.fujitsu.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
