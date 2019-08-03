From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  2 Aug 2019 19:49:49 -0700
Subject: [PATCH rfc v2 0/6] nvme controller reset and namespace scan work race
 conditions
Message-ID: <20190803024955.29508-1-sagi@grimberg.me>

Hey Hannes and Keith,

This is the second attempt to handle the reset and scanning race saga.

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

In the patchset:
- first make sure that transport related errors (such as
  nvme_cancel_request) reflect HOST_PATH_ERROR status.
- make NVME_SC_HOST_PATH_ERROR a BLK_STS_TRANSPORT conversion.
- Make sure that the callers indeed propagate the status back
- Then simply look at the status code when calling revalidate_disk
  in nvme_validate_ns, and only remove it if the status code is
  indeed a transport related status.

Please let me know your thoghts.

Sagi Grimberg (6):
  nvme: fail cancelled commands with NVME_SC_HOST_PATH_ERROR
  nvme: return nvme_error_status for sync commands failure
  nvme: make nvme_identify_ns propagate errors back
  nvme: make nvme_report_ns_ids propagate error back
  nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR send failed
  nvme: don't remove namespace if revalidate failed because of a
    transport error

 drivers/nvme/host/core.c | 67 ++++++++++++++++++++++++----------------
 drivers/nvme/host/tcp.c  |  2 +-
 2 files changed, 41 insertions(+), 28 deletions(-)

-- 
2.17.1
