Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56916606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2kfwoRXz;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qsBfI+9E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tKt6WOZ9PEiJ+eM/eRoNZhb6Tu7MMexO9ODXWOghi84=; b=2kfwoRXzvh5vqg
	vbqfe3/a2ng9BwLx2MSg9OljIyscI4gs9edoLhBVVZR9T6agE3LitlFSV3t9wQqiGEJ4RPMh65q0x
	UFr8XtOinSEYQpiqCH2kodKyyK7qd7TX/+QdLenDe7EHL/tY+6QMGZhT+RD+rGlRtT+UAOkeIoop8
	mFBARhuuZ/sW2WIL97VZgjX9bK52+6mXRdGU8y7j9aKQiFf1Jv5J0DTykC7fjqVOiRgA6+fimDGGR
	olEZRfiAMSDoW4LV5TPr3Yqevglq5Z+RzRESE2oduhmlIc+tiO4vr5yP2fYotrbLGmkPfY9kylSN6
	P3GXXgAPIYTwbWQCirjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EE-0000000B1Dr-1yCU;
	Fri, 06 Nov 2026 01:58:54 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EB-0000000B1C3-2tKg
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 01:58:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793930329; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tKt6WOZ9PEiJ+eM/eRoNZhb6Tu7MMexO9ODXWOghi84=;
	b=qsBfI+9E3iLLP5gfT9+ZacNLeH5mu3soOvCYaTT+W3BMdwf/WrCjBS4FWBKdwj7Lqvr3d9DMJ8JT3WCOweMApNW8JFFnyUlPqV/vk+a/PARyCaZLPAhvlBTUfg00jR6uAHL0lo3KjSGO3VsZRxDjhaE8SXVNJY22F2JD70F/K5s=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE9z00g_1793930328;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE9z00g_1793930328 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:58:49 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/6] nvme-fc: fix iterator over rport->ctrl_list in nvme_fc_match_disconn_ls()
Date: Fri,  6 Nov 2026 09:58:38 +0800
Message-ID: <20261106015842.3534898-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106015842.3534898-1-kanie@linux.alibaba.com>
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_175851_880240_5F3FB8FE 
X-CRM114-Status: GOOD (  17.25  )
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
switched the loop to list_for_each_entry_safe() to allow dropping the
rport lock for the nvme_fc_ctrl_put() of a non-matching controller.
But the safe iterator only protects the current entry within one
iteration: the next entry is cached before the body runs, and while
the lock is dropped that entry can run through its own final put into
nvme_fc_ctrl_free(), which removes it from the list and frees it.
The next iteration then dereferences freed memory.

The safe variant is not needed here at all. The reference the loop
takes on the current entry pins it on the list until the iteration
moves on, so a plain list_for_each_entry() tolerates the lock drop:
while the lock is held the current entry cannot be unlinked, and once
the lock is dropped the cached ->next of the pinned entry still points
at a valid list member or the head.

Switch back to the plain iterator.

Fixes: b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

---

Reproduced under KASAN in a VM through fcloop with three or more
controllers on one remote port, a tbkas force-reconnect racing
concurrent controller disconnects.  The lock-drop window was widened
with a test-only mdelay(200) inserted at the same place in both the
buggy and the fixed version so the iterator is the only variable; the
stock microsecond window did not trigger in 400 iterations of the
same workload.

  BUG: KASAN: slab-use-after-free in nvme_fc_match_disconn_ls
  Read of size 8 by task kworker
  Workqueue: events nvme_fc_handle_ls_rqst_work
  Call Trace:
   nvme_fc_match_disconn_ls
   nvme_fc_ls_disconnect_assoc
   nvme_fc_handle_ls_rqst_work
   process_one_work

The object was allocated by nvme_fc_alloc_ctrl() on connect and freed
by nvme_free_ctrl() on the concurrent teardown of the cached next
entry.  With the plain iterator the identical amplified sequence
reports nothing and survives; the read hits the pinned current entry,
which cannot be freed while the loop holds its reference.
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0b9ff50d26ff..edf192055618 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1470,14 +1470,14 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
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
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
 		if (!nvme_fc_ctrl_get(ctrl))
 			continue;
 		spin_lock(&ctrl->lock);
-- 
2.43.7


