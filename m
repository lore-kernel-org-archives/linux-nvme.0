From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 15:02:24 -0700
Subject: [PATCH v4 0/3] Couple of fixes detected with blktests
Message-ID: <20190311220227.23656-1-sagi@grimberg.me>

nvme test 009 discovered a few issues with and without multipathing.

1. if a namespace has a larger block size than PAGE_SIZE we either panic
   on a divide by zero with multipathing, or we see I/O errors without it.
   - fix nvmet to always export block size that is leq PAGE_SIZE
   - fix the core to set 0 capacity on such a namespace

2. if a namespace allocation fails after nvme_init_ns_head we leak
   subsystems due to a missing ns_head ref put
   - fix it by putting the ns_head reference on nvme_alloc_ns error flow

Changes from v3:
- don't have the host fail if ns allocation lba_shift exceeds PAGE_SHIFT,
  instead set 0 capacity

Changes from v2:
- add comment to nvmet file ns lba_shift clamping
- add host side protection against such a namespace

Sagi Grimberg (3):
  nvme: set 0 capacity if namespace block size exceeds PAGE_SIZE
  nvme: put ns_head ref if namespace fails allocation
  nvmet-file: clamp-down file namespace lba_shift

 drivers/nvme/host/core.c          | 8 +++++++-
 drivers/nvme/target/io-cmd-file.c | 7 ++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.1
