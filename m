Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EBECFB445
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=va3o9/RNYQiqqOCTtAm1+RH04qEUMFPEFsfdLbuIthg=; b=D0CbMBs/6utyq/0zX/zp+saZp5
	hoLlHLka0XDbNr1TLj0z3mkDH8eCXiIb91CN9EtwDxFtlVvBGjEa/T1v7aLRuTLohSIiIZaErBYbv
	iqfVdCvaYQm07L1nXEZ6Gu2dphoX0eefU48R7aJ6nBfuvTJVe1ilAgq8eLpbyl8XLE8rYoz/XkVcV
	FtvMDOIU6aRBuIm7SVZhiq15zXq9+J44yDmPvBcR9c/bgTG6AmhEZQS+jDFEyKHh5WKCaDzJ8qR1v
	DvEeTF32/YZUnLn3MxLE/+Lw5ynQmPf5hAcehyNQA6MDIw85KfC5HbZrdVjvUBxK6nQlcj7zr9CjM
	ll5i8pYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkZC-00000001zFw-2Jxh;
	Mon, 07 Oct 2024 10:02:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkYq-00000001zAW-0PMA
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 10:01:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 376B65C5B9E;
	Mon,  7 Oct 2024 10:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F92C4CECC;
	Mon,  7 Oct 2024 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728295311;
	bh=IqBG2GeVOcJel/9MzDiqgUTJ8bsFY7q5rhrUMkLJpEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hedpoa3lScfla0kaX++Sg83N2+qp6H5Y2iNl5OWp9390VKEFA6xw8yyg6ZiDWid2/
	 Bq/ykQ8c499ruGT+hX+UfD16AKqTtAqYpX4Wu3w5cAlNykgqbqko58dBPe/vcdMS0D
	 7M0wl4N3Z09h+CmFJMlcjE1j1pQT0jHPDa9sPNQV22liM2d06T7vcqns6nht/Lbn0/
	 A2fT1esFJQJdR6urSw56nBelbCJDFXSc9065w22JKi+rmXGdCaOqWABlqqIDNyp23C
	 EUyI8FmZTDoNcZ3NPJqn8gwbA6iUSwB2lukNHr+qGROIYjVrOUBavcHrsWIGixNrHb
	 KO8WaXsDdGsPQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvme-multipath: skip failed paths during partition scan
Date: Mon,  7 Oct 2024 12:01:34 +0200
Message-Id: <20241007100134.21104-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241007100134.21104-1-hare@kernel.org>
References: <20241007100134.21104-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_030152_250381_F15136E4 
X-CRM114-Status: GOOD (  16.56  )
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

From: Hannes Reinecke <hare@suse.de>

When an I/O error is encountered during scanning (ie when the
scan_lock is held) we should avoid using this path until scanning
is finished to avoid deadlocks with device_add_disk().
So set a new flag NVME_NS_SCAN_FAILED if a failover happened during
scanning, and skip this path in nvme_available_paths().
Then we can check if that bit is set after device_add_disk() returned,
and remove the disk again if no available paths are found.
That allows the device to be recreated via the 'rescan' sysfs attribute
once no I/O errors occur anymore.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 26 ++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f03ef983a75f..4113d38606a4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -102,6 +102,13 @@ void nvme_failover_req(struct request *req)
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
 
+	/*
+	 * Do not use this path during scanning
+	 * to avoid deadlocks in device_add_disk()
+	 */
+	if (mutex_is_locked(&ns->ctrl->scan_lock))
+		set_bit(NVME_NS_SCAN_FAILED, &ns->flags);
+
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	for (bio = req->bio; bio; bio = bio->bi_next) {
 		bio_set_dev(bio, ns->head->disk->part0);
@@ -434,6 +441,10 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
 			continue;
+		if (test_bit(NVME_NS_SCAN_FAILED, &ns->flags) &&
+		    mutex_is_locked(&ns->ctrl->scan_lock))
+			continue;
+
 		switch (nvme_ctrl_state(ns->ctrl)) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
@@ -659,6 +670,20 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
+		/*
+		 * If there is no available path and NVME_NS_SCAN_FAILED is
+		 * set an error occurred during partition scan triggered
+		 * by device_add_disk(), and the disk is most certainly
+		 * not live.
+		 */
+		if (!nvme_available_path(head) &&
+		    test_and_clear_bit(NVME_NS_SCAN_FAILED, &ns->flags)) {
+			dev_dbg(ns->ctrl->device, "delete gendisk for nsid %d\n",
+				head->ns_id);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
+			del_gendisk(head->disk);
+			return;
+		}
 		nvme_add_ns_head_cdev(head);
 	}
 
@@ -732,6 +757,7 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	ns->ana_grpid = le32_to_cpu(desc->grpid);
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
+	clear_bit(NVME_NS_SCAN_FAILED, &ns->flags);
 	/*
 	 * nvme_mpath_set_live() will trigger I/O to the multipath path device
 	 * and in turn to this path device.  However we cannot accept this I/O
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 50515ad0f9d6..a4f99873ecb7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -527,6 +527,7 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
+#define NVME_NS_SCAN_FAILED	5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.35.3


