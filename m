From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 26 Apr 2019 16:47:44 +0200
Subject: [GIT PULL] nvme updates for 5.2
Message-ID: <20190426144744.GA28094@infradead.org>

The following changes since commit 95f18c9d1310730d075499a75aaf13bcd60405a7:

  bcache: avoid potential memleak of list of journal_replay(s) in the CACHE_SYNC branch of run_cache_set (2019-04-24 10:56:29 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2

for you to fetch changes up to 01fa017484ad98fccdeaab32db0077c574b6bd6f:

  nvme: set 0 capacity if namespace block size exceeds PAGE_SIZE (2019-04-25 16:51:42 +0200)

----------------------------------------------------------------
Enrico Weigelt, metux IT consult (1):
      nvmet: include <linux/scatterlist.h>

Max Gurtovoy (2):
      nvmet-rdma: remove p2p_client initialization from fast-path
      nvmet: rename nvme_completion instances from rsp to cqe

Ming Lei (1):
      nvme-loop: kill timeout handler

Minwoo Im (2):
      nvmet: return a specified error it subsys_alloc fails
      nvme-rdma: fix typo in struct comment

Sagi Grimberg (6):
      nvmet-file: clamp-down file namespace lba_shift
      nvmet-tcp: don't fail maxr2t greater than 1
      nvme-tcp: fix a NULL deref when an admin connect times out
      nvme-rdma: fix a NULL deref when an admin connect times out
      nvme-tcp: rename function to have nvme_tcp prefix
      nvme: set 0 capacity if namespace block size exceeds PAGE_SIZE

 drivers/nvme/host/core.c          |  7 ++++++-
 drivers/nvme/host/rdma.c          | 10 ++++++----
 drivers/nvme/host/tcp.c           | 18 ++++++++++--------
 drivers/nvme/target/Kconfig       |  1 +
 drivers/nvme/target/configfs.c    |  4 ++--
 drivers/nvme/target/core.c        | 29 +++++++++++++++--------------
 drivers/nvme/target/discovery.c   |  4 ++--
 drivers/nvme/target/fabrics-cmd.c | 16 ++++++++--------
 drivers/nvme/target/fc.c          |  2 +-
 drivers/nvme/target/io-cmd-file.c |  7 ++++++-
 drivers/nvme/target/loop.c        | 22 +++-------------------
 drivers/nvme/target/nvmet.h       |  4 ++--
 drivers/nvme/target/rdma.c        | 21 ++++++++++-----------
 drivers/nvme/target/tcp.c         | 14 ++++----------
 include/linux/nvme-rdma.h         |  2 +-
 15 files changed, 77 insertions(+), 84 deletions(-)
