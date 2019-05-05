From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon,  6 May 2019 00:06:08 +0900
Subject: [PATCH 0/3] blktests: nvme: Fix pass data of nvmet TCs
Message-ID: <20190505150611.15776-1-minwoo.im.dev@gmail.com>

Hi, Omar,

This patchset fixes mismatch between expected pass data and real data
printed out for nvmet testcases.

It has been long time to have changes for nvmet and nvme-cli.  The
following commits can explain why the pass data has to be updated.

About genctr:
  Commit b662a078 ("nvmet: enable Discovery Controller AENs")

About treq field:
- nvmet:
  Commit 9b95d2fb ("nvmet: expose support for fabrics SQ flow control
                    disable in treq")
- nvme-cli:
  Commit 2cf370c3 ("fabrics: support fabrics sq flow control disable")

Please correct me if I'm wrong here. :)

Thanks,

*** BLURB HERE ***

Minwoo Im (3):
  nvme: 002: fix nvmet pass data with loop
  nvme: 016: fix nvmet pass data with loop
  nvme: 017: fix nvmet pass data with loop

 tests/nvme/002.out | 2002 ++++++++++++++++++++++++++--------------------------
 tests/nvme/016.out |    4 +-
 tests/nvme/017.out |    4 +-
 3 files changed, 1005 insertions(+), 1005 deletions(-)

-- 
2.7.4
