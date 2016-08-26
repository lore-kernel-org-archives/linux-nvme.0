From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 26 Aug 2016 06:53:05 -0700
Subject: [PATCH WIP/RFC 0/6] nvme-rdma device removal fixes
Message-ID: <cover.1472219585.git.swise@opengridcomputing.com>

This series is a Work In Progress (WIP) attempting to address several
problems when shutting down a nvme-rdma host when its controllers are
attempting to reconnect to a target that is no longer reachable.

I'm still testing, and there is at least one outstanding bug I'm still
chasing, but I welcome review.  Specifically the last patch which
solves the problem of always being able to detect a device removal.

To tickle these bugs:

1) attach over iw_cxgb4 to 10 devices on a target.
2) 'ifconfig down' the target's interface
3) wait for keep-alive to fire and begin reconnecting (~15-20 seconds)
4) do one of these on the host:
   - rmmod iw_cxgb4
   - reboot
   - reboot -f

Note, the default configuration of the chelsio RNIC is for a lan/wan
environment.  This causes very long delays due to TCP retransmit
backoff algorithms and basically hangs the host during a shutdown for an
unreasonable amount of time.  This is further complicated by the fact
that the RDMA_CM blocks cm_id destruction if the cm_id is attempting
connection setup.  I will address this issue with another series.
To work around the problem, the chelsio RNIC can be configured for a
storage cluster environment, where the retransmit timeout times are
much shorter.  If anyone is doing this sort of testing, I can provide
you with a config file for the storage/cluster configuration.

Sagi, I included your DELETEING patch since it is needed to make forward
progress on my device removal testing.

Thanks,

Steve.

----

Sagi Grimberg (1):
  nvme-rdma: add DELETING queue flag

Steve Wise (5):
  iw_cxgb4: call dev_put() on l2t allocation failure
  iw_cxgb4: block module unload until all ep resources are released
  nvme_rdma: keep a ref on the ctrl during delete/flush
  nvme-rdma: destroy nvme queue rdma resources on connect failure
  nvme-rdma: keep a cm_id around during reconnect to get events

 drivers/infiniband/hw/cxgb4/cm.c       |   7 +-
 drivers/infiniband/hw/cxgb4/device.c   |   5 +
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |   1 +
 drivers/nvme/host/rdma.c               | 170 ++++++++++++++++++++++++++-------
 4 files changed, 149 insertions(+), 34 deletions(-)

-- 
2.7.0
