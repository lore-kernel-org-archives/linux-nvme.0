Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5BFC197A0
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6EBtntZeYnfF6Xjvptxtvu9EkClDBRcxSv2SAxCWBEI=; b=zcrK8eUNSuZIb+zyB+UfwfApb0
	of4wZW/Jpx7FuaXSukvkxd8khRMaJ1dkssnaJm2RZqlDNjibm5jNnHjL785nD9nbiHzOZzb0MQJA+
	kZ6Q/QiTI4+zKxdFvAt5MHmlHIT0N4W7FQHzv6lX7iA6HCZ0ECvOZEEGpG3X4iILVcCYhaqYpEX0K
	tq1e//ZeF1YTUp3Vs7N6QTjEG2PEwzNMjYFs6dpdiDaEIronbLPQ/5mLm6cz8rBcR7wRKF1VNdJCy
	ycNlkUn8qxSZblJpSQbo9+ul515Km+9XXbfNJVlSxdGxFECkqfif6UUt5vnhvDOwg0FssFRVD0Lhp
	WYxZAT2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3yfC-006crR-0d;
	Fri, 17 Nov 2023 13:13:38 +0000
Received: from [168.215.143.67] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r3yfB-006crB-0F;
	Fri, 17 Nov 2023 13:13:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Cc: zahavi.alon@gmail.com,
	csander@purestorage.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet: nul-terminate the NQNs passed in the connect command
Date: Fri, 17 Nov 2023 08:13:36 -0500
Message-Id: <20231117131336.126505-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

The host and subsystem NQNs are passed in the connect command payload and
interpreted as nul-terminated strings.  Ensure they actually are
nul-terminated before using them.

Fixes: a07b4970f464 "nvmet: add a generic NVMe target")
Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fabrics-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 43b5bd8bb6a52d..d8da840a1c0ed1 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -244,6 +244,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
+	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status)
@@ -313,6 +315,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
+	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
 				   le16_to_cpu(d->cntlid), req);
 	if (!ctrl) {
-- 
2.39.2


