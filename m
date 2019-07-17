From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 17 Jul 2019 11:12:59 -0600
Subject: [PATCH blktests v2 12/12] nvme: Ignore errors when removing modules
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
Message-ID: <20190717171259.3311-13-logang@deltatee.com>

It is no longer important for correct test functionality to
remove the modules between tests. Therefore, we ignore errors
if the modules are not removed (ie. if they are builtin).

With this patch, it is now safe to run the tests with the nvmet
modules built-in. This will be more convienent for developers
that want to run the tests in a simple VM.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a6b4d5938680..348b4a3c2cbc 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -68,8 +68,8 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	stty isig
 
-	modprobe -r nvme-loop
-	modprobe -r nvmet
+	modprobe -r nvme-loop 2>/dev/null
+	modprobe -r nvmet 2>/dev/null
 }
 
 _setup_nvmet() {
-- 
2.17.1
