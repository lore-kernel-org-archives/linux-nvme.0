From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 29 May 2018 11:26:42 -0700
Subject: [PATCH v3 0/3] NVMF/RDMA 16K Inline Support
Message-ID: <cover.1527618402.git.swise@opengridcomputing.com>

Hey,

For small nvmf write IO over the rdma transport, it is advantagous to
make use of inline mode to avoid the latency of the target issuing an
rdma read to fetch the data.  Currently inline is used for <= 4K writes.
8K, though, requires the rdma read.  For iWARP transports additional
latency is incurred because the target mr of the read must be registered
with remote write access.  By allowing 2 pages worth of inline payload,
I see a reduction in 8K nvmf write latency of anywhere from 2-7 usecs
depending on the RDMA transport..

This series is a respin of a series floated last year by Parav and Max
[1].  I'm continuing it now and have addressed some of the comments from
their submission [2].

Changes since RFC v2:

- Removed RFC tag

- prefix the inline_data_size configfs attribute with param_

- implementation/formatting tweaks suggested by Christoph

- support inline_data_size of 0, which disables inline data use

- added a new patch to fix the check for keyed sgls (bit 2 instead of 20).

- check the inline_data bit (bit 20 in the ctrl.sgls field) when
connecting and only use inline if it was set for that device.

- added Christoph's review-by tag for patch 1

[1] Original submissions:
http://lists.infradead.org/pipermail/linux-nvme/2017-February/008057.html
http://lists.infradead.org/pipermail/linux-nvme/2017-February/008059.html


[2] These comments from [1] have been addressed:

- nvme-rdma: Support up to 4 segments of inline data.

- nvme-rdma: Cap the number of inline segments to not exceed device limitations.

- nvmet-rdma: Make the inline data size configurable in nvmet-rdma via configfs.

Other issues from [1] that I don't plan to incorporate into the series:

- nvme-rdma: make the sge array for inline segments dynamic based on the
target's advertised inline_data_size.  Since we're limiting the max count
to 4, I'm not sure this is worth the complexity of allocating the sge array
vs just embedding the max.

- nvmet-rdma: concern about high order page allocations.  Is 4 pages
too high?  One possibility is that, if the device max_sge allows, use
a few more sges.  IE 16K could be 2 8K sges, or 4 4K.  This probably makes
passing the inline data to bio more complex.  I haven't looked into this
yet.

- nvmet-rdma: reduce the qp depth if the inline size greatly increases
the memory footprint.  I'm not sure how to do this in a reasonable mannor.
Since the inline data size is now configurable, do we still need this?

- nvmet-rdma: make the qp depth configurable so the admin can reduce it
manually to lower the memory footprint.

Steve Wise (3):
  nvme-rdma: correctly check for target keyed sgl support
  nvme-rdma: support up to 4 segments of inline data
  nvmet-rdma: support 16K inline data

 drivers/nvme/host/rdma.c        | 43 +++++++++++++++++++++++++++------------
 drivers/nvme/target/admin-cmd.c |  4 ++--
 drivers/nvme/target/configfs.c  | 31 ++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  4 ++++
 drivers/nvme/target/discovery.c |  2 +-
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/rdma.c      | 45 ++++++++++++++++++++++++++++-------------
 7 files changed, 100 insertions(+), 31 deletions(-)

-- 
1.8.3.1
