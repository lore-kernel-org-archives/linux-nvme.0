Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F389BD0BB4A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FOGnnPo+2l07LTJdeO8Df3lJzUG6kmn68VSvTOlmhqM=; b=Oi6BHfhGbzVva8v4BKn1HyQrZ0
	8NFpZ0oPw+B/rJh6SmQdbUfcK8d+20muSzQ4TppGAbtHjUI6DFhZa2VEyBO6zI8T52QxV8JzXhJJs
	whLbqKpk5idEqcnrZgZB1LlwoGb8GA22Bo/xYYWSAFJNH6phzSSHQldrQfo3OP3p5HKxGEVlVyP6W
	UhPSYY2J6FbLQyROuLUUssm/PbA/K1t+mvpa2QTgoZblnOlKOv1tl965Ze/XlLmzcsE4j+jb+CwKT
	yLWpb5r7H+FNT5VkRSdWamyYAnILcztAuOn77COhTpJtSDVnFWJIOiyBB7mDNomEAh0oQyZDE4fN2
	Wt+abKcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDK-0000000GMZ6-3TY3;
	Thu, 24 Oct 2024 01:00:34 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDH-0000000GMX3-24e2
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731631; x=1761267631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e+kpyG220+KoHCI2kheLv/K8CS5ScJP/Pb3zrrneggg=;
  b=ErUkImdKRYidKvwgSRrqOvoIQxnYWTTQ0D2hmYuH3f3YL4SPYKTt43mW
   p4xbU58TktepDMD0t2MmUA45FoUM1E2NeEhgcVQ9PiJGKZE6DGhorWotO
   JpQarS6qRidoS2+mgc1u3cudiDtY7Px+ZuxsHcwBo4gm5dRCwBHAV1Tgg
   a6I087pwZTkxAa9SbLVGIGsnQDFv948jwbW8inZ5YeA/QeZ8vDmRVxCSL
   7XzyAT7ZDVoBAUxPpXvOVNLO6AfwO4nHL5uAgr4oKg/a90/8H31+IbL8Z
   VvfHtmPJTAZPrRhSjYWqjBtLjYjvnDgT8r82HpUoTKeMnt8qO/OQcLVtE
   A==;
X-CSE-ConnectionGUID: PL8n3aJ3Re6m5MMfU8Y3bA==
X-CSE-MsgGUID: draYIeUnQJW6kNdOW2ia7g==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211073"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:27 +0800
IronPort-SDR: 67198f13_V5W3TdxoYh5yap2jdtmV0rxVf4E8URl+4SyYyoo1OxGoV8E
 IEYzEgHeEXvcRuXUax4BYKBGR3JD9KNGMEyT26g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:35 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:27 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 01/15] nvme/038: use nvme_trtype instead of hardcoding
Date: Thu, 24 Oct 2024 10:00:11 +0900
Message-ID: <20241024010025.2216242-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180031_639885_BAFA6ACE 
X-CRM114-Status: GOOD (  11.52  )
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

From: Hannes Reinecke <hare@suse.de>

There is no reason why loop is required, so switch to the default
transport type.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/038 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/038 b/tests/nvme/038
index 8435415..497cc88 100755
--- a/tests/nvme/038
+++ b/tests/nvme/038
@@ -33,7 +33,7 @@ test() {
 	mkdir -p "${subsys_path}"
 	rmdir "${subsys_path}"
 
-	port=$(_create_nvmet_port loop)
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_remove_nvmet_port "${port}"
 
 	echo "Test complete"
-- 
2.45.2


