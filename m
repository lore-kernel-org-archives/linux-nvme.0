From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 18 Aug 2017 13:39:48 +0200
Subject: [GIT PULL] nvme updates for 4.13
Message-ID: <20170818113948.367hvkhmfbjms436@infradead.org>

The fixes are getting really small now - two for FC, one for PCI, one
for the fabrics layer and one for the target.

The following changes since commit a082b426286d1ead97fb87646ea361d528be023d:

  nvme: fix directive command numd calculation (2017-08-10 19:53:44 +0200)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.13

for you to fetch changes up to e9d8a0fdeacd843c85dcef480cdb2ab76bcdb6e4:

  nvme-pci: set cqe_seen on polled completions (2017-08-18 09:19:39 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-fabrics: fix reporting of unrecognized options

James Smart (2):
      nvmet-fc: correct use after free on list teardown
      nvmet-fc: eliminate incorrect static markers on local variables

Keith Busch (1):
      nvme-pci: set cqe_seen on polled completions

Martin Wilck (1):
      nvmet: don't overwrite identify sn/fr with 0-bytes

 drivers/nvme/host/fabrics.c     | 3 ++-
 drivers/nvme/host/pci.c         | 5 ++---
 drivers/nvme/target/admin-cmd.c | 6 ------
 drivers/nvme/target/fc.c        | 9 +++++----
 4 files changed, 9 insertions(+), 14 deletions(-)
