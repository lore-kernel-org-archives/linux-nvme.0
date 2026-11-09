Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB0606A326
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i5WLQnHr;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DRR2E9vC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yvqkbcXo1+3OSpX9bYIB3B1zJixepqSp7xabLq0F1VM=; b=i5WLQnHr5afSHi
	cXOloyPIkieasf1Sd4+aJaWZDS6jDLiQ5gBELjawqy6Y28qFahj48jvs0tPeUU4Yfx8PuIQVUS+7o
	zD4QHXgeYfE+cROtVCGd88+C4YDnG9ZOmqO/W5nJOQQannZkDvAAIKUfzwrKEFqK/SylG+jXbecmZ
	C2BfPtP+Yebn87gxKImr8023BmrlTwtmuputfzqa2+q0ME7leHE2B6QcVjDPWQLhU1yAD87HdF9ph
	eUQH5BI0S4fHbBBVD5lnNH2sUsAvL+sLtVLIb6dVBGb5N2c/wl4dp+eNwqMYIhl4mByKTG79Vkuu7
	YXcHpLdkNCEythvO4wEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF65-0000000H7eg-2swB;
	Mon, 09 Nov 2026 02:27:01 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF63-0000000H7d2-3lLM
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 02:27:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794191214; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yvqkbcXo1+3OSpX9bYIB3B1zJixepqSp7xabLq0F1VM=;
	b=DRR2E9vCCWCIpP6gSBwdj9ypDKGgvAttXFQ11MUm6mdsdxTZD3bNRpcb27UdEMR31AUMve1svf8/6P1iyBFydyRhhpQgD3x/xn71urYEwpcfi8kgsewYgATEpq433jm/dceP3zSVrXZZV1sS+yZCyEPxT/LU3qdqN7Avdf9hl1s=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEIBGfl_1794191213;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEIBGfl_1794191213 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 10:26:53 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/5] nvme-fc: fix use-after-free in nvme_fc_match_disconn_ls()
Date: Mon,  9 Nov 2026 10:26:43 +0800
Message-ID: <20261109022646.290792-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261109022646.290792-1-kanie@linux.alibaba.com>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_182700_101086_D59E82F0 
X-CRM114-Status: GOOD (  20.01  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
dropped the rport lock inside the loop to put the reference of a
non-matching controller, because nvme_fc_ctrl_free() takes the rport
lock to unlink the controller. But no iterator is sound across that
drop: with list_for_each_entry_safe() the prefetched next entry can be
freed in the window, and with a plain iterator the loop's own
nvme_fc_ctrl_put() can be the final reference, freeing the current
entry before the iterator reads its ->next pointer.

The reference dance is unnecessary in the first place. An entry cannot
leave ctrl_list while rport->lock is held, as the final put unlinks it
under that very lock, so association_id can be inspected under
ctrl->lock without holding a reference. Take a reference only for the
matching controller, still under the rport lock, and hand it to the
caller as before. The loop then no longer needs to drop the lock at
all, which also removes the reason the lock was dropped for in the
first place.

Fixes: b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---

Reproduced under KASAN in a VM through fcloop with several controllers
on one remote port and a tbkas force-reconnect racing concurrent
controller disconnects; the lock-drop window was widened with a
test-only mdelay(200) to make the microsecond window deterministic:

  BUG: KASAN: slab-use-after-free in nvme_fc_match_disconn_ls
  Read of size 8 by task kworker
  Workqueue: events nvme_fc_handle_ls_rqst_work
  Call Trace:
   nvme_fc_match_disconn_ls
   nvme_fc_ls_disconnect_assoc
   nvme_fc_handle_ls_rqst_work
   process_one_work

The freed object was the prefetched next entry, allocated by
nvme_fc_alloc_ctrl() on connect and freed by nvme_free_ctrl() on the
concurrent teardown. The loop increment dereferences it before
nvme_fc_ctrl_get() gets a chance to reject it, which is why the
get-unless-zero check in the loop body does not help. The reworked
loop does not drop the lock, so no such window is left to widen.
---
 drivers/nvme/host/fc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0b9ff50d26ff..e28eafc362db 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1470,29 +1470,31 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 {
 	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
 					&lsop->rqstbuf->rq_dis_assoc;
-	struct nvme_fc_ctrl *ctrl, *tmp, *ret = NULL;
+	struct nvme_fc_ctrl *ctrl, *ret = NULL;
 	struct nvmefc_ls_rcv_op *oldls = NULL;
 	u64 association_id = be64_to_cpu(rqst->associd.association_id);
 	unsigned long flags;
 
 	spin_lock_irqsave(&rport->lock, flags);
 
-	list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
-		if (!nvme_fc_ctrl_get(ctrl))
-			continue;
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
 		spin_lock(&ctrl->lock);
 		if (association_id == ctrl->association_id) {
-			oldls = ctrl->rcv_disconn;
-			ctrl->rcv_disconn = lsop;
-			ret = ctrl;
+			/*
+			 * Entries cannot leave the list while rport->lock is
+			 * held, so they can be inspected without a reference.
+			 * Only the match needs one, for the caller.
+			 */
+			if (nvme_fc_ctrl_get(ctrl)) {
+				oldls = ctrl->rcv_disconn;
+				ctrl->rcv_disconn = lsop;
+				ret = ctrl;
+			}
 		}
 		spin_unlock(&ctrl->lock);
 		if (ret)
 			/* leave the ctrl get reference */
 			break;
-		spin_unlock_irqrestore(&rport->lock, flags);
-		nvme_fc_ctrl_put(ctrl);
-		spin_lock_irqsave(&rport->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);
-- 
2.43.7


