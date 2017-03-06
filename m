From: roland@kernel.org (Roland Dreier)
Date: Mon,  6 Mar 2017 11:36:21 -0800
Subject: [PATCH v2] fabrics: Handle space-padded TRSVCID and TRADDR fields
Message-ID: <20170306193621.11190-1-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

The TRSVCID and TRADDR fields in the discovery log page are defined
as ASCII strings, which according to the NVMe standard means they
should be space-padded rather than NUL-terminated.

The current nvme-cli code will print all the spaces and possibly some
garbage from the next field.  For example this causes "connect-all"
to write strings that get rejected with "malformed IP address passed."

Fix this by only writing the contents of these fields until the last
non-space character, and limiting the length to the size of the field.

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
Changes since v1: print up to the last non-space character, rather than
stopping at the first space.

 fabrics.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 3f6be53cf332..d93cfe7ab004 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -354,6 +354,17 @@ out:
 	return error;
 }
 
+static int space_strip_len(int max, const char *str)
+{
+	int i;
+
+	for (i = max - 1; i >= 0; i--)
+		if (str[i] != '\0' && str[i] != ' ')
+			break;
+
+	return i + 1;
+}
+
 static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 {
 	int i;
@@ -371,9 +382,13 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		printf("subtype: %s\n", subtype_str(e->subtype));
 		printf("treq:    %s\n", treq_str(e->treq));
 		printf("portid:  %d\n", e->portid);
-		printf("trsvcid: %s\n", e->trsvcid);
+		printf("trsvcid: %.*s\n",
+		       space_strip_len(NVMF_TRSVCID_SIZE, e->trsvcid),
+		       e->trsvcid);
 		printf("subnqn:  %s\n", e->subnqn);
-		printf("traddr:  %s\n", e->traddr);
+		printf("traddr:  %.*s\n",
+		       space_strip_len(NVMF_TRADDR_SIZE, e->traddr),
+		       e->traddr);
 
 		switch (e->trtype) {
 		case NVMF_TRTYPE_RDMA:
@@ -572,12 +587,16 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 				return -EINVAL;
 			p += len;
 
-			len = sprintf(p, ",traddr=%s", e->traddr);
+			len = sprintf(p, ",traddr=%.*s",
+				      space_strip_len(NVMF_TRADDR_SIZE, e->traddr),
+				      e->traddr);
 			if (len < 0)
 				return -EINVAL;
 			p += len;
 
-			len = sprintf(p, ",trsvcid=%s", e->trsvcid);
+			len = sprintf(p, ",trsvcid=%.*s",
+				      space_strip_len(NVMF_TRSVCID_SIZE, e->trsvcid),
+				      e->trsvcid);
 			if (len < 0)
 				return -EINVAL;
 			p += len;
@@ -600,7 +619,9 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 				return -EINVAL;
 			p+= len;
 
-			len = sprintf(p, ",traddr=%s", e->traddr);
+			len = sprintf(p, ",traddr=%.*s",
+				      space_strip_len(NVMF_TRADDR_SIZE, e->traddr),
+				      e->traddr);
 			if (len < 0)
 				return -EINVAL;
 			p += len;
-- 
2.10.2
