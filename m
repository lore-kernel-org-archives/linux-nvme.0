From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Mon, 5 Jun 2017 11:54:28 +0200 (CEST)
Subject: [PATCH, TRIVIAL] nvme-rdma: fix typo in comment
Message-ID: <1816979501.73970510.1496656468030.JavaMail.zimbra@kalray.eu>

Fix trivial spelling mistake.

Signed-off-by: Marta Rybczynska <marta.rybczynska at kalray.eu>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 80682f7..308be1d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1083,7 +1083,7 @@ static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
        wr.send_flags = 0;
 
        /*
-        * Unsignalled send completions are another giant desaster in the
+        * Unsignalled send completions are another giant disaster in the
         * IB Verbs spec:  If we don't regularly post signalled sends
         * the send queue will fill up and only a QP reset will rescue us.
         * Would have been way to obvious to handle this in hardware or
-- 
1.8.3.1
