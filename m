From: ming.lei@redhat.com (Ming Lei)
Date: Fri,  9 Aug 2019 18:23:08 +0800
Subject: [PATCH 0/2] genriq/affinity: two improvement on
 __irq_build_affinity_masks
Message-ID: <20190809102310.27246-1-ming.lei@redhat.com>

Hi,

The 1st patch makes __irq_build_affinity_masks() more reliable, such as,
all nodes can be covered in the spread.

The 2nd patch spread vectors on node according to the ratio of this node's
CPU number to number of all remaining CPUs, then vectors assignment can
become more fair. Meantime, the warning report from Jon Derrick can be
fixed.

Please review & comment!

Ming Lei (2):
  genirq/affinity: improve __irq_build_affinity_masks()
  genirq/affinity: spread vectors on node according to nr_cpu ratio

 kernel/irq/affinity.c | 46 +++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 13 deletions(-)

Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: linux-nvme at lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick at intel.com>

-- 
2.20.1
