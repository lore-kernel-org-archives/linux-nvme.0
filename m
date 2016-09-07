From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed,  7 Sep 2016 16:08:23 -0700
Subject: [PATCH] nvme-cli: change nqntype to subtype, per spec
Message-ID: <1473289703-17105-1-git-send-email-james_p_freyensee@linux.intel.com>

Fabrics spec has no field called 'nqntype', rather
it's 'subtype'.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 fabrics.c | 14 +++++++-------
 nvme.h    |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index e7e3c56..04b4ff9 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -105,14 +105,14 @@ static inline const char *adrfam_str(__u8 adrfam)
 	return arg_str(adrfams, ARRAY_SIZE(adrfams), adrfam);
 }
 
-static const char * const nqntypes[] = {
+static const char * const subtypes[] = {
 	[NVME_NQN_DISC]		= "discovery subsystem",
 	[NVME_NQN_NVME]		= "nvme subsystem",
 };
 
-static inline const char *nqntype_str(__u8 nqntype)
+static inline const char *subtype_str(__u8 subtype)
 {
-	return arg_str(nqntypes, ARRAY_SIZE(nqntypes), nqntype);
+	return arg_str(subtypes, ARRAY_SIZE(subtypes), subtype);
 }
 
 static const char * const treqs[] = {
@@ -367,7 +367,7 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		printf("=====Discovery Log Entry %d======\n", i);
 		printf("trtype:  %s\n", trtype_str(e->trtype));
 		printf("adrfam:  %s\n", adrfam_str(e->adrfam));
-		printf("nqntype: %s\n", nqntype_str(e->nqntype));
+		printf("subtype: %s\n", subtype_str(e->subtype));
 		printf("treq:    %s\n", treq_str(e->treq));
 		printf("portid:  %d\n", e->portid);
 		printf("trsvcid: %s\n", e->trsvcid);
@@ -499,14 +499,14 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 	bool discover = false;
 	int len;
 
-	switch (e->nqntype) {
+	switch (e->subtype) {
 	case NVME_NQN_DISC:
 		discover = true;
 	case NVME_NQN_NVME:
 		break;
 	default:
-		fprintf(stderr, "skipping unsupported NQNtype %d\n",
-			 e->nqntype);
+		fprintf(stderr, "skipping unsupported subtype %d\n",
+			 e->subtype);
 		return -EINVAL;
 	}
 
diff --git a/nvme.h b/nvme.h
index e602818..e9e4433 100644
--- a/nvme.h
+++ b/nvme.h
@@ -566,7 +566,7 @@ struct nvme_bar_cap {
 struct nvmf_disc_rsp_page_entry {
 	__u8	trtype;
 	__u8	adrfam;
-	__u8	nqntype;
+	__u8	subtype;
 	__u8	treq;
 	__le16	portid;
 	__le16	cntlid;
-- 
2.7.4
