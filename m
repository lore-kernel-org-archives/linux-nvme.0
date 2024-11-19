Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E05D44148
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QEFSXa9pfZuyC335Q9FZkYypCzaBxC18nhKs2Bn5gTU=; b=eDuLC3pDPV73CXdAyliV751NEz
	Ql4zy2eOndR11r/Hn9FZEKUZE0xijrWJb96eTx/SHrqHeVREo75FCdxw2NxUKQdv9ND6J32fo4eKB
	+WVjC+NhnQ5VBmeXcLAd6MsY6SkYj/1K6J+YopdBk+ZkPkV1INaYU0hv3PFmQQffH0+CXjhqjIpDV
	rm4WYWe7gvwvanOVf20f+7yzBfsrXf9mjC+nb7v3RgP7VTkOIA8ExixXw2Ou5Xsm/NwK0xZJ/1ewG
	lAO8PSSNKl/ousxEcGZBTJnKIChluETm1ijGY0JkRIwNZm99NfrExeuqprgX61Sfxo0Fh6YBBZ4FB
	8lHUXcUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAH-0000000CJDL-3r2x;
	Tue, 19 Nov 2024 12:17:05 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAG-0000000CJAq-3xFC;
	Tue, 19 Nov 2024 12:17:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 10/15] nvme: store the endurance group id in struct nvme_ns_head
Date: Tue, 19 Nov 2024 13:16:24 +0100
Message-ID: <20241119121632.1225556-11-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119121632.1225556-1-hch@lst.de>
References: <20241119121632.1225556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The FDP code needs this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ++++
 drivers/nvme/host/nvme.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a8d32a4a5c3..d194b36b08ac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -38,6 +38,7 @@ struct nvme_ns_info {
 	u32 nsid;
 	__le32 anagrpid;
 	u8 pi_offset;
+	u16 endgid;
 	bool is_shared;
 	bool is_readonly;
 	bool is_ready;
@@ -1600,6 +1601,7 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	}
 
 	info->anagrpid = id->anagrpid;
+	info->endgid = le16_to_cpu(id->endgid);
 	info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 	info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 	info->is_ready = true;
@@ -1638,6 +1640,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
 	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
 	if (!ret) {
 		info->anagrpid = id->anagrpid;
+		info->endgid = le16_to_cpu(id->endgid);
 		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
@@ -3644,6 +3647,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ids = info->ids;
 	head->shared = info->is_shared;
 	head->rotational = info->is_rotational;
+	head->endgid = info->endgid;
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 900719c4c70c..9b916a904f00 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -491,6 +491,8 @@ struct nvme_ns_head {
 	struct device		cdev_device;
 
 	struct gendisk		*disk;
+
+	u16			endgid;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
-- 
2.45.2


