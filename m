Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D214C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VftSGhpevZu6/5y82Vykr3F9H9L8vKbEyML7+10xdA4=; b=0OQK5g2hazn3j1OaMUeB+afrVr
	GWj7s9zXVln4OUTRFbhyFsAYPW+qFvEgyyXolNAN0+xTgNdKXrm7fFB+WMeVoYwwfhAUVsDMlq7aA
	U8ygYkB3yN3TMgX9V9kPvRWLnR5WWNWpgra3q/bCjdas+Z0MwiKsNJoPIMQ9WdfK//IXeFdmxJe/l
	21jhfcgxfEYcjH4TUBQnU5QtB0C5aNS0pjoYJZGvR88qOATt7LNJVQvEE+dv2nlUBu7MCSqvK42LD
	izlbSwMB+/5bRM/vTpJm+pMZnPCBzkJK6YQgTNZdUjed9SbYxu9G74mPEXpZQ2/ZLNp5q+DZQmpu7
	B/76DaJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslW-005gpK-9H; Tue, 01 Nov 2022 15:01:22 +0000
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslI-005giM-8a; Tue, 01 Nov 2022 15:01:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 04/14] nvme: remove the NVME_NS_DEAD check in nvme_remove_invalid_namespaces
Date: Tue,  1 Nov 2022 16:00:40 +0100
Message-Id: <20221101150050.3510-5-hch@lst.de>
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

The NVME_NS_DEAD check only made sense when we revalidated namespaces
in nvme_passthrough_end for commands that affected the namespace inventory.
These days NVME_NS_DEAD is only set during reset or when tearing down
namespaces, and we always remove all namespaces right after that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 35386aa24f589..390f2a2db3238 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4407,7 +4407,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
+		if (ns->head->ns_id > nsid)
 			list_move_tail(&ns->list, &rm_list);
 	}
 	up_write(&ctrl->namespaces_rwsem);
-- 
2.30.2


