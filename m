Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8661FCD128A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VM5MuIJU7lxRj9/0Ak/JnFIom/YV9TZNyadVTp2J2z4=; b=szsVOtm4rTy1Opben19K7ljDtn
	eolyo0T2CLzwVjjcjsZHleZKkCt20ZDUOH2B91WHn3VHBQaRXzzvp3J4sONtC37zFByjDQ1Q8GGQE
	zC0x9HELEvGwq4R+f5MdbdVxyNu2k5zpHNqcEHEGfBKFZbmt7i3F6kunbSuRvs/hAhvUl7aXAcwkc
	mvFVUmKvnsowUi2jS1R8zRg1FTzZfxPWvKqmNGBln8xmtaS1dLNFe4FROHHpqpr429jW2R+vLR82I
	wpn6L+HyBskXlHuSw4Y01MhPDWa8C8hs0JNDhWdWfjdlUCWX1lQsMLtWSXpeOcxLziCsyKC3iIflZ
	wesSN2AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMQ-0000000Bfjp-23k6;
	Thu, 11 Apr 2024 11:12:54 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMB-0000000BfVA-2r0J
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 11:12:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833959; x=1744369959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xe2ouHZKM2kASaDrrzIx5jJXgGT4TAs7T6mgQ8wPqts=;
  b=AToTekZ4/zG2KDW9s5Xeokb76lKoKbGpAQnv8Wz7kn8D2yngzXxJ23Hp
   MweZWYL/vRv/ztL2aEpOLiNwEh/+0QE9Nh4iAOqYDikf9uUlRwxntly0C
   uar0bx3PLmerZGctvDZZw3eg8JruHav0Y9INlXXNpQ3KXAP6vZ7UU/zOZ
   ZekS99KMgChXIpID6TMcLmIZ9ToVmfOft8yvOA62Hez8/QLw4RxKnj13H
   ZGaRN4fuHup3djMgjidT76jfUJTDEiErpt3OwfUDk0E3B7lG8x0rF9GEt
   LNqaBie+zz1wpTBsGX0lRziLQRrEdwbWm7gzxYpsbdrIeQ9rD13FWmDX/
   A==;
X-CSE-ConnectionGUID: fAi4EQF7QVqkf0wodgoJ+w==
X-CSE-MsgGUID: 9lrE/PLKQlmNlut6asqoKg==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13226490"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:35 +0800
IronPort-SDR: 8GpgBwRwzkKE16SnetYZ5uk4qSe+2NiGWdn0P90OMu91KcS17WuYsVvnqTEOjcKAJKRVC6nl6A
 RtuFTNgkt0aw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:21 -0700
IronPort-SDR: PBEXeBJ9bOh0/zbzWcuZrYr6YwAdEeYo6WjbISbmc8Nt+Xs+tri6hdGbMBcr0UHvayKa4+WH+v
 F5qdL3VQ4gkg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:35 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 06/11] nvme/rc: add blkdev type environment variable
Date: Thu, 11 Apr 2024 20:12:23 +0900
Message-ID: <20240411111228.2290407-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_041239_874174_8C431AC8 
X-CRM114-Status: GOOD (  10.68  )
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

From: Daniel Wagner <dwagner@suse.de>

Introduce nvmet_blkdev_type environment variable which allows to control
the target setup. This allows us to drop duplicate tests which just
differ how the target is setup.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[Shin'ichiro: dropped description in Documentation/running-tests.md]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index df6bf77..d51f623 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -20,6 +20,7 @@ export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 
 # Check consistency of NVMET_TR_TYPES and nvme_trtype configurations.
 # If neither is configured, set the default value.
@@ -854,7 +855,7 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
-	local blkdev_type="device"
+	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
-- 
2.44.0


