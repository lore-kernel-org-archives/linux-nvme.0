From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 26 May 2017 17:09:33 +0300
Subject: [GIT PULL] nvme updates for 4.12-rc3
Message-ID: <20170526140933.j6dctw6qdmvuseld@infradead.org>

Hi Jens,

a couple of fixes for the next rc on the nvme front.  Various FC
fixes from James, controller removal fixes from Ming (including a block
layer patch), a APST related device quirk from Andy, a RDMA fix for
small queue depth device from Marta, as well as fixes for the lack
of metadata support in non-PCIe drivers and the printk logging format
from me.

The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:

  Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.12

for you to fetch changes up to 50af47d04ca530544b27affffb0722f158e2bb9c:

  nvme: Quirk APST on Intel 600P/P3100 devices (2017-05-26 11:53:02 +0300)

----------------------------------------------------------------
Andy Lutomirski (1):
      nvme: Quirk APST on Intel 600P/P3100 devices

Christoph Hellwig (3):
      nvme-pci: consistencly use ctrl->device for logging
      nvme: replace is_flags field in nvme_ctrl_ops with a flags field
      nvme: only setup block integrity if supported by the driver

James Smart (6):
      nvme_fc: get rid of local reconnect_delay
      nvme_fc: Support ctrl_loss_tmo
      nvme_fc: revise comment on teardown
      nvme_fc: set logging level on resets/deletes
      nvme_fc: correct nvme status set on abort
      nvme_fc: remove extra controller reference taken on reconnect

Marta Rybczynska (1):
      nvme-rdma: support devices with queue size < 32

Ming Lei (3):
      nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()
      nvme: avoid to use blk_mq_abort_requeue_list()
      blk-mq: remove blk_mq_abort_requeue_list()

 block/blk-mq.c             |  19 ------
 drivers/nvme/host/core.c   |  65 +++++++++++++-------
 drivers/nvme/host/fc.c     | 147 ++++++++++++++++++---------------------------
 drivers/nvme/host/nvme.h   |   4 +-
 drivers/nvme/host/pci.c    |  15 +++--
 drivers/nvme/host/rdma.c   |  20 ++++--
 drivers/nvme/target/loop.c |   2 +-
 include/linux/blk-mq.h     |   1 -
 8 files changed, 130 insertions(+), 143 deletions(-)
