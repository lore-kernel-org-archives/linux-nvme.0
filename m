From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Thu,  8 Sep 2016 12:14:24 -0700
Subject: [PATCH] nvmetcli: README description of discovery
Message-ID: <1473362064-30173-1-git-send-email-james_p_freyensee@linux.intel.com>

Some blurbs on discovery and the connection
between using nvmetcli to set up an NVMe target and
what gets seen by an NVMe Host when accessing
the discovery controller.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 README | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 1fd76a6..4c44b39 100644
--- a/README
+++ b/README
@@ -111,8 +111,23 @@ The following walks through an example using interactive mode.
 ...> cd subsystems/
 ...> create testnqn
 
-Referrals/Discovery
---------------------
+Discovery
+----------
+Each NVMe Target has a discovery controller mechanism that an NVMe
+Host can use to determine the NVM subsystems it has access too.
+nvmetcli can be used to add a new record to the discovery controller
+upon each new subsystem entry and port entry that the newly
+created subsystem entry binds too (see the '/port/' and
+'/subystem/' nvmetcli walk-through earlier in this README).  Each NVMe
+Host only gets to see the discovery entries defined in
+/subsystems/[NQN NAME]/allowed_hosts and the IP port it is connected
+to the NVMe Target.
+
+A Host can retrieve these discovery logs via the nvme-cli tool
+(https://github.com/linux-nvme/nvme-cli).
+
+Referrals
+---------
 TBD
 
 Saving and restoring the configuration
-- 
2.7.4
