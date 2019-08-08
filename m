From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  8 Aug 2019 13:53:18 -0700
Subject: [PATCH v3 0/7] nvme controller reset and namespace scan work race
 conditions
Message-ID: <20190808205325.24036-1-sagi@grimberg.me>

Hey Hannes and Keith,

This is the third attempt to handle the reset and scanning race saga.

The approach is to have the relevant admin commands return a proper
status code that reflects that we had a transport error and
not remove the namepsace if that is indeed the case.

This should be a reliable way to know if the revalidate_disk failed
due to a transport error or not.

I am able to reproduce this race with the following command (using
tcp/rdma):
for j in `seq 50`; do for i in `seq 50`; do nvme reset /dev/nvme0; done ; nvme disconnect-all; nvme connect-all; done

With this patch set (plus two more tcp/rdma transport specific patches
that address a other issues) I was able to pass the test without
reproducing the hang that you hannes reported.

Changes from v2:
- added fc patch from James (can you test please?)
- made nvme_identify_ns return id or PTR_ERR (Hannes)

Changes from v1:
- different approach

James Smart (1):
  nvme-fc: Fail transport errors with NVME_SC_HOST_PATH

Sagi Grimberg (6):
  nvme: fail cancelled commands with NVME_SC_HOST_PATH_ERROR
  nvme: return nvme_error_status for sync commands failure
  nvme: make nvme_identify_ns propagate errors back
  nvme: make nvme_report_ns_ids propagate error back
  nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR send failed
  nvme: don't remove namespace if revalidate failed because of a
    transport error

 drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++++-------------
 drivers/nvme/host/fc.c   | 37 ++++++++++++++++++++++++------
 drivers/nvme/host/tcp.c  |  2 +-
 3 files changed, 64 insertions(+), 24 deletions(-)

-- 
2.17.1
