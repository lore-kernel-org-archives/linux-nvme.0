Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8ABC282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VBjqjqJab5emzTs9NSZNZKtp8c9gcNCRG1QlezTt2DE=; b=k/PeGCzNtN5v8T+8cEUyafr9ak
	jhu5uc0XcX6XEPmyEh/hZgbKpyEUShe/zYAmnObgKfutXDiwppY3XSnMgLno3P0hjF5F+LsS4zjNw
	SG8xRusxyVVMqv3WCwQPOhpHs1sCkR4zQSRQiDG9A4if73qK5igLwjWrU2Nv2jo77bttU45p3EB9I
	fsV0CYIioJod73cX5CHF7jT37sfMAcNVgrfPPJdl+iMSBT9OdCH5F2/MDa1RYnzbVZA9P4Hnhe5f3
	+6E5y9Kn3dNqdQiHh57i8BBRSCWtcODNBtsLMTwWuPFNBGoHwFnnep+GeiP0d7iMpsd/C26sAVzHV
	pAIrMCPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq8CK-0000000Aac4-3uaa;
	Thu, 06 Mar 2025 10:11:24 +0000
Received: from guitar.tkos.co.il ([84.110.109.230] helo=mail.tkos.co.il)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq6zU-0000000AP1D-22zo
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 08:54:06 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id A5B8D440EB9;
	Thu,  6 Mar 2025 10:48:08 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1741250888;
	bh=OyOGoZFFwcH//aAHC5W5+DNk+fdN3uFH9fnWmd5TFNs=;
	h=From:To:Cc:Subject:Date:From;
	b=j9KKazqnbMyTgseL335zCKgXdRwVQPfnCcRIn4jL9sttEuKL9ObU+CHy9SBuUH469
	 Z1lzuWcWcrY7dotDz3x1DToeqq3D9i7nJFhGQBcSwOKdGD241UsCVrPAu3QGNYDdyi
	 tscNR4s78PwY7pOwzh1rWL8hXLtrSlGl0K8rzSWZuKz6iVvry5k/ixuH4pVxNwt5Fg
	 KKIafd4sPYdGlmr414Q2yoYmvvJttTbBMkkh4hpT5UmLvGXaBXleBFUUc2VSpr8WMA
	 06IYV9KerBWxToXAq/w24dX9ZlhNI4863kLGMeZXLnbUzz8RQO/+ATD1oBe1K9gGIO
	 xmrGakfGIcbsg==
From: Baruch Siach <baruch@tkos.co.il>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] nvme-pci: remove stale comment
Date: Thu,  6 Mar 2025 10:53:31 +0200
Message-ID: <624210159350e1c8137b5e55cb29ae509ac21d47.1741251211.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_005405_041678_8086455D 
X-CRM114-Status: GOOD (  10.02  )
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

The ns variable has been removed in commit 62451a2b2e7e ("nvme: separate
command prep and issue"). Drop reference to ns in comment.

Fixes: 62451a2b2e7e ("nvme: separate command prep and issue")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 950289405ef2..caf5447f1af4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -953,9 +953,6 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	return ret;
 }
 
-/*
- * NOTE: ns is NULL when called on the admin queue.
- */
 static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
-- 
2.47.2


