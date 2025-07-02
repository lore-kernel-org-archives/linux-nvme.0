Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CADC83038
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 00:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DXTvgaINMTOqdNdJRluZZri+HFrqYoYEWcs5//v1woI=; b=nOPxFwpYQeC+ZmibCk4Faqr9ev
	nTG6F0iXDWJLcaRwoZ2RxVQIKVc9PcwpDZ1ahBOtSzrQaVBUo6IpWfxJyOaOp1TruoGulB+oLAvUR
	L2DMeVO5gHoe+U3TGIPgrKFc8ox8/T+NrWwHNflAxQH2/LaFlvgRtdos/d8GaNJo8RADDvhU3Btkw
	ASZSPb6OmSKHwcELww/2YPZv643rE0T71dAY8/0WAbzCW+53GowPIHvCpn/3G8GeXfjHZ45hiCJC8
	1KvFo/Uhnxhr23TcqCEJsZ/40elKz3TFpTAvgNQrF/i4zPYG55pNZ1ocqkytLVqv/hTJKE+9ODK13
	UI3wKreA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWlo5-00000006wYX-3SLW;
	Wed, 02 Jul 2025 00:58:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWlo2-00000006wW5-37be
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 00:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751417914; x=1782953914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g65gumUQfZ8kgOdiv2LMg63fItTV1vT54Qwnc+0Aczc=;
  b=H5MB5PR31eFxtQrrwHKaKNcJwARHghX/hgCCIQwEZNYvZDNQEg7IdnbG
   1sjjKRL6Z0bKVzUUhzneaxawaq8HiIYMVFcRtjIQhKYPJHTj7M1A2BX3B
   nKpX7OerIIbKssYjigJW8Q6RgTm0Y7t5BJ7PTBy+zHD81E/oby6Bz7aZ9
   5Iqelu+wudqQQXNVTdBQRl2w3rJcQhDYfzhcI77PkQML5AFASFdhazPgf
   +BOvnQCozSWm2Hk6vsSRvMhM73WWewBwNhNmot3vF5VKT9onf8Dezd4Cy
   4cX2A+JvX6suLzLtEz1HyLMNzaWKkoz6lULi51uSVSb8y+mQygcdJUrtz
   w==;
X-CSE-ConnectionGUID: 4doQSfmhSGqmpkkzALr5Pg==
X-CSE-MsgGUID: ZcZbbUfUQvWJ7FTnP9TyYQ==
X-IronPort-AV: E=Sophos;i="6.16,280,1744041600"; 
   d="scan'208";a="91662748"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2025 08:58:31 +0800
IronPort-SDR: 686475ad_E1heuoj497xmpHQ9OS8vTP7vFSb5LOMcxMBoPML97x3oBWk
 g20aeMKRqK3izPts2dknGeWfikefj/Vea0xFScw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2025 16:56:29 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jul 2025 17:58:32 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v2 2/3] nvme: prevent admin controller from smart log fetch (LID 2)
Date: Tue,  1 Jul 2025 17:58:28 -0700
Message-ID: <20250702005830.889217-3-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_175834_844287_08CA1BE5 
X-CRM114-Status: GOOD (  14.84  )
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

Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
log. LID 2 is optional for admin controllers to support.

In the future when support for the newly added LID=0 (supported log
pages) is added, GLP accesses can be made smarter by basing such calls
on response from LID=0 reads.

Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.

Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a1155fb8d5be..c310634e75f3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3705,7 +3705,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 
 	nvme_configure_opal(ctrl, was_suspended);
 
-	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
+	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl)) {
 		/*
 		 * Do not return errors unless we are in a controller reset,
 		 * the controller works perfectly fine without hwmon.
-- 
2.43.0


