From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 23 Jul 2019 23:42:35 +0900
Subject: [PATCH 3/3] lnvm: cast identity structure to (void *) directly
In-Reply-To: <20190723144235.12207-1-minwoo.im.dev@gmail.com>
References: <20190723144235.12207-1-minwoo.im.dev@gmail.com>
Message-ID: <20190723144235.12207-4-minwoo.im.dev@gmail.com>

If we use "tmp" or something like this, we can expect that it just
stores the previous pointer and do something else with the previous
pointer.  But, in this function, it just to cast it out.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Matias Bjorling <mb at lightnvm.io>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
Reviewed-by: Javier Gonz?lez <javier at javigon.com>
---
 nvme-lightnvm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 0b99786..62bdc40 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -422,13 +422,12 @@ static void show_lnvm_id20_ns(struct nvme_nvm_id20 *id, unsigned int flags)
 
 static void show_lnvm_id_ns(struct nvme_nvm_id *id, unsigned int flags)
 {
-	void *tmp = id;
 	switch (id->ver_id) {
 		case 1:
-			show_lnvm_id12_ns(tmp, flags);
+			show_lnvm_id12_ns((void *) id, flags);
 		break;
 		case 2:
-			show_lnvm_id20_ns(tmp, flags);
+			show_lnvm_id20_ns((void *) id, flags);
 		break;
 		default:
 			fprintf(stderr, "Version %d not supported.\n",
-- 
2.17.1
