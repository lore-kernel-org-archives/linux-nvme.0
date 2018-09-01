From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 31 Aug 2018 18:36:01 -0700
Subject: [PATCH nvme-cli 0/4] Some useful fabrics patches
Message-ID: <20180901013605.10658-1-sagi@grimberg.me>

patch #1 is cleanup
patch #2 is a bug fix
patch #3,#4 are are adding a useful fabrics command to disconnect
all the existing controllers.

Sagi Grimberg (4):
  fabrics: make some arguments integers
  fabrics: don't fail empty discovery log page
  nvme: commonize subsystems info in a helper
  fabrics: add disconnect-all command

 Documentation/nvme-disconnect-all.txt | 34 ++++++++++
 fabrics.c                             | 92 ++++++++++++++++++++-------
 fabrics.h                             |  1 +
 nvme-builtin.h                        |  1 +
 nvme.c                                | 83 ++++++++++++++----------
 nvme.h                                |  2 +
 6 files changed, 155 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/nvme-disconnect-all.txt

-- 
2.17.1
