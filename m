From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 17 Jul 2019 11:12:58 -0600
Subject: [PATCH blktests v2 11/12] common: Use sysfs instead of modinfo for
 _have_module_param()
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
Message-ID: <20190717171259.3311-12-logang@deltatee.com>

Using modinfo fails if the given module is built-in.

Instead, if the module is already in the kernel, check for the
parameter in sysfs.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index a487cc69026c..41aee3aaa735 100644
--- a/common/rc
+++ b/common/rc
@@ -48,6 +48,12 @@ _have_modules() {
 }
 
 _have_module_param() {
+	if [ -d "/sys/module/$1" ]; then
+		if [ -e "/sys/module/$1/parameters/$2" ]; then
+			return 0
+		fi
+	fi
+
 	if ! modinfo -F parm -0 "$1" | grep -q -z "^$2:"; then
 		SKIP_REASON="$1 module does not have parameter $2"
 		return 1
-- 
2.17.1
