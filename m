From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 27 Apr 2017 19:19:39 +0200
Subject: [GIT PULL] nvme updates for 4.12
Message-ID: <20170427171939.tnlpqb5qmazns334@infradead.org>

A couple more updates for 4.12.  The biggest pile is fc and lpfc updates
from James, but there are various small fixes and cleanups as well.

The following changes since commit a44f53faf4674d84cba79f7ee574584e18ab8744:

  lightnvm: pblk: fix erase counters on error fail (2017-04-23 16:57:52 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.12

for you to fetch changes up to 7569b90a228ed7dfdc1f92f2c98d7a1b041f22eb:

  nvme-scsi: remove nvme_trans_security_protocol (2017-04-27 08:39:32 +0200)

----------------------------------------------------------------
Christoph Hellwig (8):
      nvme-fc: mark two symbols static
      nvmet-fc: mark nvmet_fc_handle_fcp_rqst static
      nvmet-fc: fix endianess annoations for nvmet_fc_format_rsp_hdr
      nvmet-fc: mark the sqhd field as __le16
      nvmet-fc: properly endian swap sq_head
      nvmet-fcloop: mark two symbols static
      nvme-lightnvm: add missing endianess conversion in nvme_nvm_end_io
      nvme-scsi: remove nvme_trans_security_protocol

Ewan D. Milne (1):
      nvme-fc: avoid memory corruption caused by calling nvmf_free_options() twice

James Smart (26):
      nvme_fc: fix command id check
      nvme_fc: add aen abort to teardown
      nvme_fc: add controller reset support
      Standardize nvme SGL segment count
      Fix nvme unregister port timeout.
      Fix rejected nvme LS Req.
      Fix log message in completion path.
      Add debug messages for nvme/fcp resource allocation.
      Fix spelling in comments.
      Remove unused defines for NVME PostBuf.
      Remove NULL ptr check before kfree.
      Fix extra line print in rqpair debug print.
      Fix PRLI ACC rsp for NVME
      Fix driver unload/reload operation.
      Fix driver usage of 128B WQEs when WQ_CREATE is V1.
      Fix nvme initiator handling when not enabled.
      Remove hba lock from NVMET issue WQE.
      Fix driver load issues when MRQ=8
      Fix crash after issuing lip reset
      Fix max_sgl_segments settings for NVME / NVMET
      Add Fabric assigned WWN support.
      Fix implicit logo and RSCN handling for NVMET
      Update ABORT processing for NVMET.
      Fix Express lane queue creation.
      lpfc revison 11.2.0.12
      lpfc: Fix memory corruption of the lpfc_ncmd->list pointers

Jon Derrick (1):
      nvme-scsi: Consider LBA format in IO splitting calculation

 drivers/nvme/host/fc.c             | 1171 ++++++++++++++++++++++++------------
 drivers/nvme/host/lightnvm.c       |    2 +-
 drivers/nvme/host/scsi.c           |   15 +-
 drivers/nvme/target/fc.c           |    8 +-
 drivers/nvme/target/fcloop.c       |    4 +-
 drivers/scsi/lpfc/lpfc.h           |    5 +-
 drivers/scsi/lpfc/lpfc_attr.c      |   10 +-
 drivers/scsi/lpfc/lpfc_bsg.c       |    4 +
 drivers/scsi/lpfc/lpfc_crtn.h      |    9 +-
 drivers/scsi/lpfc/lpfc_ct.c        |   68 ++-
 drivers/scsi/lpfc/lpfc_debugfs.c   |   67 ++-
 drivers/scsi/lpfc/lpfc_disc.h      |    1 +
 drivers/scsi/lpfc/lpfc_els.c       |   68 +--
 drivers/scsi/lpfc/lpfc_hbadisc.c   |  133 ++--
 drivers/scsi/lpfc/lpfc_hw.h        |    3 +
 drivers/scsi/lpfc/lpfc_hw4.h       |    4 +
 drivers/scsi/lpfc/lpfc_init.c      |  202 ++++---
 drivers/scsi/lpfc/lpfc_mbox.c      |    7 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c |    8 +-
 drivers/scsi/lpfc/lpfc_nvme.c      |  157 +++--
 drivers/scsi/lpfc/lpfc_nvme.h      |   11 +-
 drivers/scsi/lpfc/lpfc_nvmet.c     |  377 +++++++++---
 drivers/scsi/lpfc/lpfc_nvmet.h     |   14 +-
 drivers/scsi/lpfc/lpfc_sli.c       |   22 +-
 drivers/scsi/lpfc/lpfc_sli4.h      |    2 +-
 drivers/scsi/lpfc/lpfc_version.h   |    2 +-
 drivers/scsi/lpfc/lpfc_vport.c     |    3 +-
 27 files changed, 1617 insertions(+), 760 deletions(-)
