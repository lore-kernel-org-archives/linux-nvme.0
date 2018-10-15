From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 Oct 2018 09:01:27 +0200
Subject: [PATCH 0/3] blktests: ANA and FC-Loop support
Message-ID: <20181015070130.6695-1-hare@suse.de>

Hi all,

here are two new tests for ANA support and FC-Loop; the latter more
as a showcase how fcloop is supposed to be setup.
But also serves as a nice reproducer for fcloop failing to be removed
properly.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: enable ANA support
  nvme: add test for ANA state transition
  nvme: Add test for fcloop

 tests/nvme/018     | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/018.out |  18 +++++++
 tests/nvme/029     | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/029.out |   2 +
 tests/nvme/rc      | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 422 insertions(+), 3 deletions(-)
 create mode 100755 tests/nvme/018
 create mode 100644 tests/nvme/018.out
 create mode 100755 tests/nvme/029
 create mode 100644 tests/nvme/029.out

-- 
2.13.7
