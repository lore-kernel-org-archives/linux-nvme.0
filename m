From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  9 Aug 2019 15:12:04 -0700
Subject: [PATCH v5 0/7] nvme controller reset and namespace scan work race
 conditions
Message-ID: <20190809221211.21157-1-sagi@grimberg.me>

Hey Hannes and Keith,

This series handles the reset and scanning race saga.

The approach is to have the relevant admin commands return a proper
status code that reflects that we had a transport error and
not remove the namepsace if that is indeed the case.

This should be a reliable way to know if the revalidate_disk failed
due to a transport error or not.

I am able to reproduce this race with the following command (using
tcp/rdma):
for j in `seq 50`; do nvme connect-all; for i in `seq 50`; do nvme reset /dev/nvme0; done ; nvme disconnect-all; done

With this patch set (plus two more tcp/rdma transport specific patches
that address a other issues) I was able to pass the test without
reproducing the hang that you hannes reported.

Changes from v4:
- return nvme_error_status in __nvme_submit_sync_cmd and cast to
  errno in nvme_identify_ns
- modified status print in nvme_report_ns_ids

Changes from v3:
- return blk_status_to_errno instead of blk_status_t in sync cmds
- check for normal return errno from revalidate_disk, this covers
  transport errors, but also spurious allocation errors and any
  type of transient errors.

Changes from v2:
- added fc patch from James (can you test please?)
- made nvme_identify_ns return id or PTR_ERR (Hannes)

Changes from v1:
- different approach

James Smart (1):
  nvme-fc: Fail transport errors with NVME_SC_HOST_PATH

Sagi Grimberg (6):
  nvme: fail cancelled commands with NVME_SC_HOST_PATH_ERROR
  nvme: return a proper status for sync commands failure
  nvme: make nvme_identify_ns propagate errors back
  nvme: make nvme_report_ns_ids propagate error back
  nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR send failed
  nvme: fix ns removal hang when failing to revalidate due to a
    transient error

 drivers/nvme/host/core.c | 60 ++++++++++++++++++++++++++++------------
 drivers/nvme/host/fc.c   | 37 ++++++++++++++++++++-----
 drivers/nvme/host/tcp.c  |  2 +-
 3 files changed, 74 insertions(+), 25 deletions(-)

-- 
2.17.1
