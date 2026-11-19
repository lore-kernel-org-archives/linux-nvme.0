Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519E606A32A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vVJuc3SR;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wmEM21oj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=45rMVtLeIVmn3MF/hbdGg8MQeoQzp9MspU7QNk6Eeqk=; b=vVJuc3SRPS+0h2
	35ZQFY96ahAzGtP7YQs9Xwy/9xYOeLSd77azFK+JEbe1WheGka82pefr2B+1N71wuBZO+nU/bQfG0
	xiqt3kY3LTR70ivyS0Zp4rDGNUpOuboJZghWZjfydrZHtPJLxSXAX1xPqTSbVD/I9bR3tw3BNXfoI
	6NWdP0txFstExCDqYuxsIltwm33z/zZx5rc9mzTR714mBLqv7iBOhgRsZJpDD146rCusiagu1UDfC
	wovq4pOt3udFz+spI9Ra1z75bjI8FXs2/RMt/6nWSVKvbmYNNmJ/XTpS5Eq2jSNCRX5o9+Tu0k/sV
	Hyb8XtFLDnl8xim/EWMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzz2-0000000BfAu-0ItN;
	Thu, 19 Nov 2026 11:07:16 +0000
Received: from out-58.mta0.migadu.com ([2001:41d0:1004:224b::3a] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzyz-0000000Bf9m-2APx
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 11:07:14 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=eAX7Oh65Rvfk2NSOBriq4/R0Odj0AYuevXwubXdaX9w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795086431; v=1; x=1795691231;
 b=wmEM21oj5m0XvFaXRTAmbd9q7MXc0hPOkPyBDIfaTugv9elpdF1wk/MVipImFXTJu2SYc76O
 QJRQy17Y12xu5uznW6TSkuqXeHDlP8fWnZoaWRWjBTEI/ZKf6I7cRWZoT7kNUk03YniX7fpEobP
 j1OvZ+ZyMXgemKt4Xzgvg/Cg=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 15c57e5f9138d846;
	Thu, 19 Nov 2026 11:07:10 +0000
X-Mizu-Trace-ID: 15c57e5f9138d846
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Thu, 19 Nov 2026 06:07:00 -0500
Subject: [PATCH v5 1/2] nvme-multipath: apply delayed_removal_secs changes
 to a pending removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-bug-nvme-mpath-set-live-srcu-v5-1-e1483e2e447f@linux.dev>
References: <20261119-bug-nvme-mpath-set-live-srcu-v5-0-e1483e2e447f@linux.dev>
In-Reply-To: <20261119-bug-nvme-mpath-set-live-srcu-v5-0-e1483e2e447f@linux.dev>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_030713_779172_DB363D73 
X-CRM114-Status: GOOD (  16.44  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With delayed_removal_secs set, removing the last path of a namespace
head doesn't delete the head right away. nvme_mpath_remove_disk()
queues remove_work with the configured delay, and bios submitted in the
meantime wait on head->requeue_list in case a path comes back.

A write to delayed_removal_secs only takes effect for removals that
start later. A removal that is already pending keeps the old delay, so
clearing the attribute leaves the queued bios waiting until that delay
expires instead of failing them, and lowering or raising it doesn't
move the pending removal either.

Requeue a pending remove_work with the new delay when the attribute is
written, cancelling it first so that the module reference taken for it
carries over. Have nvme_init_ns_head() cancel the pending removal
before it drops subsys->lock rather than after, so that a write to the
attribute cannot requeue the removal once a path is back.

With delayed_removal_secs set and no path left, the attribute is
changed two seconds later and the head is removed after (mean of two
runs, min-max in parentheses):

  delay (s)  before (ms)            after (ms)             change
  30 -> 0    26655 (26537-26772)        8 (8-8)            -99.97%
  30 -> 5    28298 (28094-28501)     5514 (5510-5517)      -81%
  10 -> 30    8112 (8106-8117)      30376 (30106-30646)    +274%

A direct read queued before the 30 -> 0 write fails after:

  before (ms)            after (ms)   change
  26607 (26450-26764)    4 (4-4)      -99.98%

Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/nvme/host/core.c      | 7 +++++--
 drivers/nvme/host/multipath.c | 6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4aa02869b790..48d432c5d7aeb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4231,12 +4231,15 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
 	ns->head = head;
-	mutex_unlock(&ctrl->subsys->lock);
-
 #ifdef CONFIG_NVME_MULTIPATH
+	/*
+	 * Cancel a pending head removal under subsys->lock, so that
+	 * delayed_removal_secs_store() never requeues it once a path is back.
+	 */
 	if (cancel_delayed_work(&head->remove_work))
 		module_put(THIS_MODULE);
 #endif
+	mutex_unlock(&ctrl->subsys->lock);
 	return 0;
 
 out_put_ns_head:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ae8059366b57d..51c59cc3ea246 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1242,6 +1242,12 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 	mutex_lock(&head->subsys->lock);
 	head->delayed_removal_secs = sec;
 	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
+	/*
+	 * Apply the new delay to a removal that is still pending. The module
+	 * reference taken for it carries over to the requeued work.
+	 */
+	if (cancel_delayed_work(&head->remove_work))
+		queue_delayed_work(nvme_wq, &head->remove_work, sec * HZ);
 	mutex_unlock(&head->subsys->lock);
 	/*
 	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen

-- 
2.43.0


