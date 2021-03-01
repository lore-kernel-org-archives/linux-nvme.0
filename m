Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725F0C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:07:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3674C64E01
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3674C64E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WaBeDzmosppe3aj9qOr5C4g5lwe/bPB1PljdmltHd7A=; b=dobLyNV3TtpIc3luFXVN4IZ43
	cmyZcWcr3Ku5+wg2kYMrFRaCBESeU6S90vuq6UOVjhTsURzgxLOlsJcbuIks+UBQ3IGkJQG8VxHRE
	vfpc8KHLVsIvTDPkbX7ZeIHPBNvYddle4GXNtrNfgNccf9NLXdEXwvtz1+OTbrYiQljs5thzFb/8f
	09Utp/Heyegw7A8D3aP8roDmnNMHfxdrtpBU6Oz8IbABQxrESO6laZ6hig0q1ZlEjjgvSLGxqYu12
	w1riEgPYhMhNPUfzjPUPhj5Uj5u0VQCIMcEuELow1V8ZNagWnw4yUTvhWmnVtOeqaztRGYBJMrUpO
	SzR+i8LZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGXxz-0004ci-59; Mon, 01 Mar 2021 02:07:23 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGXxu-0004ax-Vy
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 02:07:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614565644; x=1646101644;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NRDwKyvJ6PkFWIzi0BGcvUsqUzRRd4MP66nq84TqRmc=;
 b=FXrYzENbcxSBBM38SrUt17y/RjcleqSjEmAnIDBLwC97Zvs61vtYj3ov
 xX4+I+22eHGj0Qp2LHx0yI3oGYST6xQVTYqxIXaOcwZrl4vnx5m253kY4
 yBayGhH8LTG/TlYk7/p7BrB8QjWwQmAO43BF5uP7yyaouj3cLSgwxuItt
 sXoAMbhckJ7br0mp6cQR3TTL73qM/U2uf45V9tkEFp75W0qgeNI50PdVe
 1j1aTI6sMPcNcuoy2MTWEqxULEkeG4QCNpxCPSnic5GQszkIrPeLztm5n
 o00hGNQWbTCw51gMY//pI9qPnHFkUoty/8PDvOmZELDGakUC8/mtY/1cb w==;
IronPort-SDR: d2/BarXRV4icGKkNf1f/F6BW2BxQflz+0tW35sZRuyW3t9S+tGuiDoBkny46YlMGOBxjXqKR+q
 84amADG1wCY0Q4US8It1ebs+2WnuKmPm+wljsDVwVLcT9SLrZATNkADIaNKk2hKtoeMHCUCAvs
 c+ezkcxJJMuEz7U6XmtYfahqzSpdRSHoba29YBrh9dsdiCOfKsJtO8Gli4p7Lx0aCQtm/rvD7v
 cEJx2vOpZR4iwjUUbP1/jaGK7nnvV0knMvyeJUE/k1dRUWdKscGLLwEuEIBHU6yHlK3V/+gNEs
 xHk=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; d="scan'208";a="265287423"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:27:22 +0800
IronPort-SDR: yTzfRCevZSnkrN8/AM4p97QUH5Bxproom/XrI/va6whw3xljMsnbt8GYycUCZyq58yy5Z44EIs
 xupLj+YuavYk5GxXqxOHRNfguxAIqS3VH+MdiHfNCjULCIrYzBCCvAkuVY/6cbW2JsimB0egOY
 UthDiyBlJ1m+Zk9V+ImurrXg2eEMslv1fa3IlrE9M4xLftPx3DoO7fxSXO6Ms0J89JqWMANCw9
 D9zfRioHi5yu2AuGopqC0/87Js0jI9QXZgIuT173gz6IHVHxQ2jKfgQziK44Pe34O7XiSpmqfC
 atnMwYpjQtzGrbydpY/xzvtA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2021 17:48:34 -0800
IronPort-SDR: EfrLhH5yGdTVTLY5EtUJWBwXpLlwZOoLBKUEQfAJa9PAF9rzxpb4lJmp0hW2LhwEjhj9BmPK54
 5+w2vYtMUGrj2RPU2ofAwQRoBaKVCxbDjNUfczjlx6Gc04JNq2Tj6SqIezABwjiEyGI3BRMCm1
 dSREnSldnfKh9sU/85rccqXxvwew5TvfVxJf0i8kanCJyi93Q1NphUq+HJn9veUEP1VU9UKyCm
 Px4sirRfRDys/Fa2uwSZDC/1ai2uTrP8/NQ9dAwMScU13vMk9upBwuapLi45RzW2iR/oUflquT
 AZc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 18:07:17 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 8/8] nvme-core: add new line after variable declatation
Date: Sun, 28 Feb 2021 18:06:11 -0800
Message-Id: <20210301020611.18669-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210228_210719_257579_82919A2F 
X-CRM114-Status: GOOD (  11.52  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a new line in functions nvme_pr_preempt(), nvme_pr_clear(), and
nvme_pr_release() after variable declaration which follows the rest of
the code in the nvme/host/core.c.

No functional change(s) in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4858114f4f8a..472fd39a8286 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2323,18 +2323,21 @@ static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
 		enum pr_type type, bool abort)
 {
 	u32 cdw10 = nvme_pr_type(type) << 8 | (abort ? 2 : 1);
+
 	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
 }
 
 static int nvme_pr_clear(struct block_device *bdev, u64 key)
 {
 	u32 cdw10 = 1 | (key ? 1 << 3 : 0);
+
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_register);
 }
 
 static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
 {
 	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
+
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
