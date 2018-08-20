From: hare@suse.de (Hannes Reinecke)
Date: Mon, 20 Aug 2018 12:34:06 +0200
Subject: [PATCH 1/2] nvme-discover: use ASCII characters in documentation
In-Reply-To: <20180820103407.92783-1-hare@suse.de>
References: <20180820103407.92783-1-hare@suse.de>
Message-ID: <20180820103407.92783-2-hare@suse.de>

Somehow a non-ASCII 's' slipped into the documentation for
'nvme discover'.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 Documentation/nvme-discover.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/nvme-discover.txt b/Documentation/nvme-discover.txt
index 51d63e4..b4ae2fc 100644
--- a/Documentation/nvme-discover.txt
+++ b/Documentation/nvme-discover.txt
@@ -29,7 +29,7 @@ Discovery commands to run.  If no /etc/nvme/discovery.conf file
 exists, the command will quit with an error.
 
 Otherwise, a specific Discovery Controller should be specified using the
---transport, --traddr, and if necessary the --trsvcid flags. A Di?covery
+--transport, --traddr, and if necessary the --trsvcid flags. A Discovery
 request will then be sent to the specified Discovery Controller.
 
 BACKGROUND
-- 
2.16.4
