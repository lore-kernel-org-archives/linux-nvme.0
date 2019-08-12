From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 12 Aug 2019 17:57:06 +0800
Subject: [PATCH V2 0/3] genriq/affinity: Make vectors allocation fair
Message-ID: <20190812095709.25623-1-ming.lei@redhat.com>

Hi,

The 1st patch makes __irq_build_affinity_masks() more reliable, such as,
all nodes can be covered in the spread.

The 2nd patch spread vectors on node according to the ratio of this node's
CPU number to number of all remaining CPUs, then vectors assignment can
become more fair. Meantime, the warning report from Jon Derrick can be
fixed.

The 3rd patch enhances one warning check.

Please review & comment!


V2:
	- add patch3
	- start to allocate vectors from node with minimized CPU number,
	  then every node is guaranteed to be allocated at least one vector.
	- avoid cross node spread

Ming Lei (3):
  genirq/affinity: Improve __irq_build_affinity_masks()
  genirq/affinity: Spread vectors on node according to nr_cpu ratio
  genirq/affinity: Enhance warning check

 kernel/irq/affinity.c | 140 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 121 insertions(+), 19 deletions(-)

Cc: Jens Axboe <axboe at kernel.dk>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: linux-nvme at lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick at intel.com>
-- 
2.20.1
