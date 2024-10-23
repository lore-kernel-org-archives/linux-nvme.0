Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26075CF5396
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BMn7h5h1rPM1fy+Jq3MF5Y1NQe8P2oQSBei6uhUXCr8=; b=FHhKmgfer4UGVnNOCZDM7kmR3H
	qSzRLs2e/Bs5I0ax9PszCkcp7izzDdNnc4mlNCx677Y0NBtrQ1/gMtMdjQss8tZL7yLDnZFk3JzcF
	nzVbKPFyJSpwkybYSIk5zr3F1484tzom8dGjG63RttPuIZB9ErJHKtsvOOLS/JJhe7RDRxIyhQsSv
	C+Djn5KwJ3jiEC79fhhXQcGFHfqX/waenxPzq3gJemDdNYpA/+cs4p7rgjrlkSs9+reYLKlrkJBot
	aCNdBFZyjaYbXQ6zC4xV3Oo3rhslNe5Ys7SF94j+qZ27i3B+64lmKBWDfk7RWSwRVXeSWvM6PHie1
	pfL8gwXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cSX-0000000Ek5W-34E7;
	Wed, 23 Oct 2024 14:35:37 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cPU-0000000EiR2-3U4J
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 14:32:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 924CBA44F68;
	Wed, 23 Oct 2024 14:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A0CC4CEE4;
	Wed, 23 Oct 2024 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693947;
	bh=l8kydYeUsOiZtm3dihKoja2wxm6KX1Xk3/XsqqFT4EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rROSW2uBO7QmfGFTSC0nEj7W19EfvGUzzTep1Qo64arkWbLW5u2hqnUCNzGM6j9/o
	 IPLqEEDP7hR+JIPm9q+mJhQYB4YLkxwbalx8csKWX/OeTuDSMa8I4Otcp2nXVUDA+q
	 Gp6MZIH20MGWInFOZRauifbIWDKO8j1Y46AI3EAlYg9OLpIjncNn+nRWYoFviyUpMH
	 L64kRi9nD71f8iq0h+luUgC5Tj+5pUHYs+feequqGAPoIoIZcZOpY51+Sr5HBmBhyY
	 9jJYEiqaOFJDX8uJSFrLYiwUAw99BkGVy5t68k4TkeHt7Y4/lQW9yq/xaExLtZX3Sk
	 BTxN0pz5ImlZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 15/17] nvme-multipath: defer partition scanning
Date: Wed, 23 Oct 2024 10:31:54 -0400
Message-ID: <20241023143202.2981992-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_073229_170123_5CB88D7F 
X-CRM114-Status: GOOD (  15.92  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 1f021341eef41e77a633186e9be5223de2ce5d48 ]

We need to suppress the partition scan from occuring within the
controller's scan_work context. If a path error occurs here, the IO will
wait until a path becomes available or all paths are torn down, but that
action also occurs within scan_work, so it would deadlock. Defer the
partion scan to a different context that does not block scan_work.

Reported-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 33 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 93ada8941a4c5..43b89c7d585f0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -463,6 +463,20 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 	return ret;
 }
 
+static void nvme_partition_scan_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head =
+		container_of(work, struct nvme_ns_head, partition_scan_work);
+
+	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
+					     &head->disk->state)))
+		return;
+
+	mutex_lock(&head->disk->open_mutex);
+	bdev_disk_changed(head->disk, false);
+	mutex_unlock(&head->disk->open_mutex);
+}
+
 static void nvme_requeue_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head =
@@ -489,6 +503,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
@@ -504,6 +519,16 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		return -ENOMEM;
 	head->disk->fops = &nvme_ns_head_ops;
 	head->disk->private_data = head;
+
+	/*
+	 * We need to suppress the partition scan from occuring within the
+	 * controller's scan_work context. If a path error occurs here, the IO
+	 * will wait until a path becomes available or all paths are torn down,
+	 * but that action also occurs within scan_work, so it would deadlock.
+	 * Defer the partion scan to a different context that does not block
+	 * scan_work.
+	 */
+	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
 
@@ -552,6 +577,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
+		kblockd_schedule_work(&head->partition_scan_work);
 	}
 
 	mutex_lock(&head->lock);
@@ -851,6 +877,12 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		/*
+		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
+		 * to allow multipath to fail all I/O.
+		 */
+		synchronize_srcu(&head->srcu);
+		kblockd_schedule_work(&head->requeue_work);
 		del_gendisk(head->disk);
 	}
 }
@@ -862,6 +894,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
+	flush_work(&head->partition_scan_work);
 	put_disk(head->disk);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5f8a146b70148..0f49b779dec65 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -460,6 +460,7 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
-- 
2.43.0


