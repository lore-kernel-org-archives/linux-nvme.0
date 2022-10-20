Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095BEC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFs0HE9gO0EtsI+1aqU/2h60fWe7lmlrgndFaOvNRj8=; b=TM25k4grPbG8pJ+tOUeNPKIEVJ
	jMAC+Iy9GqVhVXKqnXLHoVXeN/5uChVicIXrisFuoeRa3hy7gjC3w4z2sU41Y09C9xr3h4sN1pWI6
	UrFeXB+8p21dXgDE0KGJS9b2QvKhahdasGWWikaeifx0lW99cvp2AKgXoj+oJ2dc5WHK3XdNUpeLP
	+in2iJwJ9jgJR6J1ZXs0DXLAkrorTtsXPZQahP5pAP8bmOQOVZHGZKgaJaOeIFV5KuMASFdzyffay
	hkIGMnF47XoPVt4TBRQ2wkeX+xIujtDXU2YKADqzpXBmpedm16Ld9mTdcZXNSsSzJ892uxvfQKvP5
	4VniYU7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olUEz-00EQV2-Ox; Thu, 20 Oct 2022 12:01:37 +0000
Received: from [88.128.92.117] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olTE4-00DqmB-IQ; Thu, 20 Oct 2022 10:56:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Date: Thu, 20 Oct 2022 12:56:06 +0200
Message-Id: <20221020105608.1581940-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
References: <20221020105608.1581940-1-hch@lst.de>
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

The NVME_NS_DEAD flag is only set in nvme_set_queue_dying, which is
called in a loop over all namespaces in nvme_kill_queues.  Switch it
to a controller flag checked and set outside said loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 16 +++++++---------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a74212a4f1a5f..fa7fdb744979c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4330,7 +4330,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
-	if (test_bit(NVME_NS_DEAD, &ns->flags))
+	if (test_bit(NVME_CTRL_NS_DEAD, &ns->ctrl->flags))
 		goto out;
 
 	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
@@ -4404,7 +4404,8 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
+		if (ns->head->ns_id > nsid ||
+		    test_bit(NVME_CTRL_NS_DEAD, &ns->ctrl->flags))
 			list_move_tail(&ns->list, &rm_list);
 	}
 	up_write(&ctrl->namespaces_rwsem);
@@ -5110,9 +5111,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
  */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
-	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
-		return;
-
 	blk_mark_disk_dead(ns->disk);
 	nvme_start_ns_queue(ns);
 }
@@ -5129,14 +5127,14 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		nvme_start_admin_queue(ctrl);
 
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		nvme_set_queue_dying(ns);
-
+	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
+		list_for_each_entry(ns, &ctrl->namespaces, list)
+			nvme_set_queue_dying(ns);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee65..82989a3322130 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -237,6 +237,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FAILFAST_EXPIRED	= 0,
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
 	NVME_CTRL_STARTED_ONCE		= 2,
+	NVME_CTRL_NS_DEAD     		= 3,
 };
 
 struct nvme_ctrl {
@@ -483,7 +484,6 @@ struct nvme_ns {
 	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
-#define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
-- 
2.30.2


