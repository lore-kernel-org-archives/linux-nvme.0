Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3590D109E530
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 01:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5IYFGg1UCPmPFLY2KOd+jdUPq6T6ca4Lx2iykpqmAr8=; b=IgK/WuR9eNs5NkRCAbCykTiYIn
	FtoPZON1Pnm4Yh1OvY/6uW025cI798Zp+EANedPBPFy2rY5WXyxv9ZnQC9EbprekvzeO7uc/qm6Wn
	/n3XAI0zrnvOjf38+2S6mXz741nRrY5pAwis7r/puTEhf1OG994UWkmuFeSX0AlXxSED9HoPmFjQJ
	s52Y5zLQ42XpyXLvjBooXcmguCavaMeTVUqsH8ZPCAmj481bf+NaMjcMLkcHSg0ibBZOTb5dUChEU
	SgclAlBL9Np5hXQbsIYjx6SvOkKBsZpeWJAs7NF6WeY2xbFHdkSoaSR/ZrAvMVtW8ghy52BCu2BAM
	ZBBptOrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Zm7-00000004XDh-0dsv;
	Thu, 26 Mar 2026 01:44:43 +0000
Received: from [203.254.224.34] (helo=mailout4.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Zm1-00000004XCx-48cN
	for linux-nvme@lists.infradead.org;
	Thu, 26 Mar 2026 01:44:42 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260326014430epoutp04e96f4345ce84a2f80357821ffad26b29~gQMWuw_Hl1201512015epoutp04Y
	for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2026 01:44:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260326014430epoutp04e96f4345ce84a2f80357821ffad26b29~gQMWuw_Hl1201512015epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774489471;
	bh=5IYFGg1UCPmPFLY2KOd+jdUPq6T6ca4Lx2iykpqmAr8=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=JMZIznl1aO7O7Xv5twWyBhBf1b0RQEUjKtnKv52cPgPKcGH+RIijvCxIjEKOCyRgD
	 t+in4gRB0Lhpe2okGzHFc66PECYkzsIdHjC5GhZ5mlUNdI+6RJmCqIH1mVbtMF1V58
	 e89LErauOU06FlJJ8gF2ai7ex0w89D1Zq7YKwLJA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20260326014430epcas2p2421661bf9a868d815c1784a27dd8aae6~gQMWOwq2y3270532705epcas2p2S;
	Thu, 26 Mar 2026 01:44:30 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.211]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fh65V0K4rz6B9mB; Thu, 26 Mar
	2026 01:44:30 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v4] nvme: Skip trace complete_rq on host path error
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Justin Tee <justintee8345@gmail.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "sven@kernel.org"
	<sven@kernel.org>, "j@jannau.net" <j@jannau.net>, "neal@gompa.dev"
	<neal@gompa.dev>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>, James Smart
	<james.smart@broadcom.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?7J207J2A7IiY?=
	<euns212.lee@samsung.com>, =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>,
	=?UTF-8?B?7Lm47LCs?= <joshi.k@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <acQxjZMOqj74yIJf@kbusch-mbp>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260326014429epcms2p135ffd3c2b2fface6423d045e9614c262@epcms2p1>
Date: Thu, 26 Mar 2026 10:44:29 +0900
X-CMS-MailID: 20260326014429epcms2p135ffd3c2b2fface6423d045e9614c262
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6
References: <acQxjZMOqj74yIJf@kbusch-mbp>
	<20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
	<945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com>
	<20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6>
	<CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com>
	<CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p1>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_184439_514732_D0106F4B 
X-CRM114-Status: GOOD (  18.73  )
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

Hi Keith Busch,

If it's host pathing error, Do you mean to skip `trace_nvme_complete_rq()`?
If so, I agree with this approach.

Thank you

Regards,
Minsik Jeon


From c1f3c209c35233154bf5918092bdbb085828db23 Mon Sep 17 00:00:00 2001
From: Minsik Jeon <hmi.jeon@samsung.com>
Date: Thu, 26 Mar 2026 11:09:57 +0900
Subject: [PATCH v4] nvme: Skip trace complete_rq on host path error

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
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766e9cc4ffca..8f98d5220206 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -458,7 +458,9 @@ void nvme_complete_rq(struct request *req)
 {
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 
-	trace_nvme_complete_rq(req);
+	if (nvme_req(req)->status != NVME_SC_HOST_PATH_ERROR)
+		trace_nvme_complete_rq(req);
+
 	nvme_cleanup_cmd(req);
 
 	/*
-- 
2.52.0


