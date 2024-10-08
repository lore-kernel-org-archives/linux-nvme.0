Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6886ACEF178
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QgvessTr1JdgnGCQP4nokk71icaIIxiSfyBemSaKtmU=; b=xiaGZqRx5OSv16t3OqFO3/yiYJ
	ZN99bK+V29IgmqN2fMi4k4GBMT83aeHGvg/5KK2l+9z0L+3XtH9oMe6BEwXC6mnA6JN/bh2ZvUvg5
	aLwBNeKctCOZ2l7jGF4+YkLqiiAbxriB4zTlgva4jVt689yhTOVYmXE2vcZl+lMJC4B7R2VgYrF5+
	ynROhQI2XtAv9p6jY7pGjGkifbuOsbT/XNQz81JBiDkrowXkk0Xv0OkE4H5gkxU7wZVdeIeO6AZe7
	NnEoy+JBXZiDirLPQ4wN74uXgbi4NGiSP+AIs7hWFevnQIpdNpCuQRlQc+Ql9v/qWJEFXzvCRKp8u
	39eRxDvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syAig-000000065KW-3Y6J;
	Tue, 08 Oct 2024 13:57:46 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syAic-000000065Iq-31Ih
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 13:57:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6B5F3A41B4D;
	Tue,  8 Oct 2024 13:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC84C4CEC7;
	Tue,  8 Oct 2024 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395861;
	bh=rU06CmZc8kWgL/rwAKgkWTOJSVmsE2uxfu/RPyO6TqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRhVckrlNDEcgLZZoAl+YSHqCVGurwou2D4peWb8jr+CknQf2iOf1yPgIDWRPsrsG
	 exn6+RnhgdQwjJHWJV85oI+IKP0GuZ2SBM5xD+sxapjIgmFjB7aQ0YQVlg2TBR1IBN
	 dvPpYFT75TScKWaxrdY/sI2rxmVdo/akb/SqXnfnxeZvJ+5udAUwNkuaw87vv8S/Lb
	 2nETN3eXQbN6p+7YDT+QHfnIWCscDbBDEZt8wHcunWU2ajA5zjEYHx3XI+RfCIRTSG
	 3CElAWMExVD9O3wBaI9ocdPLaKQQ7NzSkhojtS1UvBLXeKlHJVx0/BuIXAW2fEiZHu
	 usKvfy9XU1a+g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvme-multipath: retry partition scan on errors
Date: Tue,  8 Oct 2024 15:57:29 +0200
Message-Id: <20241008135729.68810-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241008135729.68810-1-hare@kernel.org>
References: <20241008135729.68810-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_065742_852521_3B2C8783 
X-CRM114-Status: GOOD (  11.63  )
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

When we hit I/O errors during partition scan we can assume that
partition scanning was incomplete. Rather than continue to work
with an incomplete device we should disable the disk completely,
and wait for a rescan to retry again.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 68eb1df98419..f70952c6d683 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -243,6 +243,21 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 	kblockd_schedule_work(&head->requeue_work);
 }
 
+static bool nvme_scan_errors(struct nvme_ns_head *head)
+{
+	int srcu_idx, valid = 0;
+	struct nvme_ns *ns;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (!test_bit(NVME_NS_SCAN_FAILED, &ns->flags))
+			valid++;
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+
+	return !valid;
+}
+
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
@@ -670,6 +685,11 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
+		if (nvme_scan_errors(head)) {
+			del_gendisk(head->disk);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
+			return;
+		}
 		nvme_add_ns_head_cdev(head);
 	}
 
-- 
2.35.3


