From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:37:01 -0700
Subject: [PATCH nvme-cli 13/13] nvme-cli: Report the NVMe 1.4 NPWG, NPWA, NPDG,
 NPDA and NOWS fields
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-14-bvanassche@acm.org>

>From the NVMe 1.4 paragraph about NSFEAT:

"Bit 4 if set to 1: indicates that the fields NPWG, NPWA, NPDG, NPDA, and
NOWS are defined for this namespace and should be used by the host for I/O
optimization; and NOWS defined for this namespace shall adhere to Optimal
Write Size field setting defined in NVM Sets Attributes Entry (refer to
Figure 251) for the NVM Set with which this namespace is associated."

Hence only report these fields if bit 4 in NSFEAT has been set.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 nvme-print.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index 94222a3b1c15..17478f9856e2 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -721,6 +721,13 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	printf("nabspf  : %d\n", le16_to_cpu(ns->nabspf));
 	printf("noiob   : %d\n", le16_to_cpu(ns->noiob));
 	printf("nvmcap  : %.0Lf\n", int128_to_double(ns->nvmcap));
+	if (ns->nsfeat & 0x10) {
+		printf("npwg    : %u\n", le16_to_cpu(ns->npwg));
+		printf("npwa    : %u\n", le16_to_cpu(ns->npwa));
+		printf("npdg    : %u\n", le16_to_cpu(ns->npdg));
+		printf("npda    : %u\n", le16_to_cpu(ns->npda));
+		printf("nows    : %u\n", le16_to_cpu(ns->nows));
+	}
 	printf("nsattr	: %u\n", ns->nsattr);
 	printf("nvmsetid: %d\n", le16_to_cpu(ns->nvmsetid));
 	printf("anagrpid: %u\n", le32_to_cpu(ns->anagrpid));
-- 
2.22.0.rc3
