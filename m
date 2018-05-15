From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 15 May 2018 09:40:38 +0200
Subject: [PATCH 0/5] Misc NVMe lockdep fixes
Message-ID: <20180515074043.22843-1-jthumshirn@suse.de>

I've "accidently" activated lockdep and ran some tests on nvme, here's
the post-fallout patch series.

Johannes Thumshirn (5):
  nvme: fix lockdep warning in nvme_mpath_clear_current_path
  nvme: don't hold nvmf_transports_rwsem for more than transport lookups
  nvme: call nvmf_create_ctrl before checking for duplicate assignment
  nvmet: use atomic allocations when allocating fc requests
  nvmet: fcloop: use irqsave spinlocks

 drivers/nvme/host/fabrics.c  | 20 +++++++---------
 drivers/nvme/host/nvme.h     |  3 ++-
 drivers/nvme/target/fcloop.c | 54 ++++++++++++++++++++++++--------------------
 3 files changed, 40 insertions(+), 37 deletions(-)

-- 
2.16.3
