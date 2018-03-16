From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Mar 2018 10:01:10 -0600
Subject: [GIT PULL] nvme fix for 4.16-rc6
Message-ID: <20180316160110.GC720@localhost.localdomain>

Hi Jens,

One last fix from Jianchao to address a troubling scenario Ming identified
with offlining CPUs that could leave nvme controllers unusable. We can
not allow that to occur, so we wish to include a new IRQ spread that
prevents that situation.

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.16-rc6

for you to fetch changes up to 3aadd3b10f018f26c451f8a0feac7605c2deb0c7:

  nvme-pci: assign separate irq vectors for adminq and ioq1 (2018-03-13 11:27:57 -0600)

----------------------------------------------------------------
Jianchao Wang (1):
      nvme-pci: assign separate irq vectors for adminq and ioq1

 drivers/nvme/host/pci.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)
