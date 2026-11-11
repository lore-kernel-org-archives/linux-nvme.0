Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175D606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vbH/3DxA;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=e99vVF9B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WIaBD4pgSCmuibi93MYmQK12NXnIoOv5CQ8dP5MJQxs=; b=vbH/3DxAQ4LvUE
	6HwIa6ZgZp4Abuwp/17ND0dCQWZh9udbNB5+rVQ0jf6wNSdmTUq83mGa7ZhBPf9ZiIS7rTJ1fKnFv
	evUZ7TdkVh0qje07iF69Ejuzin+y2QgQDV7xaeOv9pwOvcOFcDL9o2grGbhR/H5Hp0E2GeqXD72yU
	LwxApCYaaoRdoaMo0j1WFs5cAuxzrMj2cOUP9P3Pe6k2wG1JQsSPElGJ6FrrmVE9yLKmD7uzpm8gC
	OD3IgWTRL1Lw7+1fOLR2Z0XvfMAou83StcvHX0Ii6MAl0DoyehVZS+xAMXssj6egAugXGIi8owdwe
	Rp89C3/M60gYwTtNXhxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR86N-00000006mau-0TGI;
	Wed, 11 Nov 2026 13:10:59 +0000
Received: from out-76.mta1.migadu.com ([95.215.58.76] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR86K-00000006mZi-2NS5
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 13:10:57 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=YZBAqSuD53IPCe0IdHJimmdy+f3FgILysUny7J+HSiE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794402654; v=1; x=1795007454;
 b=e99vVF9Bq5ioTiAPPx6HwDhBph8Rh4QyUJedrpGrlfh8pBmnJ5QQ8wD5fHKLSeNulAb8B42Y
 GbPs+LP8p7fSnUYQTw5a3DQDIJ6g5X7ugJ96TWtABVeyWI60Yp5s56yUWdYfe8y+KfHFYPEcrqD
 U/XDAzosWrz7cCUgjkFnirw4=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id c557147aac95f8f3;
	Wed, 11 Nov 2026 13:10:54 +0000
X-Mizu-Trace-ID: c557147aac95f8f3
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Wed, 11 Nov 2026 08:10:22 -0500
Subject: [PATCH v2 2/2] nvme-multipath: don't wait for a grace period in
 nvme_mpath_set_live()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-bug-nvme-mpath-set-live-srcu-v2-2-fc772914d293@linux.dev>
References: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
In-Reply-To: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_051056_760400_78BED2E4 
X-CRM114-Status: GOOD (  14.28  )
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

When a path goes live, nvme_mpath_set_live() waits for an SRCU grace
period of the namespace head before kicking the requeue work, so that
bios which found no usable path are on the requeue list by the time it
runs.

The ANA work calls nvme_mpath_set_live() for every namespace that
becomes optimized or non-optimized, one after another, so an ANA change
waits for one grace period per namespace.

Start the grace period with start_poll_synchronize_srcu() instead and
have nvme_requeue_work() wait for it only if it has not completed yet.
Take the cookie under head->lock, so that concurrent callers store
their cookies in order and the requeue work never sees an older one.
The grace periods of all namespaces then run in parallel, and requeue
work kicked for other reasons finds the cookie completed and does not
wait.

Flipping an ANA group from inaccessible to optimized ten times over
nvme-tcp loopback, nvme_read_ana_log() takes (median, min-max in
parentheses):

  namespaces  before (ms)          after (ms)        change
         256  51.9 (42.5-85.4)     8.9 (2.6-12.0)      -83%
        1024  157.5 (133.5-179.6)  49.5 (32.8-67.1)    -69%

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/nvme/host/multipath.c | 15 ++++++++++++++-
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a92a05b1f925a..9c1023102902c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -712,6 +712,11 @@ static void nvme_requeue_work(struct work_struct *work)
 		container_of(work, struct nvme_ns_head, requeue_work);
 	struct bio *bio, *next;
 
+	/* Let bios that found no usable path reach the requeue list first. */
+	if (!poll_state_synchronize_srcu(&head->srcu,
+					 READ_ONCE(head->requeue_srcu_cookie)))
+		synchronize_srcu(&head->srcu);
+
 	spin_lock_irq(&head->requeue_lock);
 	next = bio_list_get(&head->requeue_list);
 	spin_unlock_irq(&head->requeue_lock);
@@ -767,6 +772,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	mutex_init(&head->lock);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+	head->requeue_srcu_cookie = get_completed_synchronize_srcu();
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 
@@ -849,9 +855,16 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
+	/*
+	 * Have nvme_requeue_work() wait for the grace period instead of
+	 * blocking here, so that namespaces going live together, e.g. on
+	 * an ANA change, do not wait for one grace period each. Start it
+	 * under head->lock so that the newest cookie is stored last.
+	 */
+	WRITE_ONCE(head->requeue_srcu_cookie,
+		   start_poll_synchronize_srcu(&head->srcu));
 	mutex_unlock(&head->lock);
 
-	synchronize_srcu(&head->srcu);
 	nvme_mpath_revalidate_zones(head);
 	kblockd_schedule_work(&head->requeue_work);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8833a463f1c84..3fff9b394b1cd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -587,6 +587,7 @@ struct nvme_ns_head {
 		__guarded_by(&requeue_lock);
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	unsigned long		requeue_srcu_cookie;
 	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;

-- 
2.43.0


