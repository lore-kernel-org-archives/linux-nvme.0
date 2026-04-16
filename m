Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABFFF433D2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 01:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:From:Subject:
	Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=dOcrdt3IS2q/Pm2ZxII48JYZMOmqsJvtRrRQXt2YHi0=; b=Z2dnqpf/MBtif+82Q45ql4xCtO
	HGwSJqMET+Wydd1+p78EPYiHgRhwuGEqkzGlkW1RqdBeekl/xo5Ysp1SlBM7Uvhuru7NPF65ddQ4J
	lcjHUfWPMxO/cHTz86J9ZAdG/Nr+kZSjQh9cT3oq69pC3csBpMVvqskQpcaMa50BhPg7EVM2/FxVa
	nPeAhXGJarHCsB6SXpoH+UeRILhhRpY2TkareoYD/BipdH1Nzr+CTThgJVLbA+zB9LupuA/g2SGFJ
	dVlJWXsWYVuYeHmEjugUZZYM6CUgT+NyX+Og7zGLIMjDCxgnEsZW52D/bUcAKjEFwXkV+ZoJzSoa3
	E9/SKNAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDBCa-00000001plL-2MIV;
	Thu, 16 Apr 2026 01:07:28 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDBCX-00000001pkz-10kQ
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 01:07:27 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260416010714epoutp04435a54c361def4c84bb3d595932891f1~msOzyTBJv2007220072epoutp04G
	for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 01:07:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260416010714epoutp04435a54c361def4c84bb3d595932891f1~msOzyTBJv2007220072epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776301634;
	bh=dOcrdt3IS2q/Pm2ZxII48JYZMOmqsJvtRrRQXt2YHi0=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=WiqWGSrXwns2LxQZ8m7QO2/+A+1bLnjW5b1mBQmYvEqVVB5Bi0j1YxwVylXQ8MVWG
	 qbc1DReyEMpTucD2pLGdinlMou/qQc7uSe97TOClgPaHhrpvuIMjn+YO80Sq9r7afZ
	 8AbkfwTzyatYnF2xox+gZgR9AbV/BZa0QTWtS3jw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20260416010714epcas2p3293bed73537e5176d2a4cf093833dc89~msOzdQY2T1776317763epcas2p3I;
	Thu, 16 Apr 2026 01:07:14 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.212]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fx0Gp1H28z6B9mK; Thu, 16 Apr
	2026 01:07:14 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v6] nvme: Skip trace complete_rq on host path error
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?7KCE66+87Iud?=
	<hmi.jeon@samsung.com>, =?UTF-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?UTF-8?B?7Lm47LCs?= <joshi.k@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
Date: Thu, 16 Apr 2026 10:07:13 +0900
X-CMS-MailID: 20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930
References: <CGME20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_180725_908237_82A27651 
X-CRM114-Status: GOOD (  15.88  )
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
Reply-To: hmi.jeon@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From cfd386c2d769552c4dd32ec8ff5233ef34f9830d Mon Sep 17 00:00:00 2001
From: Minsik Jeon <hmi.jeon@samsung.com>
Date: Thu, 16 Apr 2026 10:43:00 +0900
Subject: [PATCH v6] nvme: Skip trace complete_rq on host path error

we were checking host_pathing_error before calling nvme_setup_cmd().
This is caused the command setup to be skipped entirely when a pathing
error occurred, making it impossible to trace the nvme command via
trace_cmd nvme_complete_rq().

As a result, when nvme_complete_rq() logged a completion with cmdid=0,
it was impossible to correlate the completion with the nvme command
request.

This patch Skip trace_nvme_complete_rq() on NVMe host path error.

Co-authored-by: Beomsoo Kim <beomsooo.kim@samsung.com>
Co-authored-by: Eunsoo Lee <euns212.lee@samsung.com>
Co-authored-by: Steven Seungcheol Lee <sc108.lee@samsung.com>
Signed-off-by: Minsik Jeon <hmi.jeon@samsung.com>
---
 drivers/nvme/host/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e33af94c24b..e92c97fad305 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -454,11 +454,10 @@ void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
-void nvme_complete_rq(struct request *req)
+void __nvme_complete_rq(struct request *req)
 {
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 
-	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
 	/*
@@ -493,6 +492,12 @@ void nvme_complete_rq(struct request *req)
 		return;
 	}
 }
+
+void nvme_complete_rq(struct request *req)
+{
+	trace_nvme_complete_rq(req);
+	__nvme_complete_rq(req);
+}
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_complete_batch_req(struct request *req)
@@ -513,7 +518,7 @@ blk_status_t nvme_host_path_error(struct request *req)
 {
 	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
 	blk_mq_set_request_complete(req);
-	nvme_complete_rq(req);
+	__nvme_complete_rq(req);
 	return BLK_STS_OK;
 }
 EXPORT_SYMBOL_GPL(nvme_host_path_error);
-- 
2.52.0


