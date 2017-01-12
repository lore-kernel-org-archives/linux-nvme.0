From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 12:31:14 +0200
Subject: [PATCH 0/5] nvme fabrics patches
Message-ID: <1484217079-9259-1-git-send-email-sagi@grimberg.me>

This is a resend of some patches I sent a while ago
and just now got some time to revisit.

I added a fix to a possible race condition where we
free a controller without making sure that fatal_err
and/or async works are cancelled/flushed.

Sagi Grimberg (5):
  nvmet: delete controllers deletion upon subsystem release
  nvmet: Make cntlid globally unique
  nvme: Make controller state visible via sysfs
  nvmet: cancel fatal error and flush async work before free controller
  nvmet: Call fatal_error from keep-alive timout expiration

 drivers/nvme/host/core.c          | 24 ++++++++++++++++++++++++
 drivers/nvme/target/configfs.c    |  1 +
 drivers/nvme/target/core.c        | 25 ++++++++++++++++++-------
 drivers/nvme/target/fabrics-cmd.c |  4 ++--
 drivers/nvme/target/nvmet.h       |  2 +-
 5 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.7.4
