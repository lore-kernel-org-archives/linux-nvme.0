From: jsmart2021@gmail.com (James Smart)
Date: Wed, 10 Jul 2019 16:27:35 -0700
Subject: [PATCH rfc 1/6] nvme-cli: ignore arguments that pass in "none"
In-Reply-To: <20190710232740.26734-1-jsmart2021@gmail.com>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
Message-ID: <20190710232740.26734-2-jsmart2021@gmail.com>

As we want to support discovery uevents over different
transports, we want to allow the kernel to provide missing
information in the form of none and have nvme-cli properly
ignore it.

One example is the host_traddr. If it is not set (which means
that the default route determined the host address) we will
want to do the same for newly discovered controllers.

So allow users to pass 'none' arguments as well.

Example:
  nvme connect-all ... --hostnqn=none --hostid=none --host_traddr=none

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>

---
Patch originated from Sagi in an RFC
Fixed typo in Sagi's patch on cfg.hostid
---
 fabrics.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 573a6ef..cc91d00 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -565,7 +565,7 @@ add_argument(char **argstr, int *max_len, char *arg_str, char *arg)
 {
 	int len;
 
-	if (arg) {
+	if (arg && strcmp(arg, "none")) {
 		len = snprintf(*argstr, *max_len, ",%s=%s", arg_str, arg);
 		if (len < 0)
 			return -EINVAL;
@@ -658,14 +658,14 @@ retry:
 		return -EINVAL;
 	p += len;
 
-	if (cfg.hostnqn) {
+	if (cfg.hostnqn && strcmp(cfg.hostnqn, "none")) {
 		len = sprintf(p, ",hostnqn=%s", cfg.hostnqn);
 		if (len < 0)
 			return -EINVAL;
 		p += len;
 	}
 
-	if (cfg.hostid) {
+	if (cfg.hostid && strcmp(cfg.hostid, "none")) {
 		len = sprintf(p, ",hostid=%s", cfg.hostid);
 		if (len < 0)
 			return -EINVAL;
@@ -700,7 +700,7 @@ retry:
 		p += len;
 	}
 
-	if (cfg.host_traddr) {
+	if (cfg.host_traddr && strcmp(cfg.host_traddr, "none")) {
 		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
 		if (len < 0)
 			return -EINVAL;
-- 
2.13.7
