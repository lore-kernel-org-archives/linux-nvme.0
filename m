From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Apr 2019 17:31:34 +0200
Subject: [GIT PULL] nvme fixes for 5.1
Message-ID: <20190411153134.GA16359@infradead.org>

Hi Jens,

two nvme fixes for 5.1 - fixing the initial CSN for nvme-fc, and handle
log page offsets properly in the target.

The following changes since commit a3761c3c91209b58b6f33bf69dd8bb8ec0c9d925:

  block: do not leak memory in bio_copy_user_iov() (2019-04-10 16:14:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.1

for you to fetch changes up to d808b7f759b50acf0784ce6230ffa63e12ef465d:

  nvmet: fix discover log page when offsets are used (2019-04-11 17:28:30 +0200)

----------------------------------------------------------------
James Smart (1):
      nvme-fc: correct csn initialization and increments on error

Keith Busch (1):
      nvmet: fix discover log page when offsets are used

 drivers/nvme/host/fc.c          | 20 +++++++++---
 drivers/nvme/target/admin-cmd.c |  5 +++
 drivers/nvme/target/discovery.c | 68 +++++++++++++++++++++++++++--------------
 drivers/nvme/target/nvmet.h     |  1 +
 include/linux/nvme.h            |  9 ++++--
 5 files changed, 73 insertions(+), 30 deletions(-)
