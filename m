From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 19 Jun 2018 12:09:55 -0700
Subject: [PATCH v5 0/2] NVMF/RDMA 16K Inline Support
Message-ID: <cover.1529435395.git.swise@opengridcomputing.com>

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

The below performance improvements are achieved.  Applications doing
8K or 16K WRITEs will benefit most from this enhancement.

WRITE IOPS:
8 nullb devices, 16 connections/device,
16 cores, 1 host, 1 target,
fio randwrite, direct io, ioqdepth=256, jobs=16

             %CPU Idle                   KIOPS        
inline size  4K        8K        16K     4K        8K        16K
io size 
4K            9.36     10.47     10.44   1707      1662      1704
8K           39.07     43.66     46.84    894      1000      1002
16K          64.15     64.79     71.1     566      569        607
32K          78.84     79.5      79.89    326      329        327

WRITE Latency:
1 nullb device, 1 connection/device,
fio randwrite, direct io, ioqdepth=1, jobs=1                                                

             Usecs                                        
inline size  4K        8K        16K                                
io size                                                        
4K           12.4      12.4      12.5                                
8K           18.3      13        13.1                                
16K          20.3      20.2      14.2                                
32K          23.2      23.2      23.4                                

Changes since v4:

- rebased on 4.18-rc1.

- add perf results to cover letter.

- removed patch 1 - it has been merged.

Changes since v3:

- nvme-rdma: remove pr_debug.

- nvme-rdma: add Sagi's reviewed-by tag.

- nvmet-rdma: avoid > order 0 page allocations for inline data bufffers
by using multiple sges.  If the device cannot support the required sge
depth then reduce the inline data size to fit.

- nvmet-rdma: set max_recv_sge correctly

- nvmet-rdma: if the configured inline data size exceeds the max
supported by the rdma transport, a warning is logged and the size
is reduced.

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

- nvmet-rdma: avoid > 0 order page allocations

Other issues from [1] that I don't plan to incorporate into the series:

- nvme-rdma: make the sge array for inline segments dynamic based on the
target's advertised inline_data_size.  Since we're limiting the max count
to 4, I'm not sure this is worth the complexity of allocating the sge array
vs just embedding the max.

- nvmet-rdma: reduce the qp depth if the inline size greatly increases
the memory footprint.  I'm not sure how to do this in a reasonable mannor.
Since the inline data size is now configurable, do we still need this?

- nvmet-rdma: make the qp depth configurable so the admin can reduce it
manually to lower the memory footprint.

Steve Wise (2):
  nvme-rdma: support up to 4 segments of inline data
  nvmet-rdma: support max(16KB, PAGE_SIZE) inline data

 drivers/nvme/host/rdma.c        |  38 ++++++---
 drivers/nvme/target/admin-cmd.c |   4 +-
 drivers/nvme/target/configfs.c  |  31 +++++++
 drivers/nvme/target/core.c      |   4 +
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/nvmet.h     |   2 +-
 drivers/nvme/target/rdma.c      | 174 ++++++++++++++++++++++++++++++----------
 7 files changed, 199 insertions(+), 56 deletions(-)

-- 
1.8.3.1
