Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399CAC28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8P2e9s4VPbLwK+ODKxZBUAt3xgP47XZTv32/WbLbcAo=; b=jdFsadCcbzD4/BK1v9a6UaBNu1
	aG2hhX4xR2So71wwaE3vb96y276F2DPSRdP5BLGDhpyWfueXpXLmCHpLZU1rIIBOzNB3G0r6p016d
	7GuJ/6sMmydlnW4/fxb6tPvqUU3NZNMZYsl/JqXaDdhdaf2PAJ27wExdxx2hA3UXKmetm1xNePgWJ
	P/Ui6NhWzJKYoMpB19GzQtnb44QXa63jvBWNJ5rzqo1CQzbe0i4Kf8tet7yqWkAkkKnb1BzKBJVl8
	7tZnXddD5PJ+bNiRXVFebvN1VZYLX1VW/T5dNBGpbSgVOnj+fZ49aK9mfnPzuAuvWsVGAkBp+mDks
	ewIQZjFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsfH-00000005P2Z-0CTR;
	Wed, 02 Apr 2025 07:37:35 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsfE-00000005P2C-0SvQ
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743579452; x=1775115452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JlVRPZwLt3RUrlJExCGY1YEQ/7fzwWjGBb2a+wUSp08=;
  b=GSOq/nPOtOpVdz3ucFefZCi/fjoeKCcFCF8HNZzY/v1qhF/Nr5Tytl8V
   kGQzYQiQC+V+QUR9wegTh93l/yd5rhNcjXwz8Oce7O+jF4wAM7kq5+znk
   W4Eg4Mb9c6lRDK/dZw6aAUllcjy21ZtaWgWjcTsOBfga9dC+EcJCKZQJ2
   A81UcGjlNkFXBaBVtIbldduPMbWziEX3Q/Oq34WnsJEItkRgu97OiQjp+
   4fKudb+NwSHC1VquIGeGUVrlqpS//7IpkcTWyG6h48eqRqZAfIJ8KxmFW
   9gsIZ80e+tdN2AhEDkMesqT8Gl/s5/aA+xv+7VsTlYmMaOmb9fTWWaclJ
   Q==;
X-CSE-ConnectionGUID: Pe+C43f7S1qSctWW0vVi6g==
X-CSE-MsgGUID: vGjp4E3+T8y5fwuDL/oigg==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="68592523"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:37:29 +0800
IronPort-SDR: 67ecdb41_USQp4DBwzlYCBGLX5K9KbAxVA3KSSAh/ekMFkZ01mFfARTE
 aYq9RH0qPOMaig/9V7GspmqQFcudN/7znAQrlaQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:37:53 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:37:28 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Steven Seungcheol Lee <sc108.lee@samsung.com>,
	Daniel Wagner <wagi@kernel.org>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/025: use character device for nvme effects-log command
Date: Wed,  2 Apr 2025 16:37:27 +0900
Message-ID: <20250402073727.395179-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_003732_276751_B1070611 
X-CRM114-Status: GOOD (  11.60  )
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

The recent nvme-cli commit aec85d96e07f ("nvme: add error message for
mmap_registers") in the version v2.12 dropped the feature for "nvme
effects-log" command to fallback target devices from namespace block
devices to admin character devices. This made the test case nvme/025
fail with the message "Block device isn't allowed without csi". To avoid
the failure, use admin character devices instead of namespace block
devices.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/025 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/025 b/tests/nvme/025
index 529fd0b..7f7e07a 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -24,15 +24,15 @@ test() {
 
 	_setup_nvmet
 
-	local ns
+	local nvmedev
 
 	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
-	if ! nvme effects-log "/dev/${ns}" >> "$FULL" 2>&1; then
+	if ! nvme effects-log "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: effects-log failed"
 	fi
 
-- 
2.49.0


