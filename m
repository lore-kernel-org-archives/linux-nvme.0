From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:44:30 -0700
Subject: [PATCH 0/5] nvme_fc: add ctlr reset support and abort fixes
Message-ID: <20170324034435.8761-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

This patch set primarily is to add support for controller reset.
It reorganizes the connect and teardown paths for cleaner support.
It also addresses some things that weren't there prior - aborts of link
services as well as aens.  Also fixes a few bugs.

James Smart (5):
  nvme_fc: Move LS's to rport
  nvme_fc: Add ls aborts on remote port teardown
  nvme_fc: fix command id check
  nvme_fc: add aen abort to teardown
  nvme_fc: add controller reset support

 drivers/nvme/host/fc.c | 1233 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 834 insertions(+), 399 deletions(-)

-- 
2.9.3
