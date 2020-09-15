Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2376C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDC22078E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Od22bCS+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BkxQ+ZBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDC22078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U+uDxZcCWOrvgOdhxIjhYJ1cY0XDWt2Ac8dcOlGIpcA=; b=Od22bCS+GafD3JCxUDRloIvy0
	Lfjv6+a4lX4tXhdod9LM/jXIV/l9qDPVsGh+FWA0/+i66oP9zAgxE9WCbsuQMHw0ZZ1jTIj0fSiNV
	ajl1R5DAjVEcomGJ7fM0cMP2u7ou1kCvAGH6A3J2lDQEam5l6LTPdbZoXjynblAE/4IzQ3Qcp+jGq
	YxLWrN4EQOFK+8hiV9MOKoInIgAB/cM9+/IpupVP5CIys+BLcCsC+wn6FG7gCwhB9ps1fT0gZZNQs
	+ZwXf6Zo7kzVSx+AEnf1JnKtcQJ8SCYwUWQXi2Ex+45isl3QS4Z4u8moZVbPstL9L+8QvZMGlffLo
	jSejcOOTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIrm-0001bm-58; Tue, 15 Sep 2020 21:51:58 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIrj-0001aW-C3
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206717; x=1631742717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ViipjlKs5/I1V1rb4W3UezvYAfS2Lo3m6xDEkmOVLv8=;
 b=BkxQ+ZBprkWZzp9Q5ful8gPF8r1KcJDDsQFR4+nVqXy43bdiuTGJzmaQ
 +Ulg58lg4IhwPblm5Ddek1onQCDVvUpOFjQN+VYE5eHzonX+IRuu1gA2P
 lYoJmGy4Y4k1hlFGyWDfY5JYCWiTtB021hC7ef2LgaQeNLHMp/KHgbPQK
 aukm79XBBZ+MUMzjpPLLYzYUZa/4nBOruV6eeQHvpdj0xHEWXHe9I7YTD
 4BF7YtVyk5Gp+v5KvCThzZsgssQwr4e+CoW8euydwAiWDLQGMXAU4zW9o
 ysukZjkUxe4vODNFQgO/3w79RnuOhyiYiGkl091svUcVnnF/zkWXGCFim A==;
IronPort-SDR: UBJFfOmxcmjg8/e9E2jQinxKEJqAybQEHbAWYZrsJ3jgQ7SUwgDEK/MRybwrine58O1bbHSYLm
 taGa6ekRJFrMVoGr9oUZ+qhrLCU8jMSf6AqiqAZUq+btFKcfQ2jaILgYMudvVpqW2W354APJSi
 QxmByiicuS4jA1ZH84DM8w4L2aS2Pbbj42K2cl7YjrieSHABc3jp2GlPnC6WVfGIeTlV/1s1Ch
 mCXLXVYQzyQtJo0kkhw+QvULpJQEjF2zDgjywvo5sW0sYEkMgbQsGgcokWhGPUROur0NKe4zKb
 q7Y=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="250793339"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:52:01 +0800
IronPort-SDR: h8JC+OONe0rLXhfi3nREJgZ5lr6Wa+n/k43ib7rwUeSVJ0EaB9RVmCBL8TgvwkHOjZM7Lpewbk
 z7PsxSlAIn9w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:38:52 -0700
IronPort-SDR: 9mV/GgQbSjKpMDke6vNEBq/Z6K52PDZTbl3oVHvz8x+fOkDkBIS8op5aRQnnkd/UZdWBXqWFl7
 +CJT3OXcjTyw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:51:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 3/7] lightnvm: use I/O timeout in nvm submit user cmd
Date: Tue, 15 Sep 2020 14:51:14 -0700
Message-Id: <20200915215118.3934-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_175155_634880_14145390 
X-CRM114-Status: GOOD (  14.96  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function nvme_nvm_submit_user_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable.

For now we don't set the request queue's queuedata for admin command.

Use newly introduced helper function nvme_default_timeout() to set the
block layer request timeout value which sets the appropriate I/O or
Admin timeout values when caller doesn't specify the timeout value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0f2c30..74ad5427846a 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -774,7 +774,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		goto err_cmd;
 	}
 
-	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	nvme_default_timeout(rq, timeout);
 
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
