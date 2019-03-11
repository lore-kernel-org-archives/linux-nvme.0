From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 14:16:05 -0700
Subject: [PATCH v3 0/3] Couple of fixes detected with blktests
Message-ID: <20190311211608.16628-1-sagi@grimberg.me>

nvme test 009 discovered a few issues with and without multipathing.

1. if a namespace has a larger block size than PAGE_SIZE we either panic
   on a divide by zero with multipathing, or we see I/O errors without it.
   - fix nvmet to always export block size that is leq PAGE_SIZE
   - fix the core to fail ns allocation if it sees it

2. if a namespace allocation fails after nvme_init_ns_head we leak
   subsystems due to a missing ns_head ref put
   - fix it by putting the ns_head reference on nvme_alloc_ns error flow

Sagi Grimberg (3):
  nvme: fail namespace revalidate if block size exceeds PAGE_SIZE
  nvme: put ns_head ref if namespace fails allocation
  nvmet-file: clamp-down file namespace lba_shift

 drivers/nvme/host/core.c          | 19 +++++++++++++++----
 drivers/nvme/target/io-cmd-file.c |  7 ++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.17.1
