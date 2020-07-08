Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E47C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:59:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8321206DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aTGt9xHo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VcNCb5bt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8321206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Gswysu67fj7nS6kCdV1qCgIKU4rZW1BbPM7vk9NMzPg=; b=aTGt9xHoVRQ7b9jhMAHughBBp
	tZ3l1Ry/wMVDwVy4mHzib1fbPyf8CzOwUyBrRvco+w3qoV10RVhH3LLGsl1vLxzirbKH5Kr6jlnph
	JXziSIpX5MgO44l6DmgL5FLK08ho+My4v3PEeYfpnoylnfU5QXgPbEKNDxdFt3bifiM7GXx4fvpzM
	rXsoNIUAXe6rfujmBy1S2xBQeiHIiqrqB16jCttO09VBZuYm8fkAR+3iMDoP2eHPDYIfnds5roWHH
	tm6LTvScbd912VrGneQ6SSsMT+sISxsvkzuRjGHMMMb1iBwoNJTDkgB/JQVSYfZWQbnQI6LB2Uhyy
	3Nn7HJ/4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsyQJ-0007Q7-W0; Wed, 08 Jul 2020 00:58:56 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsyQH-0007Ne-IW
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 00:58:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594169933; x=1625705933;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mRMt369gK0mFyfNEROtMueLAEIfA2xaPK64/2X1sT0U=;
 b=VcNCb5btcuy18BxWDPefJca/Z9fMMlxXM1poKvkJykUiPvbLocSLIAtp
 FwcxPOz/KyZRc0LtYOzMDmIGnG3Ew/C7HDuIKVg8ZpVU9JcWtOX1ocOrq
 btWwykMkkBXGvXDUX6KYv+uonxyqgdhKi3+zHva9+J9OiX4jC1o95/1PP
 7mn/qfXt246ULzUbqCrNsO7l0eyoGt4kVrZb8ORhwaV7yow2ndCG3XRop
 Eiw0WuvIuCMz5rOh9ZYAG7I5hh/7Py2TCNnnOYEq1dvQ2oWdBh00Q2VrM
 8EZnqB0ED4DLlEx99cvpWnDmWzEHputFPodvlqH0hs9Pgh0AprZG3Uoub A==;
IronPort-SDR: HRUGSrt28KyKl2szlOJ11q6F4k1mUTDVJxvk/hh1IQHf1BaoKXz6mqARX1yHWIsim0f77bvi1a
 ztHI+k39klXSdS2FAl+nZAO1lG7YB2vlvwJP+Xu5FVOFxwpydrPpWg7riR87cAc+YonuwL9hRe
 EAVythtG8+ccGdWa722xcttfEyKrnS0kPPpMTAuX290U7GTZY+T8QKn+UPEykCJc1V44vVWwG+
 Q3WWVoZHq12j5f/7gr2dUk8F/8H+iCOzoS8/3nPSW2/1OnVfXaI9dUzZBLFAVuAr1AnbVIdKLy
 Okc=
X-IronPort-AV: E=Sophos;i="5.75,325,1589212800"; d="scan'208";a="143204247"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 08:58:53 +0800
IronPort-SDR: 5KYdpn5dOXNXCl4llJzPfQgrpfUGpf4GgOFCj7oPNNP6TIJD0EPqjKJMGeJ4THnR/5njyUBM1T
 3t5GpSxFOPp4HGCr+anvG3lHCFKBhhf2U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 17:47:32 -0700
IronPort-SDR: dw7G1JVCY1XK80fVVkQv20BTnbAHWgDpjD+BYGXUw+G+m8WqY+reHygIVK/uJNP1bKUReLJqCY
 p5jJAxxcQsCw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jul 2020 17:58:53 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH 4/4] nvme-core: fix checkpatch warnings
Date: Tue,  7 Jul 2020 17:58:31 -0700
Message-Id: <20200708005831.10013-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
References: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_205853_822294_CB64F33E 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch fixes couple of warnings (comment fix and
unsigned-> unsigned int) reported by the checkpatch.pl which
were present in the original code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e0b47e77cbca..a35725aa6144 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2344,7 +2344,7 @@ EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 {
-	unsigned dev_page_min;
+	unsigned int dev_page_min;
 	int ret;
 
 	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4a56897e9081..9aa1d17f06e8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -39,7 +39,7 @@ extern unsigned int admin_timeout;
 
 /*
  * Default to a 4K page size, with the intention to update this
- * path in the future to accomodate architectures with differing
+ * path in the future to accommodate architectures with differing
  * kernel and IO page sizes.
  */
 #define NVME_CTRL_PAGE_SHIFT	12
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
