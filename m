From: hare@suse.de (Hannes Reinecke)
Date: Thu,  2 Aug 2018 12:34:53 +0200
Subject: [PATCHv2 0/2] blktests: test ANA base support
Message-ID: <20180802103455.82148-1-hare@suse.de>

Hi all,

here's a small patchset for testing ANA base support.
The test itself requires the ANA patchset from Christoph currently queued
in nvme-4.19.

Changes to v1:
- Include reviews from Chaitanya
- Match on namespace UUID when figuring out which NS to use
- Drop sysfs names from the output to allow the testcase to run
  on machines with other NVMe devices

Hannes Reinecke (2):
  blktests: enable ANA support
  blktests: add test for ANA state transition

 tests/nvme/018     | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/018.out |  18 +++++++
 tests/nvme/rc      |  89 +++++++++++++++++++++++++++++--
 3 files changed, 257 insertions(+), 3 deletions(-)
 create mode 100755 tests/nvme/018
 create mode 100644 tests/nvme/018.out

-- 
2.12.3
