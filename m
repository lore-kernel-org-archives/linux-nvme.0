From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 17 Dec 2017 18:58:02 +0900
Subject: [PATCH V2 0/3] nvme-cli: update Firmware Activate to Firmware Commit
Message-ID: <1513504682-30766-1-git-send-email-minwoo.im.dev@gmail.com>

This patch set will make it support alias of every subcommands in nvme-cli.
To show how this is done, update "Firmware Activate" command to
"Firmware Commit" by making it as an alias.
Also it updates "Firmware Commit" command to support boot partition feature
which was introduced in NVMe 1.3 spec.

Please feel free to give feedbacks and reviews.

Changes to V1:
- add support alias infrastructure for subcommands (Keith)

Minwoo Im (3):
  nvme-cli: add support alias command with Firmware Activate
  nvme-cli: update Firmware Commit with boot partition feature
  nvme-cli: add command specific status of Firmware Commit

 cmd_handler.h  | 20 ++++++++++++++++----
 linux/nvme.h   |  1 +
 nvme-builtin.h |  2 +-
 nvme-ioctl.c   |  2 +-
 nvme-ioctl.h   |  2 +-
 nvme-print.c   |  1 +
 nvme.c         | 35 +++++++++++++++++++++++++----------
 plugin.c       |  3 ++-
 plugin.h       |  1 +
 9 files changed, 49 insertions(+), 18 deletions(-)

-- 
2.7.4
