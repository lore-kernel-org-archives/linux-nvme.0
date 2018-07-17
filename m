From: hare@suse.de (Hannes Reinecke)
Date: Tue, 17 Jul 2018 15:31:16 +0200
Subject: [PATCH 0/2] blktests: test ANA base support
Message-ID: <20180717133118.39026-1-hare@suse.de>

Hi all,

here's a small patchset for testing ANA base support.
The test itself requires the ANA patchset from Christoph, plus
the fixes I've sent to the mailing list earlier.

Hannes Reinecke (2):
  blktests: enable ANA support
  blktests: add test for ANA state transition

 tests/nvme/014     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/014.out |  17 ++++++
 tests/nvme/rc      |  49 ++++++++++++++++-
 3 files changed, 221 insertions(+), 3 deletions(-)
 create mode 100755 tests/nvme/014
 create mode 100644 tests/nvme/014.out

-- 
2.12.3
