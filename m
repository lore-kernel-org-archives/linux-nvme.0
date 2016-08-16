From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 16 Aug 2016 12:46:27 +0300
Subject: [PATCH v3 nvme-cli 4/4] fabrics: Take the hostnqn parameter from a
 conf file if not given
In-Reply-To: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
References: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
Message-ID: <1471340787-26922-5-git-send-email-sagi@grimberg.me>

In order to allow persistent hostnqns, take the hostnqn parameter
for /etc/nvme/hostnqn if exists.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 6bbe239c1f70..26c4e2214a65 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -57,6 +57,7 @@ struct config {
 #define BUF_SIZE		4096
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
 #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
+#define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
 #define MAX_DISC_ARGS		10
 
 enum {
@@ -405,6 +406,29 @@ static void save_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 	close(fd);
 }
 
+static int nvmf_hostnqn_file(void)
+{
+	FILE *f;
+	char hostnqn[NVMF_NQN_SIZE];
+	int ret = false;
+
+	f = fopen(PATH_NVMF_HOSTNQN, "r");
+	if (f == NULL)
+		return false;
+
+	if (fgets(hostnqn, sizeof(hostnqn), f) == NULL)
+		goto out;
+
+	cfg.hostnqn = strdup(hostnqn);
+	if (!cfg.hostnqn)
+		goto out;
+
+	ret = true;
+out:
+	fclose(f);
+	return ret;
+}
+
 static int build_options(char *argstr, int max_len)
 {
 	int len;
@@ -449,7 +473,7 @@ static int build_options(char *argstr, int max_len)
 		max_len -= len;
 	}
 
-	if (cfg.hostnqn) {
+	if (cfg.hostnqn || nvmf_hostnqn_file()) {
 		len = snprintf(argstr, max_len, ",hostnqn=%s", cfg.hostnqn);
 		if (len < 0)
 			return -EINVAL;
-- 
1.9.1
