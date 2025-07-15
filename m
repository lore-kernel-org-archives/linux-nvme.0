Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA230C83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 06:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Yu9SHAbXQrdd5VAieT9a6TJ+4eyWeGwYWNhRE0NfEIw=; b=lzLuF6QUlF5shSUPM4+/SARcOq
	QWLlbXBkdOpCqi/Wl/bRXeg7fGbWob7XEbRPdrblnkBm6BGNrzPb09dCUY6AuNjTLxitXucpZaEzy
	SFHdaYGhFrAU1mQJoRlwcoob8ukBK6NulEg3Ilqp4rdhg5bMjvFbSIHL/ndaDcDeMn7ABGMxFg+4X
	PRUlsRXq9isVT5on084msn/nBGCWDlVAUXLy61W3ZQ25m9eu0GbU5EVZs26ewCFuEBrNFsGL5Sp1d
	wA26C5dSZaoj6xNRDzU+XoFVC85jCVfLh1kAnsNgdHwYijWiVQN8TgNtzMmcP0j4szdGsD9ZGMS7G
	Nr0XbjHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubZ8Y-00000004Ccv-1BS1;
	Tue, 15 Jul 2025 06:27:34 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubZ8G-00000004CZe-2A4c
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 06:27:20 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250715062711epoutp02c8f482d01101d0ccfb3923fdc96b2c82~SWMplsUCy2561025610epoutp02g
	for <linux-nvme@lists.infradead.org>; Tue, 15 Jul 2025 06:27:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250715062711epoutp02c8f482d01101d0ccfb3923fdc96b2c82~SWMplsUCy2561025610epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752560831;
	bh=Yu9SHAbXQrdd5VAieT9a6TJ+4eyWeGwYWNhRE0NfEIw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Y+G6EnEwZag2kaehWMbD2QX7jhTnP84u0gvucDnVz/WTZYWMHZfO9u08fqJ4RpiRj
	 rbm/PAYG0rhUcftxg9iEuLvvwY72WOC49/pKFc/gQegf3fL7gs//GkDGg4PpjXD/kL
	 6jxj5WKnPPBs35Qu4nmlxXvhUQXvoC2JVdPqPAMo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250715062710epcas5p39e6ff2e44713c32a1c41c93924119de4~SWMo58OGZ2592925929epcas5p3a;
	Tue, 15 Jul 2025 06:27:10 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bh8Ns5sVSz6B9mR; Tue, 15 Jul
	2025 06:27:09 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0~SWFco3pJB0911209112epcas5p1v;
	Tue, 15 Jul 2025 06:18:56 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250715061855epsmtip1850f12c138e95b469866390e02f5ffad~SWFbmC4_G0162901629epsmtip1G;
	Tue, 15 Jul 2025 06:18:55 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: gost.dev@samsung.com, nitheshshetty@gmail.com, Nitesh Shetty
	<nj.shetty@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: Add support for FDP devices in fabrics passthru path
Date: Tue, 15 Jul 2025 11:48:04 +0530
Message-Id: <20250715061804.1954522-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0
References: <CGME20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_232717_462751_2605D569 
X-CRM114-Status: GOOD (  11.41  )
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

In nvmet passthru path FDP is disabled, because of failure of
admin_get_features FDP(0x1d) feature command.
Supporting this through nvmet_setup_passthru_command enables FDP.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/target/passthru.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b7515c53829b..bf27ae4c42dc 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -460,6 +460,7 @@ static u16 nvmet_passthru_get_set_features(struct nvmet_req *req)
 	case NVME_FEAT_PLM_WINDOW:
 	case NVME_FEAT_HOST_BEHAVIOR:
 	case NVME_FEAT_SANITIZE:
+	case NVME_FEAT_FDP:
 	case NVME_FEAT_VENDOR_START ... NVME_FEAT_VENDOR_END:
 		return nvmet_setup_passthru_command(req);
 

base-commit: 3f31a806a62e44f7498e2d17719c03f816553f11
-- 
2.43.0


