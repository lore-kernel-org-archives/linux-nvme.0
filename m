From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:24 +0200
Subject: [PATCH 08/11] Add option to save discovery raw log to a file
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-9-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@ssi.samsung.com>

root at host:~# nvme discover -t rdma -a 192.168.2.2 -p 1023 -r disc.raw
Discovery log is saved to disc.raw

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
Tested-by: Armen Baloyan <armenx.baloyan at intel.com>
Tested-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index ad79017..50dfcd8 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -45,6 +45,7 @@ struct config {
 	char *transport;
 	char *traddr;
 	char *trsvcid;
+	char *raw;
 } cfg = { 0 };
 
 #define BUF_SIZE		4096
@@ -287,6 +288,28 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 	}
 }
 
+static void save_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
+{
+	int fd;
+	int len, ret;
+
+	fd = open(cfg.raw, O_CREAT|O_RDWR|O_TRUNC, S_IRUSR|S_IWUSR);
+	if (fd < 0) {
+		fprintf(stderr, "failed to open %s: %s\n", cfg.raw, strerror(errno));
+		return;
+	}
+
+	len = sizeof(struct nvmf_disc_rsp_page_hdr) +
+			numrec * sizeof(struct nvmf_disc_rsp_page_entry);
+	ret = write(fd, log, len);
+	if (ret < 0)
+		fprintf(stderr, "failed to write to %s: %s\n", cfg.raw, strerror(errno));
+	else
+		printf("Discovery log is saved to %s\n", cfg.raw);
+
+	close(fd);
+}
+
 static int build_options(char *argstr, int max_len)
 {
 	int len;
@@ -347,6 +370,8 @@ int discover(const char *desc, int argc, char **argv)
 			"transport address" },
 		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
 			"transport service id (e.g. IP port)" },
+		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw, required_argument,
+			"raw" },
 		{0},
 	};
 
@@ -370,7 +395,10 @@ int discover(const char *desc, int argc, char **argv)
 
 	switch (ret) {
 	case DISC_OK:
-		print_discovery_log(log, numrec);
+		if (cfg.raw)
+			save_discovery_log(log, numrec);
+		else
+			print_discovery_log(log, numrec);
 		break;
 	case DISC_GET_NUMRECS:
 		fprintf(stderr, "Get number of discovery log entries failed.\n");
-- 
2.1.4
