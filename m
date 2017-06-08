From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Jun 2017 16:23:35 +0200
Subject: [GIT PULL] nvme fixes for 4.12-rc
Message-ID: <20170608142335.c4jqw5bqi56zqpg2@infradead.org>

Hi Jens,

a few NVMe fixes for 4.12-rc, PCIe reset fixes and APST fixes, a
RDMA reconnect fix, two FC fixes and a general controller removal fix.


The following changes since commit 9bd2bbc01d17ddd567cc0f81f77fe1163e497462:

  elevator: fix truncation of icq_cache_name (2017-06-06 11:20:47 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.12

for you to fetch changes up to 9947d6a09cd71937dade2fc14640e4843ae19802:

  nvme: relax APST default max latency to 100ms (2017-06-07 11:08:55 +0200)

----------------------------------------------------------------
James Smart (2):
      nvme-fc: on lldd/transport io error, terminate association
      nvme-fc: fix missing put reference on controller create failure

Kai-Heng Feng (2):
      nvme: only consider exit latency when choosing useful non-op power states
      nvme: relax APST default max latency to 100ms

Ming Lei (1):
      nvme: fix hang in remove path

Rakesh Pandit (1):
      nvme-pci: fix multiple ctrl removal scheduling

Sagi Grimberg (1):
      nvme-rdma: fast fail incoming requests while we reconnect

 drivers/nvme/host/core.c | 21 ++++++++++++++-------
 drivers/nvme/host/fc.c   | 20 ++++++++++++++++++--
 drivers/nvme/host/pci.c  | 13 ++++++-------
 drivers/nvme/host/rdma.c | 44 +++++++++++++++++++++++++++++---------------
 4 files changed, 67 insertions(+), 31 deletions(-)
