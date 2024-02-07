Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559ABC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orTHRye1FGp48zMAU9tFde/mGpt15jwyV52xzHcfhsc=; b=n6zBwlgu1Cs/auF6+FWotxhYNU
	uQI0mO2ASMypOm3hOYEghukLiXbXDo9lzU9GdizQ5btkba7Fkh9WPt/HhRjchyw3lj1UT4f5vyX6G
	NxTUTDhRbOz4ueZ8SQVquHHJFN5GSWAhKWExs3YdJ2P9Njo4O7eo1Fwzc663yGRguCclquuoFmc7g
	vckgRpGzW2vSw9hg3vD4YnG+0KGCPhQ7B1JijptfdqVfZRZsj1IlXoYe/9RG9Yb8oKiAsR+FlJGry
	GWUkilrYmbQLi++qWJ+HRHSjkns5kqibroXOiHvFJtetWmtvMcef5rw35afYNnst/enzR1v3n65l1
	AyQ5l0rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpNx-0000000BqfB-2aHF;
	Wed, 07 Feb 2024 21:23:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpNs-0000000BqaR-326t
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:23:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3A14861AC9;
	Wed,  7 Feb 2024 21:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60C6C43394;
	Wed,  7 Feb 2024 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340988;
	bh=B51nWLS6ql3SkLV39cOPG21h/rGbV0rMuK6QnA/bR3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmorfrL/XSrfoil/1vNq1Q8/4olDgiHztjRCWpQ6XsYSSWFhL1GvnaXNFWyZxP9I4
	 aAIxRsz6kdK3mXIGckWesiUrSDJhSukMjJucXTHxCAkRwUpQw2Kg40kIoEjVr1gCbB
	 HkxV0PlZ3Hb5IDqL9K4j7EhRMWYOlIqW0xD3LhHLHy5o2T4iiLsWVU/SONGPQJxuc5
	 kyql4hkw9/LV8vM+ynKp5nL2Pbg/7ChjLogW6SVpzyRL5psGowusW73zRhNesg8rSV
	 tlnhUKzQucBIK6X4JHe0ikn2pXao2mN+E14aczCaGH857n5D/gwNtWDCuAOBvU4SYU
	 yTrmAS8Yxrnew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 35/44] nvmet-fc: free queue and assoc directly
Date: Wed,  7 Feb 2024 16:21:02 -0500
Message-ID: <20240207212142.1399-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132308_850312_4756A741 
X-CRM114-Status: GOOD (  11.71  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit c5e27b1a779ec25779d04c3af65aebaee6bd4304 ]

Neither struct nvmet_fc_tgt_queue nor struct nvmet_fc_tgt_assoc are data
structure which are used in a RCU context. So there is no reason to
delay the free operation.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bb0791c9c0e3..5fd37e989106 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -145,7 +145,6 @@ struct nvmet_fc_tgt_queue {
 	struct list_head		avail_defer_list;
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
-	struct rcu_head			rcu;
 	/* array of fcp_iods */
 	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize);
 } __aligned(sizeof(unsigned long long));
@@ -169,7 +168,6 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_tgt_queue 	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
-	struct rcu_head			rcu;
 };
 
 
@@ -852,7 +850,7 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
 
 	destroy_workqueue(queue->work_q);
 
-	kfree_rcu(queue, rcu);
+	kfree(queue);
 }
 
 static void
@@ -1185,8 +1183,8 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	kfree_rcu(assoc, rcu);
 	nvmet_fc_tgtport_put(tgtport);
+	kfree(assoc);
 }
 
 static void
-- 
2.43.0


