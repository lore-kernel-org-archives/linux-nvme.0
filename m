Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5203C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJrC9Z1su72NTwcvA05C7M7FGqz+ToKQ00M4AArA2YM=; b=AUxB9LvO2kt7IrCx4tKoXOC59F
	jdfaQN7qqDe22WOP2bMLIvZ/y5dMZHBvUqrascweUIK8+iHIX4rt9lWyTj6Za2k/VU72Mkk89MwP2
	kvgE5J7yMtpc2A6fgIBLKZVOchXkYD9Njah+aeiCfsIYi/sKXRz+qj9AfkIMI7+Lcx0rHqKiQ8/Wo
	RH3Itfotc5Jh0JOPyLCZxC3nD/9Zr0AxpDfer1S4kBDe8+mheBLMMzn50aUENtBbCmGQ+h+q7wNmG
	OdQ5oV5QWnHImGQoS+HF68i0EtC9Qbg1G+qVqhcUOu/zlI8xN85IZ8WYILbc1qWA1vxDUVuc6a18r
	UC/QC5Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgRq-00000004JEo-2Awe;
	Tue, 28 Jan 2025 07:55:50 +0000
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgRo-00000004JDN-2UxR;
	Tue, 28 Jan 2025 07:55:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: add a missing endianess conversion in nvmet_execute_admin_connect
Date: Tue, 28 Jan 2025 08:55:34 +0100
Message-ID: <20250128075539.693870-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250128075539.693870-1-hch@lst.de>
References: <20250128075539.693870-1-hch@lst.de>
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

The kato field is little endian on the wire, but native endian in
the in-core structure, add the missing byte swap.

Fixes: 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and implementation")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fabrics-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index a7ff05b3be29..eb406c90c167 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -287,7 +287,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	args.subsysnqn = d->subsysnqn;
 	args.hostnqn = d->hostnqn;
 	args.hostid = &d->hostid;
-	args.kato = c->kato;
+	args.kato = le32_to_cpu(c->kato);
 
 	ctrl = nvmet_alloc_ctrl(&args);
 	if (!ctrl)
-- 
2.45.2


