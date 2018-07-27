From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Jul 2018 12:26:32 +0200
Subject: [PATCH 6/6] fabrics: display controller ID in discovery log output
In-Reply-To: <20180727102632.32455-1-hare@suse.de>
References: <20180727102632.32455-1-hare@suse.de>
Message-ID: <20180727102632.32455-7-hare@suse.de>

To figure out if a subsystem supports the static or dynamic controller
model we need to display the controller ID in the discovery log output.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fabrics.c b/fabrics.c
index b1219a0..8601001 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -399,6 +399,7 @@ static void print_discovery_log(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 		printf("subtype: %s\n", subtype_str(e->subtype));
 		printf("treq:    %s\n", treq_str(e->treq));
 		printf("portid:  %d\n", e->portid);
+		printf("cntlid:  %x\n", e->cntlid);
 		printf("trsvcid: %.*s\n",
 		       space_strip_len(NVMF_TRSVCID_SIZE, e->trsvcid),
 		       e->trsvcid);
-- 
2.13.7
