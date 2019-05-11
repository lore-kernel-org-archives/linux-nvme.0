From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 11 May 2019 22:42:53 +0900
Subject: [PATCH 0/2] Minor clean-ups for nvme and nvme-fabrics
Message-ID: <20190511134255.6790-1-minwoo.im.dev@gmail.com>

Here's minor patchset for nvme and nvme-fabrics.
The first one fixes typos in nvme status code name.  Once it's accepted,
nvme-cli can be updatd soon.
The second removes a unused argument in nvmf_create_ctrl().

Please review.
Thanks,

Minwoo Im (2):
  nvme: Fix typos in nvme status code values
  nvme-fabrics: Remove unused argument

 drivers/nvme/host/fabrics.c | 4 ++--
 include/linux/nvme.h        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1
