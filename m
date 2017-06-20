From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 20 Jun 2017 14:42:26 +0200
Subject: [PATCH nvme-cli v2] fabrics: add hostid option to connect command
Message-ID: <20170620124226.11197-1-jthumshirn@suse.de>

Add an option to pass in the hostid either via command line or a new config
file /etc/nvme/hostid.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
Changes to v1:
* Create hostid in rpm %post scriptlet

 fabrics.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 linux/nvme.h |  1 +
 nvme.spec.in |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index bbcca470c72a..87cdba2851d1 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -51,6 +51,7 @@ static struct config {
 	char *trsvcid;
 	char *host_traddr;
 	char *hostnqn;
+	char *hostid;
 	char *nr_io_queues;
 	char *queue_size;
 	char *keep_alive_tmo;
@@ -63,6 +64,7 @@ static struct config {
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
 #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
 #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
+#define PATH_NVMF_HOSTID	"/etc/nvme/hostid"
 #define SYS_NVME		"/sys/class/nvme"
 #define MAX_DISC_ARGS		10
 
@@ -456,6 +458,29 @@ out:
 	return ret;
 }
 
+static int nvmf_hostid_file(void)
+{
+	FILE *f;
+	char hostid[NVMF_HOSTID_SIZE];
+	int ret = false;
+
+	f = fopen(PATH_NVMF_HOSTID, "r");
+	if (f == NULL)
+		return false;
+
+	if (fgets(hostid, sizeof(hostid), f) == NULL)
+		goto out;
+
+	cfg.hostid = strdup(hostid);
+	if (!cfg.hostid)
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
@@ -516,6 +541,14 @@ static int build_options(char *argstr, int max_len)
 		max_len -= len;
 	}
 
+	if (cfg.hostid || nvmf_hostid_file()) {
+		len = snprintf(argstr, max_len, ",hostid=%s", cfg.hostid);
+		if (len < 0)
+			return -EINVAL;
+		argstr += len;
+		max_len -= len;
+	}
+
 	if (cfg.nr_io_queues) {
 		len = snprintf(argstr, max_len, ",nr_io_queues=%s",
 				cfg.nr_io_queues);
@@ -582,6 +615,13 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		p += len;
 	}
 
+	if (cfg.hostid) {
+		len = sprintf(p, ",hostid=%s", cfg.hostid);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_LOOP: /* loop */
 		len = sprintf(p, ",transport=loop");
@@ -782,6 +822,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"trsvcid",     's', "LIST", CFG_STRING, &cfg.trsvcid,     required_argument, "transport service id (e.g. IP port)" },
 		{"host-traddr", 'w', "LIST", CFG_STRING, &cfg.host_traddr, required_argument, "host traddr (e.g. FC WWN's)" },
 		{"hostnqn",     'q', "LIST", CFG_STRING, &cfg.hostnqn,     required_argument, "user-defined hostnqn (if default not used)" },
+		{"hostid",      'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"queue-size",  'Q', "LIST", CFG_STRING, &cfg.queue_size,  required_argument, "number of io queue elements to use (default 128)" },
 		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
 		{NULL},
@@ -815,6 +856,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"trsvcid",         's', "LIST", CFG_STRING, &cfg.trsvcid,         required_argument, "transport service id (e.g. IP port)" },
 		{"host-traddr",     'w', "LIST", CFG_STRING, &cfg.host_traddr,     required_argument, "host traddr (e.g. FC WWN's)" },
 		{"hostnqn",         'q', "LIST", CFG_STRING, &cfg.hostnqn,         required_argument, "user-defined hostnqn" },
+		{"hostid",          'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"nr-io-queues",    'i', "LIST", CFG_STRING, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
 		{"queue-size",      'Q', "LIST", CFG_STRING, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
diff --git a/linux/nvme.h b/linux/nvme.h
index b2c8dbb2244b..08bf0b13cf38 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -23,6 +23,7 @@
 /* However the max length of a qualified name is another size */
 #define NVMF_NQN_SIZE		223
 
+#define NVMF_HOSTID_SIZE        36
 #define NVMF_TRSVCID_SIZE	32
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
diff --git a/nvme.spec.in b/nvme.spec.in
index c14b3f0f96dc..0be61e398fd0 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -7,6 +7,7 @@ Group: 		Development/Tools
 URL: 		https://github.com/linux-nvme/nvme-cli/
 Source: 	nvme-@@VERSION@@.tar.gz
 Provides:	nvme
+Requires(post): uuidgen
 BuildRoot:	%{_tmppath}/%{name}-%{version}-root
 
 %description
@@ -39,6 +40,9 @@ if [ $1 = 1 ]; then # 1 : This package is being installed for the first time
 		install -D /dev/null /etc/nvme/hostnqn
 		echo $(nvme gen-hostnqn) > /etc/nvme/hostnqn
         fi
+        if [ ! -f /etc/nvme/hostid ]; then
+                uuidgen > /etc/nvme/hostid
+        fi
 fi
 
 %preun
-- 
2.12.3
