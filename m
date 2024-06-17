Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6715C27C79
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bSDiom7F3viIRo3u9qUH+Xz0REas9CcBq5WrqCByteY=; b=sS+h25KD+JlVukIzlyMQ9b9ObW
	52a+TQW6gKdsEJ7btAHaji7YVMRncl+b4K0ypvEIIJqF9cRl7C8bP/o0+Huy0Sfcru/I5UXLM3KYw
	X2vpQEK/JVWP1TcgLFssdhfVIa+28cK/V2lu62Qt/IUQXnl/vC++T96/7xSmMi5euCKsCu8cLPjxT
	fnctmyzeq/4gtZsWw/ecoIfuL7EnWSGZmWRpC2Rk6GKhjX/SMF3N2THeyEjI2OFexn4XCXmwVjdhh
	EHHEnT2EfZNHkENMH6aA5EAIkGVag3YYUMFAZI5QLRoX3CGtPNorrksdvZsUFwhnAUkdaN9yjhUcA
	nXu4sxwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJCAc-0000000AmLR-08sw;
	Mon, 17 Jun 2024 13:13:14 +0000
Received: from smtpbgbr2.qq.com ([54.207.22.56])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJCAW-0000000AmJ6-3umi
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 13:13:12 +0000
X-QQ-mid: bizesmtpsz9t1718629912t5494vo
X-QQ-Originating-IP: ofoZGaY66B9E0Bp1eAiohtnrFFlyHG0pri1WEVYLtFM=
Received: from localhost.localdomain ( [14.154.190.47])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Jun 2024 21:11:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 103092901695252679
From: Boyang Yu <yuboyang@dapustor.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Boyang Yu <yuboyang@dapustor.com>
Subject: [PATCH] nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LBA.
Date: Mon, 17 Jun 2024 21:11:44 +0800
Message-Id: <20240617131144.48955-1-yuboyang@dapustor.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:dapustor.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_061310_569505_D02A05E8 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

The value of NVME_NS_DEAC is 3,
which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS.

Signed-off-by: Boyang Yu <yuboyang@dapustor.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3a41133ac3f..68b400f9c42d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -502,7 +502,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
+	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeores supported */
 };
 
 struct nvme_ns {
-- 
2.27.0


