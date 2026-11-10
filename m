Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F815606E454
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PgL4ejuN;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a9eYITwN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=AIbTsoYJnqU+UBgdfpuuXZyRGQURHVhq0edfk1ZSOcQ=; b=PgL4ejuNyOSk6NCEUheo32+DCf
	cNZ5zJy/caKMQmrljRaS9RkVBIwMYD2f4pFOODOYz5Ydp/99Ra5uR0BDfWdRpGxpBtZ5c3ctQdhJt
	EsxW+dA4g3RvYoel1gx/qU+YImdlrgAKAcC13EtRH+P7bzNMtlbliU75ozh6xh2hl34KXBP38wzd2
	f6HbRql4Yff4TYL/mMi1vQ70FcOhLptH2rg0e7pb7/lPoc2gQLNg38TvVocfUPnIZDUZrXjUT9PwR
	VtxcjNGIoLBanrHs9byDPq8rlYrSxsix/Hjgm2JpPnM6Ld8ZqTTGUyDZxjozbMdvpTtwCw89gBu9C
	F8pHQgtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlcI-00000003yxZ-3iQT;
	Tue, 10 Nov 2026 13:10:26 +0000
Received: from out-145.mta0.migadu.com ([2001:41d0:1004:224b::91] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlcF-00000003yuy-0opX
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 13:10:24 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=952T0Zyn92ruet41jp8SPLUgK+azry6ZsW9QMfdNX5k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794316212; v=1; x=1794921012;
 b=a9eYITwNp67wmoza8iBvS+dlCvAt7r3ffRcYF0pLLIxzb+fLHR6hlzIVZxRNuFN0rw35Wvm1
 aJaAs3iYOQ0AJgAK5XzAugOyJIqlH6bUx12W6XERo+8+76igOdA4QwHBFZrUJSKzzPTfLQc0rHF
 ZEpwthlD7tyn7WyAwp+ZAQNM=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 700c77a0a9d00a5e;
	Tue, 10 Nov 2026 13:10:12 +0000
X-Mizu-Trace-ID: 700c77a0a9d00a5e
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Tue, 10 Nov 2026 08:10:06 -0500
Subject: [PATCH] nvme-multipath: don't wait for a grace period in
 nvme_mpath_set_live()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-bug-nvme-mpath-set-live-srcu-v1-1-1f58b405b0f8@linux.dev>
X-B4-Tracking: v=1; b=H4sIAK0X82oC/x3MzQpAQBAA4FfRnE0Z+X8VObAGUyztsCl5d5vjd
 /keUHbCCk30gGMvKrsNoDgCs/R2ZpQxGNIkLYgoweGa0fqNcTv6c0HlE1fxjOrMhWYYq7rIJ8r
 yEkJxOJ7k/vu2e98P3WmhJm4AAAA=
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_051023_515201_36CC323C 
X-CRM114-Status: GOOD (  14.49  )
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
The grace periods of all namespaces then run in parallel, and requeue
work kicked for other reasons finds the cookie completed and does not
wait.

Flipping an ANA group from inaccessible to optimized ten times over
nvme-tcp loopback, nvme_read_ana_log() takes (median, min-max in
parentheses):

  namespaces  before (ms)    after (ms)   change
         256   51 (32-72)     7 (2.5-12)    -86%
        1024  157 (133-203)  41 (24-65)     -74%

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/nvme/host/multipath.c | 14 +++++++++++++-
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ae8059366b57d..4bc94f165c17d 100644
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
 
@@ -851,7 +857,13 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	}
 	mutex_unlock(&head->lock);
 
-	synchronize_srcu(&head->srcu);
+	/*
+	 * Have nvme_requeue_work() wait for the grace period instead of
+	 * blocking here, so that namespaces going live together, e.g. on
+	 * an ANA change, do not wait for one grace period each.
+	 */
+	WRITE_ONCE(head->requeue_srcu_cookie,
+		   start_poll_synchronize_srcu(&head->srcu));
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

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-bug-nvme-mpath-set-live-srcu-cbd8965f1457

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>


