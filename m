From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 30 Nov 2018 16:24:30 +0100
Subject: [GIT PULL] nvme fixes for 4.20
Message-ID: <20181130152430.GA3107@infradead.org>

Various fixlets all over, including throwing in a 'default y' for the
multipath code, given that we want people to actually enable it for full
functionality.

The following changes since commit 14b04063cc994effc86f976625bf8f806d8d44cb:

  Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-linus (2018-11-21 05:56:28 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to d4779afb08ef3f012053cdf3bebed5960587ab88:

  nvme-rdma: fix double freeing of async event data (2018-11-29 16:43:20 +0100)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: enable multipathing by default
      nvme: warn when finding multi-port subsystems without multipathing enabled

Ewan D. Milne (1):
      nvme-fc: initialize nvme_req(rq)->ctrl after calling __nvme_fc_init_request()

Igor Konopko (1):
      nvme-pci: fix surprise removal

Keith Busch (1):
      nvme: Free ctrl device name on init failure

Prabhath Sajeepa (1):
      nvme-rdma: fix double freeing of async event data

Sagi Grimberg (1):
      nvme: flush namespace scanning work just before removing namespaces

 drivers/nvme/host/Kconfig | 8 ++++++++
 drivers/nvme/host/core.c  | 8 +++++---
 drivers/nvme/host/fc.c    | 2 +-
 drivers/nvme/host/nvme.h  | 3 +++
 drivers/nvme/host/rdma.c  | 2 ++
 5 files changed, 19 insertions(+), 4 deletions(-)
