Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63B3C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rm/IRbGeMyvZjy9/i6jToMGsSHuJMehfKODHL4Mhra0=; b=Ni5800NwvTFy2sKyIn/tfe39dM
	GqTueAjngkY9GkC9QOKnhnDOD0L+R9B8DVr0J+voyOJGh8WH8etRbD46bRQSW7Ir3vt2aMj9eWUwZ
	T8uCuaYbXa1iJNd/gZOMJJo99NiUDr2u1xNFCoy2LzYYG3dme6EG9btcbO7BGuZ8d1f4lxp2t2oUk
	98Gp18WvxH/Iyb1LWoa3qICa4cHvpGZafsU2Sh51+OM9hjs1FvLumTS0M44LUJVscEgExRnBIjYB8
	j+pFemi5/YPfhdNhUN3ZjVWkjE7f3gqsyBFmQekVGwiVie4GbpVlDiH0m3zxe0cSfxyFQE7TjdvbH
	FbNAaXZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslx-005hCY-Hr; Tue, 01 Nov 2022 15:01:49 +0000
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslW-005gov-Tt; Tue, 01 Nov 2022 15:01:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 09/14] nvme-apple: don't unquiesce the I/O queues in apple_nvme_reset_work
Date: Tue,  1 Nov 2022 16:00:45 +0100
Message-Id: <20221101150050.3510-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
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

apple_nvme_reset_work schedules apple_nvme_remove, to be called, which
will call apple_nvme_disable and unquiesce the I/O queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/apple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 6c09703ffe922..24e224c279a41 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1154,7 +1154,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	nvme_get_ctrl(&anv->ctrl);
 	apple_nvme_disable(anv, false);
 	nvme_mark_namespaces_dead(&anv->ctrl);
-	nvme_start_queues(&anv->ctrl);
 	if (!queue_work(nvme_wq, &anv->remove_work))
 		nvme_put_ctrl(&anv->ctrl);
 }
-- 
2.30.2


