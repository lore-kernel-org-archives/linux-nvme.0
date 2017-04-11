From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Tue, 11 Apr 2017 11:35:07 -0700
Subject: [PATCH v2 0/5] nvme_fc: add ctlr reset support and abort fixes
Message-ID: <20170411183512.9043-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

This patch set primarily is to add support for controller reset.
It reorganizes the connect and teardown paths for cleaner support.
It also addresses some things that weren't there prior - aborts of link
services as well as aens.  Also fixes a few bugs.

The patches were recut on the latest block for-4.12/block branch and
changed only to address merge issues.


James Smart (5):
  nvme_fc: Move LS's to rport
  nvme_fc: Add ls aborts on remote port teardown
  nvme_fc: fix command id check
  nvme_fc: add aen abort to teardown
  nvme_fc: add controller reset support

 drivers/nvme/host/fc.c | 1231 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 832 insertions(+), 399 deletions(-)

-- 
2.9.3
