From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 24 Oct 2017 15:25:19 +0300
Subject: [PATCH 0/3] centralize transport not ready request check
Message-ID: <1508847922-26699-1-git-send-email-sagi@grimberg.me>

In all fabrics transports, queues are fully functional (live) only
once we are connected in the nvmf level. When we get into reset, delete
or error recovery scenarios with inflight commands, we need to check
that we are ready issue a command.

First check that the queue is LIVE. if not, we can only allow connect
commands to be issued (to help us get to LIVE). Centralize this check
and make all our fabric transport use it.

rdma + loop were tested.

Sagi Grimberg (3):
  nvme-fabrics: Introduce init command check for a queue that is not
    alive
  nvme-fc: Check if queue is ready in queue_rq
  nvme-loop: Check if queue is ready in queue_rq

 drivers/nvme/host/fabrics.h | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/fc.c      | 19 ++++++++++++++++++-
 drivers/nvme/host/rdma.c    | 29 ++++++-----------------------
 drivers/nvme/target/loop.c  | 25 ++++++++++++++++++++++++-
 4 files changed, 78 insertions(+), 25 deletions(-)

-- 
2.7.4
