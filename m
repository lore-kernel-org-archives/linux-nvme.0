From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  5 Dec 2016 13:09:03 +0200
Subject: [PATCH 0/3] some useful fabrics patches
Message-ID: <1480936146-6406-1-git-send-email-sagi@grimberg.me>

No bug fixes, but useful patches I had in the pipe...

Sagi Grimberg (3):
  nvmet: delete controllers deletion upon subsystem release
  nvmet: Make cntlid globally unique
  nvme: Make controller state visible via sysfs

 drivers/nvme/host/core.c          | 21 +++++++++++++++++++++
 drivers/nvme/target/configfs.c    |  1 +
 drivers/nvme/target/core.c        | 20 ++++++++++++++------
 drivers/nvme/target/fabrics-cmd.c |  4 ++--
 drivers/nvme/target/nvmet.h       |  2 +-
 5 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.7.4
