From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:10:23 +0900
Subject: [PATCH 0/3] nvme-cli: add Get LBA Status command for 1.4
Message-ID: <20190804071026.16149-1-minwoo.im.dev@gmail.com>

Hi All,

This series adds Get LBA Status command which has been introduced in
NVMe 1.4 spec.  Also it covers new fields in Identify controller data.

Github PR: https://github.com/linux-nvme/nvme-cli/pull/546

Thanks,

Minwoo Im (3):
  id-ctrl: add an indicator for get lba status capability
  id-ctrl: add 1.4 features to OAES
  get-lba-status: add Get LBA Status command

 linux/nvme.h   | 16 ++++++++++
 nvme-builtin.h |  1 +
 nvme-ioctl.c   | 15 +++++++++
 nvme-ioctl.h   |  2 ++
 nvme-print.c   | 49 ++++++++++++++++++++++++++++--
 nvme-print.h   |  1 +
 nvme.c         | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 164 insertions(+), 2 deletions(-)

-- 
2.17.1
