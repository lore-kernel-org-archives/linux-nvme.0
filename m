From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 14 May 2018 13:40:42 +0200
Subject: [PATCH blktests] Documentation: document prerequisite scriptlets
Message-ID: <20180514114042.12082-1-jthumshirn@suse.de>

The config file is bash and it gets sourced, so all bash magic is
doable in there as well. Document it so others don't have to
re-discover this gem as well.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 Documentation/running-tests.md | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index a479d5e94c5e..b477c0679683 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -66,3 +66,15 @@ command line option.
 QUICK_RUN=1
 TIMEOUT=30
 ```
+
+### Pre-test setups
+
+Some tests, may need special prerequisites, like configfs being
+mounted for NVMe over Fabrics tests. You can add your custom bash
+scriptlets to `config` to get this done, e.g.:
+
+```sh
+if ! test $(grep -q configfs /proc/mounts) ; then
+        mount -t configfs none /sys/kernel/config
+fi
+```
-- 
2.16.3
