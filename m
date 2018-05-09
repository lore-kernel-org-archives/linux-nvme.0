From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 9 May 2018 08:38:05 -0700
Subject: [PATCH RFC 0/2] 8K Inline Support
Message-ID: <cover.1525880285.git.swise@opengridcomputing.com>

For small nvmf write IO over the rdma transport, it is advantagous to
make use of inline mode to avoid the latency of the target issuing an
rdma read to fetch the data.  Currently inline is used for <= 4K writes.
8K, though, requires the rdma read.  For iWARP transports additional
latency is incurred because the target mr of the read must be registered
with remote write access.  By allowing 2 pages worth of inline payload,
I see a reduction in 8K nvmf write latency of anywhere from 2-7 usecs
depending on the RDMA transport..

Is this a worthwhile change?  I think it is.  Please comment!

Thanks,

Steve

Steve Wise (2):
  nvme-rdma: Support 8K inline
  nvmet-rdma: Support 8K inline

 drivers/nvme/host/rdma.c   | 21 +++++++++++++++------
 drivers/nvme/target/rdma.c |  4 ++--
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
1.8.3.1
