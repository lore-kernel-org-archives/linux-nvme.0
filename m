Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEC3C43219
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+0iu+A0Po72NG6PsBiW6InjA/PL4RlYWhhZ8s6hwjKQ=; b=rMPK7lkghQRGZqp2NfzZogm/9C
	kbyQ1ngA+wzh+1OyobCKVlrM4ji6btEzk3A1714lxNB+oasKrDU92gq9VgQLXeBm5pptbr5W1xrdn
	SgtR+6Q7BFFxc8CqOzzzLvPX6QDrilUy2qqEByfLshvqZ1tb0haQIlhi2F+6rTXzeTzqQJwYkol8c
	aPa2NwvkVJ9fNe32zA/l0O/kGaxzmdtqODdNvxsCjv9LJtu9ShHdBKJFQet97NhSRvcQLAsBT0Dkx
	xJ31THtWDL9a072FnO8pMQdcGPxd/Kz5+alSbZxq1fd7DQoZW//9TDZ6pOcpvfW92fxt0AFIOBxcE
	BmzfCw0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslb-005gt4-S1; Tue, 01 Nov 2022 15:01:27 +0000
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslL-005gj1-0g; Tue, 01 Nov 2022 15:01:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 05/14] nvme: remove the NVME_NS_DEAD check in nvme_validate_ns
Date: Tue,  1 Nov 2022 16:00:41 +0100
Message-Id: <20221101150050.3510-6-hch@lst.de>
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

At the point where namespaces are marked dead, the controller is in a
non-live state and we won't get pass the identify commands.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 390f2a2db3238..871a8ab7ec199 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4333,10 +4333,6 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
-	if (test_bit(NVME_NS_DEAD, &ns->flags))
-		goto out;
-
-	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
-- 
2.30.2


