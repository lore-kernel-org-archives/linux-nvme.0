From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 16 Dec 2017 03:02:49 +0900
Subject: [PATCH 0/2] nvme-cli: update Firmware Activate command
Message-ID: <1513360971-15566-1-git-send-email-minwoo.im.dev@gmail.com>

Hi all,

Name of Firmware Activate command was changed in NVMe 1.2 to Firmware Commit.
This patch will change the command name accordingly.
It will also make it support for new feature(Boot Partition) specified in
this command which was introduced in NVMe 1.3.

Please feel free to give any comments.

Thanks,

Minwoo Im (2):
  nvme-cli: update Firmware Activate command for new feature
  nvme-cli: add a status code of Firmware Commit command

 linux/nvme.h   |  1 +
 nvme-builtin.h |  2 +-
 nvme-ioctl.c   |  4 ++--
 nvme-ioctl.h   |  2 +-
 nvme-print.c   |  1 +
 nvme.c         | 35 +++++++++++++++++++++++++----------
 6 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.7.4
