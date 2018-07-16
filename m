From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 13:53:41 +0300
Subject: [PATCH rfc 0/2] nvmet nice logging helpers
Message-ID: <20180716105343.29699-1-sagi@grimberg.me>

This patch set adds some friendly logging helpers with similar
functionality to dev_[err|warn|info|dbg]. When building a
target system with multiple ports and multiple controllers
connected, its useful to have a coherent log message formats
that provide the affected port and controller identifier.

The one annoying thing is that for xxxx_dbg helper I needed
to open-code the dynamic debug macros. If anyone has a better
idea on how to have it, it'd be great (without allocating a class
device for it).

Feedback is welcome.

Sagi Grimberg (2):
  nvmet: add nvmet port logging helpers
  nvmet: add nvmet ctrl logging helpers

 drivers/nvme/target/admin-cmd.c   | 11 ++++-----
 drivers/nvme/target/configfs.c    | 37 +++++++++++-----------------
 drivers/nvme/target/core.c        | 20 +++++++--------
 drivers/nvme/target/discovery.c   | 13 +++++-----
 drivers/nvme/target/fabrics-cmd.c | 15 +++++------
 drivers/nvme/target/io-cmd-bdev.c |  5 ++--
 drivers/nvme/target/nvmet.h       | 44 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/rdma.c        | 52 ++++++++++++++++++++++-----------------
 8 files changed, 122 insertions(+), 75 deletions(-)

-- 
2.14.1
