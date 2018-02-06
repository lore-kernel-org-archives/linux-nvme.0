From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  6 Feb 2018 11:44:29 +0200
Subject: [PATCH 0/3] Commonise address any check
Message-ID: <20180206094432.12761-1-sagi@grimberg.me>

Both iscsit and nvmet need to check the listening endpoint
portal is not INADDR_ANY (or IN6ADDR_ANY_INIT) when replying
to a discovery information query (iscsi sendtaragets or nvmet
discovery log pages). If indeed the nvmet port or iscsit portal
are listening on any address, they need to return the source
address of the socket that carried the query itslef.

iscsit already does this while nvmet did not.
instead of copying the inaddr_any check, place it in net-utils
and call it from both (patches 1+3).

In addition, fix the behavior in nvmet (patch 2).

Sagi Grimberg (3):
  net/utils: Introduce inet_addr_is_any
  nvmet: don't return "any" ip address in discovery log page
  iscsi-target: use common inet_addr_is_any

 drivers/nvme/target/discovery.c     | 30 +++++++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h         |  2 ++
 drivers/nvme/target/rdma.c          | 18 ++++++++++++++++++
 drivers/target/iscsi/iscsi_target.c | 28 ++--------------------------
 include/linux/inet.h                |  1 +
 net/core/utils.c                    | 23 +++++++++++++++++++++++
 6 files changed, 73 insertions(+), 29 deletions(-)

-- 
2.14.1
