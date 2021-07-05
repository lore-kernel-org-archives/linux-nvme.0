Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E8AC07E9E
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:29:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12E0619B1
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12E0619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xAYoKYJGRQ31g3VTJZhIFNm7KcgRxghK2/wROViO8jI=; b=d5Opl54JlpKFDe
	gZhLCpAtC5M2IcyCzhmLfZSy1TWuyGVihqwyzI70rqvPQdXUyvCg4SqSo3SdPcvZ6VsTKj8kzRDhY
	FXT22YqrywsckzxvwRIJ9nGdggxu23gwzvBUUHpJOAaWPNa1WSWA7cd8BZs9qlYGqzP5bBmMCdoSf
	+C1ThphvRTKtNK4PReyvZnTW/udg7NepNUEFgnhHCLq+ove0te1dVej83vFP15iNB14UMUKDfCN9N
	ccsdmiOwSkfCqRAd8CysYNyPSu7gpLaRHgtECtfCZBW6ctPn9LqlPUGKq89srJnd0nDdcJms4wpoB
	aySNux2lp7Qm3ECGNd4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QXh-009LNK-WE; Mon, 05 Jul 2021 15:29:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QXf-009LLo-0e
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:29:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C634619A5;
 Mon,  5 Jul 2021 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625498990;
 bh=mmdAldEcnqi6sXxjo3oondyAT2E/9YNScMhIXaq+oTo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PYyrBa5LvpJv+6uyngO0S9I05mZCE1MBO85Jt2E0y7Urzz81Qa3qiYfY0HHNqVSHg
 tMFcAa5fREkpLa89qFRbqE/KJS0tE0fg+R1fcEpjXW2zjy/YEzqM5WbNlba8xvcRwh
 7pMgNJdl8Xm6OsjA7wCb8wylNg/9qqNg6I3UIMUCrXrFE5GzQJoMklLpbO5dr6alx4
 XHzBbKXuBfS9giKajTZxBzY8NAk7mwoeAlEEDkmeUtibSvtHXqOZhiWizmES3ALjPA
 v7TMSnqSzkP85ll6fdwxna/B+sPyCg8zAK8GhsUjIldsAqGiQeVS6LfT5zD/RzgVsA
 N2aI5MG11nyWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: JK Kim <jongkang.kim2@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.12 30/52] nvme-pci: fix var. type for increasing
 cq_head
Date: Mon,  5 Jul 2021 11:28:51 -0400
Message-Id: <20210705152913.1521036-30-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705152913.1521036-1-sashal@kernel.org>
References: <20210705152913.1521036-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_082951_116933_222DB5CF 
X-CRM114-Status: GOOD (  13.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: JK Kim <jongkang.kim2@gmail.com>

[ Upstream commit a0aac973a26d1ac814b9e131e209eb39472a67ce ]

nvmeq->cq_head is compared with nvmeq->q_depth and changed the value
and cq_phase for handling the next cq db.

but, nvmeq->q_depth's type is u32 and max. value is 0x10000 when
CQP.MSQE is 0xffff and io_queue_depth is 0x10000.

current temp. variable for comparing with nvmeq->q_depth is overflowed
when previous nvmeq->cq_head is 0xffff.

in this case, nvmeq->cq_phase is not updated.
so, fix data type for temp. variable to u32.

Signed-off-by: JK Kim <jongkang.kim2@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c92a15c3fbc5..4555e9202851 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1027,7 +1027,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	u16 tmp = nvmeq->cq_head + 1;
+	u32 tmp = nvmeq->cq_head + 1;
 
 	if (tmp == nvmeq->q_depth) {
 		nvmeq->cq_head = 0;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
