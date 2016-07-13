From: m.mizuma@jp.fujitsu.com (Masayoshi Mizuma)
Date: Wed, 13 Jul 2016 15:13:11 +0900
Subject: [PATCH] nvme: avoid crashes when node 0 is memoryless node.
In-Reply-To: <20160620154439.GE12936@localhost.localdomain>
References: <576739CD.2010002@jp.fujitsu.com>
 <20160620154439.GE12936@localhost.localdomain>
Message-ID: <5785DBF7.600@jp.fujitsu.com>


Keith and Johannes, thank you for reviewing!

Jens, please add this patch for 4.8.

- Masayoshi Mizuma

On Mon, 20 Jun 2016 11:44:39 -0400 Keith Busch wrote:
> On Mon, Jun 20, 2016@09:33:17AM +0900, Masayoshi Mizuma wrote:
>> When CONFIG_NUMA is enabled and node 0 is memoryless, the system
>> crashes because nvme_probe() sets the device->numa_node to 0 by
>> set_dev_node(&pdev->dev, 0), so it tries to allocate memory from node 0.
>> To avoid the crash, we should change the 0 to first_memory_node.
>>
>> Signed-off-by: Masayoshi Mizuma <m.mizuma at jp.fujitsu.com>
>
> Thanks for the fix.
>
> Reviewed-by: Keith Busch <keith.busch at intel.com>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
