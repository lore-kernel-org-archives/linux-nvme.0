From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 10 Oct 2018 08:08:18 -0700
Subject: [PATCH v2 0/2] Fixes for issues detected by static analyzers
Message-ID: <20181010150820.203745-1-bvanassche@acm.org>

Hi Keith, Christoph and Sagi,

This patch series addresses several issues reported by static analyzers like
sparse, smatch and Coverity. Please consider these patches for Linux kernel
v4.20.

Thanks,

Bart.

Changes compared to v1:
- Left out the patches that have already been queued by Christoph and also
  patch "nvme-core: Complain if nvme_init_identify() fails".
- Addressed the review feedback that I received for the two patches in v2
  of this series.

Bart Van Assche (2):
  nvme-core: Make implicit seed truncation explicit
  nvmet-fcloop: Suppress a compiler warning

 drivers/nvme/host/core.c     | 2 +-
 drivers/nvme/target/fcloop.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.0.605.g01d371f741-goog
