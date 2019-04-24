From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 11:53:15 -0700
Subject: [PATCH 0/4] small patchset for 5.2
Message-ID: <20190424185319.18942-1-sagi@grimberg.me>

3 bug fixes and a small cleanup.

Sagi Grimberg (4):
  nvmet-tcp: don't fail maxr2t greater than 1
  nvme-tcp: Fix a NULL deref when an admin connect times out
  nvme-rdma: Fix a NULL deref when an admin connect times out
  nvme-tcp: rename function to have nvme_tcp prefix

 drivers/nvme/host/rdma.c  | 10 ++++++----
 drivers/nvme/host/tcp.c   | 18 ++++++++++--------
 drivers/nvme/target/tcp.c |  6 ------
 3 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.17.1
