Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A13109E55C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2026 06:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6sxavwtg7kXYFeYgNiXv1vBn4QtD0M9SE4RLwM9smpQ=; b=HNAPHymWTZC+eye7EOmpSM1Kr+
	KQNCvTpPcjfybNRJhUsYxxeH19H/0nBBIK5mR+YkAh+QO9LL2LczW7nKujXhmq9z6R/X7MEaL/YHS
	rAE3eNl+zWzvppUS4/3qx5oSpmwXIy6ja9UyZ9YC//ctH6teIrNGN9U7Yn/s0mGBXSmphQMEYn4tX
	HyUCrjmYktoX7q+yWASNSFySfKmHggMp05T1rWeGSmEwYXAb31R/dEg1tKA2usAMTBht8r/14XFyS
	uArm6HE8tbI7D3SD/UHtJWfl2WJDbVaA6/kxUoCdud6A4i/5j7fqU8J5sdcvUtTzwe9zIxVHbjIWw
	VuO47w7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5eZX-00000004sEz-3VIg;
	Thu, 26 Mar 2026 06:52:03 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5eZU-00000004sEA-1EZR
	for linux-nvme@lists.infradead.org;
	Thu, 26 Mar 2026 06:52:02 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260326065154epoutp02ca5afa074398d58445cfd12f7a923088~gUYvofaTt0482204822epoutp02K
	for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2026 06:51:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260326065154epoutp02ca5afa074398d58445cfd12f7a923088~gUYvofaTt0482204822epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774507914;
	bh=6sxavwtg7kXYFeYgNiXv1vBn4QtD0M9SE4RLwM9smpQ=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=hp3bM6Q5Wtoaa5fu+1lqCUt42fm9pK4vAVB4U8qH5R21+BFvtcztShDkyJXj3XcuA
	 75h2Xt1ItbBWIe8MZ4jOrzik5Fmsr5Fo9hSoRF76lp+q0IU2/djWCLFM2YxD/j0tB7
	 8Toi1DxmguV6FovRQApQdPWJp4+cWOR80Qq1sIaA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20260326065153epcas2p1c255f43757bd4f0cc2e6addcad57b21f~gUYu2V8pX0236102361epcas2p1M;
	Thu, 26 Mar 2026 06:51:53 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.199]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fhDw935Vvz6B9mf; Thu, 26 Mar
	2026 06:51:53 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v5] nvme: Skip trace complete_rq on host path error
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: "hch@lst.de" <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Justin Tee <justintee8345@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sven@kernel.org" <sven@kernel.org>,
	"j@jannau.net" <j@jannau.net>, "neal@gompa.dev" <neal@gompa.dev>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "justin.tee@broadcom.com"
	<justin.tee@broadcom.com>, "nareshgottumukkala83@gmail.com"
	<nareshgottumukkala83@gmail.com>, "paul.ely@broadcom.com"
	<paul.ely@broadcom.com>, James Smart <james.smart@broadcom.com>,
	"kch@nvidia.com" <kch@nvidia.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?7J207J2A7IiY?=
	<euns212.lee@samsung.com>, =?UTF-8?B?7Lm47LCs?= <joshi.k@samsung.com>,
	=?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20260326061443.GA23850@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152@epcms2p5>
Date: Thu, 26 Mar 2026 15:51:52 +0900
X-CMS-MailID: 20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6
References: <20260326061443.GA23850@lst.de> <acQxjZMOqj74yIJf@kbusch-mbp>
	<20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
	<945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com>
	<20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6>
	<CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com>
	<20260326014429epcms2p135ffd3c2b2fface6423d045e9614c262@epcms2p1>
	<CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_235200_698717_50002BC2 
X-CRM114-Status: GOOD (  21.18  )
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

Hi hch,

I added a comment about why I do trace skip if it's host path error.


Thanks

Regards,
Minsik Jeon


From 3ee001c00cb4c7843d7bbb0c11fcc1fafeded9b4 Mon Sep 17 00:00:00 2001
From: Minsik Jeon <hmi.jeon@samsung.com>
Date: Thu, 26 Mar 2026 11:09:57 +0900
Subject: [PATCH v5] nvme: Skip trace complete_rq on host path error

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
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766e9cc4ffca..df5a47b8560d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -458,7 +458,14 @@ void nvme_complete_rq(struct request *req)
 {
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 
-	trace_nvme_complete_rq(req);
+	/*
+	 * The idea for these trace events was to match up commands
+	 * dispatched to hardware with the hardware's posted response.
+	 * So skip tracing for undispatched commands.
+	 */
+	if (nvme_req(req)->status != NVME_SC_HOST_PATH_ERROR)
+		trace_nvme_complete_rq(req);
+
 	nvme_cleanup_cmd(req);
 
 	/*
-- 
2.52.0


