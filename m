Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81749C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dHQvo7xWAfOgwXk+kZ7N9O7ysK077NjI0KTcBoXyK88=; b=prp5yilii1yuvOTKmgNjCbNOy+
	fzqTRwkQ0D0M3q2kwbwLepk0thl6KfynPnjmKJrvyzw+1iZx6+u4gciASl7zko18jogONiWepNAr6
	948rK0i9Kap3VzD7CFBzyWQ4QezrKgTUpUdwDocHZE/xDQqDefzdvl8Ztm1P+RYUydcivZWKfAuuI
	FCaclZZl87ntc44HSmrq1LHLo8uwwqmxka/MNlq27SY5Cc8gJMzWPq7S9SuxvMt/gucrqPiLJnMIP
	ESZ6jJwOzTUQRv9SpT9H0ktg14uWWuf4O5NQzKpFsdEiYGDXsA5y7NnAvEH0YDdIFW5QKpidTNLxx
	Nwp9dQLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXYL-00000003CCb-37xK;
	Wed, 24 Apr 2024 08:00:29 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXw-00000003Bnw-2WbI
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945604; x=1745481604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqz9/msx15KbB+BgGwlvy/0PKz1/iD3nOvV9RFRZu68=;
  b=EA7gHPRpq280W5ev4FHXGRlDdw04tTkPry4e/+83Ssj7tdy0FAoWq2Ks
   Jf9IcDrWPVCsjRBAsWnDjRjDj5iIBJNudlMyNFZf1FsPN3nzIWLLnSFmx
   KDxHwF/8Q4+AhB8TFR7qFsp57z2fQ4B2Qkn0sfRcNDEGk5c6PWFCKqg+5
   p1pHxoAzqW1PsNEy/1nZd6bHmzCUtYeiKyE07gkf7SY/DeHOMDHdAMFNG
   YfYZnsXU46T5BGf6b0ZJUD/N6flqHKg/7JHrzqU0LZQwExQ81xJb4/1Bw
   nRl76rHUmSZ17Uc3BHEuBO87WT/8xlLFDrhfX48W84eGJ7pCeiboUOdpF
   w==;
X-CSE-ConnectionGUID: DKeY29MGRwSVmze/Hgnkdg==
X-CSE-MsgGUID: J1OPJxCgR2CGICHJplf03w==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738267"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:04 +0800
IronPort-SDR: BuWxXAAm7K2aFnPxDvzzoFQ+yfY+6tQG4LFLQkqZ5SQ8C+FPhTujK/70yoM4SnzVm6J2AFXZuF
 rM0F8irBSj/eSEE7CheXIySIFHuPohVXoRrkYkfti/WhEsPtdeN8hELoI6oHnGbrmRjBX0OunW
 fJp2pYcJqlWVsBsIoYU26AQ/4Fs50ENGC7/Z4oWusBnmhIWu8OqaaWHenNhKhqg56iYxyCd0h3
 x7bA5fhsie88iqqX7zQTavSNeG2CsPoW+ysEOUHAmQER+evALzuczP177y1kITDSKewwAhPkvV
 NFk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:14 -0700
IronPort-SDR: pzNP4i1S5B7uUSQ5rY6jpRFfzZUbNZEQHnHXl9DZ9h7MioOlSR4BFRsQflb5dPBzdzuWywqrVx
 11bOxLgkwBvisEqu5m6ZpwlVSTj9rMGgkqMPc++2ZI6/1Mi8cNYl/NNRgfq73g2lXpTyIuhuS6
 Qj7y4fmkwlEk+w49ECBKu0++L6BqAPR3CzYRG/XVG7nI7BecOpsY3ShtW94g5Xkz78GUtxIPrS
 NHkw0m+yGe6FyuIm3ZdF8AdimR9VXHIa+qSVNRm9nUd7JYP9Hl2+j7dUlkg7zAiHkoLQIQBsLq
 XSo=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:03 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 07/15] nvme/rc: add blkdev type environment variable
Date: Wed, 24 Apr 2024 16:59:47 +0900
Message-ID: <20240424075955.3604997-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010004_822128_AA57E74A 
X-CRM114-Status: GOOD (  10.41  )
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index f35ed09..ec54609 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 
 _NVMET_TRTYPES_is_valid() {
 	local type
@@ -855,7 +856,7 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
-	local blkdev_type="device"
+	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
-- 
2.44.0


