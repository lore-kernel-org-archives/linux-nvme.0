From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 21 Apr 2017 19:02:29 +0200
Subject: [GIT PULL] nvme updates for 4.12
Message-ID: <20170421170229.awfwczwwe3vetii6@infradead.org>

Hi Jens,

this is the current NVMe pile: virtualization extensions, lots of FC
updates and various misc bits.  There are a few more FC bits that didn't
make the cut, but we'd like to get this request out before the merge
window for sure.


The following changes since commit 99c749a4c4f4ea2c9eee01f81f79bdbf26c3914e:

  blk-stat: kill blk_stat_rq_ddir() (2017-04-21 07:56:23 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.12

for you to fetch changes up to e02ab0230489461fd9fdd8028841dae6f03a4874:

  nvme: let dm-mpath distinguish nvme error codes (2017-04-21 16:41:56 +0200)

----------------------------------------------------------------
Helen Koike (1):
      nvme: improve performance for virtual NVMe devices

James Smart (8):
      nvmet_fc: add target feature flags for upcall isr contexts
      nvmet_fc: add req_release to lldd api
      nvme_fcloop: split job struct from transport for req_release
      nvmet_fc: Rework target side abort handling
      nvmet_fc: add missing reference in add_port
      nvme_fc: Move LS's to rport
      nvme_fc: Add ls aborts on remote port teardown
      nvmet_fc: Change traddr field separator to a colon

Junxiong Guan (1):
      nvme: let dm-mpath distinguish nvme error codes

Keith Busch (2):
      nvme/pci: Don't set reserved SQ create flags
      nvme/pci: Poll CQ on timeout

Logan Gunthorpe (1):
      nvmet: convert from kmap to nvmet_copy_from_sgl

 drivers/nvme/host/core.c          |  14 +++
 drivers/nvme/host/fc.c            | 152 +++++++++++++++--------
 drivers/nvme/host/pci.c           | 166 ++++++++++++++++++++++++-
 drivers/nvme/target/fabrics-cmd.c |  32 +++--
 drivers/nvme/target/fc.c          | 253 +++++++++++++++++++++++++++++---------
 drivers/nvme/target/fcloop.c      | 197 +++++++++++++++++++++++------
 drivers/scsi/lpfc/lpfc_nvmet.c    | 126 +++++++++++++++----
 drivers/scsi/lpfc/lpfc_nvmet.h    |   7 +-
 include/linux/nvme-fc-driver.h    |  98 ++++++++++-----
 include/linux/nvme.h              |  13 ++
 10 files changed, 834 insertions(+), 224 deletions(-)
