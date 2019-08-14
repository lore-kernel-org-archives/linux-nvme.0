From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 14 Aug 2019 16:40:41 +0800
Subject: [PATCH V4 0/3] genriq/affinity: Make vectors allocation fair
Message-ID: <20190814084044.21699-1-ming.lei@redhat.com>

Hi,

The 1st  patch enhances one warning check.

The 2nd patch makes __irq_build_affinity_masks() more reliable, such as,
all nodes can be covered in the spread.

The 3rd patch spread vectors on node according to the ratio of this node's
CPU number to number of all remaining CPUs, then vectors assignment can
become more fair. Meantime, the warning report from Jon Derrick can be
fixed.

Please review & comment!

V4:
	- provide proof why number of allocated vectors for each node is <= CPU
	  count of this node

V3:
	- re-order the patchset
	- add helper of irq_spread_vectors_on_node()
	- handle vector spread correctly in case that numvecs is > ncpus
	- return -ENOMEM to API's caller

V2:
	- add patch3
	- start to allocate vectors from node with minimized CPU number,
	  then every node is guaranteed to be allocated at least one vector.
	- avoid cross node spread


Ming Lei (3):
  genirq/affinity: Enhance warning check
  genirq/affinity: Improve __irq_build_affinity_masks()
  genirq/affinity: Spread vectors on node according to nr_cpu ratio

 kernel/irq/affinity.c | 243 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 209 insertions(+), 34 deletions(-)

Cc: Jens Axboe <axboe at kernel.dk>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: linux-nvme at lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick at intel.com>
-- 
2.20.1
