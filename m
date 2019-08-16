From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 16 Aug 2019 10:28:47 +0800
Subject: [PATCH V5 0/2] genriq/affinity: Make vectors allocation fair
Message-ID: <20190816022849.14075-1-ming.lei@redhat.com>

Hi Thomas,

The 1st patch makes __irq_build_affinity_masks() more reliable, such as,
all nodes can be covered in the spread.

The 2nd patch spread vectors on node according to the ratio of this node's
CPU number to number of all remaining CPUs, then vectors assignment can
become more fair. Meantime, the warning report from Jon Derrick can be
fixed.

Please consider it for V5.4.

V5:
	- remove patch 1 of V4, which is wrong
	- handle vector wrapping because the 'start vector' may begin
	  anywhere, especially for the 2nd stage spread
	- add more comment on the vector allocation algorithm
	- cleanup code a bit
	- run more tests to verify the change, which always get the
	expected result. Covers lots of num_queues, numa topo, CPU
	unpresent setting.

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

Ming Lei (2):
  genirq/affinity: Improve __irq_build_affinity_masks()
  genirq/affinity: Spread vectors on node according to nr_cpu ratio

 kernel/irq/affinity.c | 215 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 194 insertions(+), 21 deletions(-)

Cc: Jens Axboe <axboe at kernel.dk>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: linux-nvme at lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick at intel.com>

-- 
2.20.1
