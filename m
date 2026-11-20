Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4236606A333
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2yKrFRbH;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bk17wFKA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2gSV0needxPj0T4ZOpzhkN7DJbnt1l+TnjQVhyw0V2o=; b=2yKrFRbHGJVMTa
	uRkR4v6+hFShTkwp4s+a6xnzXcCGhyX7hqrp3+E+Tt0B8sFeZBRTwaXZVATBtIzcyoaP6Rc/HV1Xr
	HD9U8eJdovHGk1qE5evRARH3m4lS51dyfBTfJWN0BkeCmNOQnpJedv+4TZkoGSfA7p1bEy1BxyCm1
	E1/8c/d4ClOhn9Dr6KCJqFrGj9PJWqvtDH6yB+j7oZJvEZbdnpU3EKGij6V9/UW1l2AccMQt3oeF3
	AYF05xiBT2jZMe/87awN3spAsV6Fo8aSCk9mmM0Fff2UfVhezRihGpXBBnKi0B+YP6FjMtqEbdaac
	lvWlK6fHLTShbDbEI5xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUDNe-0000000DpPd-1RPy;
	Fri, 20 Nov 2026 01:25:34 +0000
Received: from out-4.mta1.migadu.com ([95.215.58.4] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUDNc-0000000DpOD-06yR
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 01:25:33 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=GjCy52YedJyFjyXxDoBsnPsbz64C4vxsF8XxpUrpVoU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795137930; v=1; x=1795742730;
 b=bk17wFKAmAF9UTWvkUTuu3MXNc8cgH5ElQ2OcAAYM2zdSdqDPzc4ZRBCznZ2JtCql2MdwKbb
 QoQh/XWnfWxsxOL9TNtr3vziatcQj/AWmSWQqL5LhGwPJjEiRHJ9HatQC8XRvEj9ezpVitgixv3
 noj967tAkCLOEawaiwqLGuUk=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 1bd11eee1c74e2dd;
	Fri, 20 Nov 2026 01:25:24 +0000
X-Mizu-Trace-ID: 1bd11eee1c74e2dd
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Thu, 19 Nov 2026 20:25:02 -0500
Subject: [PATCH v6 2/3] nvme-multipath: apply delayed_removal_secs changes
 to a pending removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-bug-nvme-mpath-set-live-srcu-v6-2-da85b18b274b@linux.dev>
References: <20261119-bug-nvme-mpath-set-live-srcu-v6-0-da85b18b274b@linux.dev>
In-Reply-To: <20261119-bug-nvme-mpath-set-live-srcu-v6-0-da85b18b274b@linux.dev>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_172532_218224_BAC64242 
X-CRM114-Status: GOOD (  16.85  )
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
move the pending removal either. When paths remain but none of them is
usable, for example because they are ANA inaccessible, nothing
resubmits the queued bios after the attribute is cleared at all.

Requeue a pending remove_work with the new delay when the attribute is
written, cancelling it first so that the module reference taken for it
carries over. Have nvme_init_ns_head() cancel the pending removal
before it drops subsys->lock rather than after, so that a write to the
attribute cannot requeue the removal once a path is back. When the
attribute is cleared, kick requeue_work, so that the queued bios fail
right away if there is still no usable path.

With delayed_removal_secs set and no path left, the attribute is
changed two seconds later and the head is removed after (mean of two
runs, min-max in parentheses):

  delay (s)  before (ms)            after (ms)             change
  30 -> 0    26311 (26103-26518)      8.5 (8-9)            -99.97%
  30 -> 5    28281 (28037-28525)     5293 (5198-5388)      -81%
  10 -> 30    8110 (8097-8122)      30094 (30057-30130)    +271%

A direct read queued before the 30 -> 0 write fails this long after
the write, with no path left and with the only path ANA inaccessible
("> 15000" means it was still queued 15 s later):

  paths         before (ms)            after (ms)   change
  none          26261 (26071-26451)    4.5 (4-5)    -99.98%
  inaccessible  > 15000                4.5 (4-5)    < -99.97%

Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  7 +++++--
 drivers/nvme/host/multipath.c | 11 +++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

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
index 9958d08cd3829..df96933f49459 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1251,6 +1251,13 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 	mutex_lock(&head->subsys->lock);
 	head->delayed_removal_secs = sec;
 	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
+	/*
+	 * Apply the new delay to a removal that is still pending. The module
+	 * reference taken for it carries over to the requeued work.
+	 */
+	if (cancel_delayed_work(&head->remove_work))
+		queue_delayed_work(nvme_wq, &head->remove_work,
+				   nvme_delayed_removal_jiffies(sec));
 	mutex_unlock(&head->subsys->lock);
 	/*
 	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen
@@ -1258,6 +1265,10 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 	 */
 	synchronize_srcu(&head->srcu);
 
+	/* Resubmit queued bios, so that they fail without a usable path */
+	if (!sec)
+		kblockd_schedule_work(&head->requeue_work);
+
 	return count;
 }
 

-- 
2.43.0


