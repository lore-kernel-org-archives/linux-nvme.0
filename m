From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 03:41:51 +0900
Subject: [PATCH 0/4] nvme: update way to get qid in trace
Message-ID: <20190727184155.18014-1-minwoo.im.dev@gmail.com>

Hi All,

This series is mainly to support trace for lightnvm commands.  To make
it support:

The first patch just simplify the exactly same operations in short by
have queue_num directly.  The second one modified the condition of how
to figure out whether the given request is for admin queue or not.
In case of lightnvm, req->rq_disk might be NULL even it's a NVM command
so that we can compare the admin request queue itself.

The third one added lightnvm admin commands to nvme.h from the lightnvm
core module to support for trace of opcode names.  The fourth one added
NVM I/O commands for the lightnvm for the trace.

Minwoo Im (4):
  nvme: simplify nvme_req_qid()
  nvme: check admin queue with ctrl->admin_q, not rq_disk
  nvme: lightnvm: trace opcode name
  nvme: lightnvm: trace opcode name of I/O commands for 2.0

 drivers/nvme/host/lightnvm.c |  6 ------
 drivers/nvme/host/nvme.h     | 16 +++++++++-------
 include/linux/nvme.h         | 22 ++++++++++++++++++++--
 3 files changed, 29 insertions(+), 15 deletions(-)

-- 
2.17.1
