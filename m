Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC92C5475B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 04:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZKcVETtMR/YH3xsz+MMaTkP28duAbRYB2LR8yF3IU68=; b=gaitsEc7CXx/7+MTmcpyQ1sb4q
	7hQEkix3oMv2uFQ9OEuAa7SylRK4Ph92VXL5bTZ41+ehbu/a0IblNNRweKHE7knLptvHs5rNaM++j
	obSq4Uo9K+OcetVkOn07vHr6XtodUDc45YVee1hI57LKBokxYO/GUJP8wdQU3jzzj3n3f/U0zEO7b
	THFqu217f+c1hl2Fjw2nIll79Ealrg/O66mkcyBOWmphADmysB203UjJpwdgCIlwr8eNLl5C7xV/z
	2XQeFrqGo61NMOWiQsiDniyjMwv1tjKsQ9Mcv8OKh4cQc1tK2iy2TOcEMs4N/9rXv/41kOnuTDRdR
	sQInpbSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhjFb-0000000GJ12-2XBx;
	Wed, 06 Mar 2024 04:51:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhjFW-0000000GIzb-1ADH
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 04:51:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709700686; x=1741236686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3hCeWuYQFqJ6USAChZfUqKryRkSPuJRCcVGLOJi7m7c=;
  b=XqcUYpAYWyYr95PXlQOsSZAQ5zXTYEQFekGd6HKjOB5v6NR2hQ3mVroj
   VK4QAZTrbBI+Opj2KfOqgNygDWu+vLd5X7PAoyoGXxaTlbTRehcfH4YSy
   Lmubd7SfTrSjKN93UWJ77zh8aVLaQsyF5UwnVM7nml6+dwHW85Ss8HLe7
   hwwARYMdhdY40aEBVB+0yX8gcN1o96cC5mMQsrv+R9foYQgVoE9sjI8qn
   1xs3QG+HY0abOFojk7FCD0Nh8Bd3bVrvp+830kWYII8cvqq3j1ih8PiX4
   fm8LCurgiXe7gYfFvEfxzxkaJjUnpFHZUdi6xxVo+7ZVWVXP2EsQmPvZl
   g==;
X-CSE-ConnectionGUID: mkscF3M6Sv+6avS6da4lag==
X-CSE-MsgGUID: tqcDja6yQOSPeWLBpZokow==
X-IronPort-AV: E=Sophos;i="6.06,207,1705334400"; 
   d="scan'208";a="10451670"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 12:51:22 +0800
IronPort-SDR: 4Rar1085jzllHcy5faLyGF+DlqrHF3dVb3ll2RBIvW2wH40y78uAf9sDA0LAmZAHOWvD7EIejz
 DiYgWV136W8w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 19:54:52 -0800
IronPort-SDR: WJBBOnn/XHjWFNfNmi/NZhW0ugZ3+OuLeH3s0Q8fmXAQj92AcCWa0Ise6RfykhKHA7VOceT7k4
 e/DKN/8SS3lQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Mar 2024 20:51:21 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme: host: fix double-free of struct nvme_id_ns in ns_update_nuse()
Date: Wed,  6 Mar 2024 13:51:20 +0900
Message-ID: <20240306045120.2605223-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_205126_441539_9F5C7A86 
X-CRM114-Status: GOOD (  13.38  )
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

When nvme_identify_ns() fails, it frees the pointer to the struct
nvme_id_ns before it returns. However, ns_update_nuse() calls kfree()
for the pointer even when nvme_identify_ns() fails. This results in
KASAN double-free, which was observed with blktests nvme/045 with
proposed patches [1] on the kernel v6.8-rc7. Fix the double-free by
skipping kfree() when nvme_identify_ns() fails.

Link: https://lore.kernel.org/linux-block/20240304161303.19681-1-dwagner@suse.de/ [1]
Fixes: a1a825ab6a60 ("nvme: add csi, ms and nuse to sysfs")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f2832f70e7e0..f31674d23397 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -221,13 +221,12 @@ static int ns_update_nuse(struct nvme_ns *ns)
 
 	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, &id);
 	if (ret)
-		goto out_free_id;
+		goto out;
 
 	ns->head->nuse = le64_to_cpu(id->nuse);
-
-out_free_id:
 	kfree(id);
 
+out:
 	return ret;
 }
 
-- 
2.43.0


