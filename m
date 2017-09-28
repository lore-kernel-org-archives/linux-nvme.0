From: jsmart2021@gmail.com (James Smart)
Date: Thu, 28 Sep 2017 08:35:51 -0700
Subject: [PATCH 0/2] nvmet: address controller teardown issues
Message-ID: <20170928153553.13993-1-jsmart2021@gmail.com>

Controller deletes were showing a nasty stack trace with
flush_work hanging. Looking at the issue, it became clear the
ref counting for nvmet was allowing the controller to be freed
too early causing use after free errors.

First patch addresses ctrl ref counting
second patch addresses flush_work hang

James Smart (2):
  nvmet: fix ctlr ref counting
  nvmet: Fix fatal_err_work deadlock

 drivers/nvme/target/core.c        | 42 +++++++++++++++++++++++++++++----------
 drivers/nvme/target/fabrics-cmd.c |  1 +
 drivers/nvme/target/nvmet.h       |  2 ++
 3 files changed, 35 insertions(+), 10 deletions(-)

-- 
2.13.1
