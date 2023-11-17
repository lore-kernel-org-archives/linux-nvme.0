Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D942FC197A0
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U6oyJLlSoBAUzLj0rIJJpbJX7g03j0/B3BYe146dCLw=; b=lFsmMGsKjZtRh9AsSvKHmtAnTI
	IjAG1j6RIc+npTYhykRiFt8VQ/hvwtoNHCrC8Sx17ak3RFY2XZL9H99yvhQfPRt1DJHmGV0qCqzYz
	RXrsMJ2EziOURuJdKcWskMvhSEYIwXUVNST4pI7D0CSBjUjxc0K5GkaIEmq7EqVj45qy9omB0mUA7
	ij5Mi+7QmkgpfaCmb8o334CFzgaQfApD2cdezNg5wepAZqAFZJMGPVy6/l2S7Yk1sz6oIbEK5tcgX
	Hrfkah24A39VTjx7IGaLJbaFpr5L46O2YdHlckuZXQiJ9FxsLWcH2gmbPfsghXsMWhBqkhLzp3SaU
	R5KDLJYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3xbm-006VOG-3C;
	Fri, 17 Nov 2023 12:06:02 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3xbj-006VLY-0J
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 12:06:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700222758; x=1731758758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iuYnZZ5x+m52xnq562/ihVwo+5QcU88vr1++Wc5eE8A=;
  b=L00lIU3p5NcmXGYleQFai5Igp3B+DyWLxOMYLCofQN6bwyrzRksQPFG3
   G2Qte+x7cR5LiFfr0iK1Bu9Dxr8CDmCRgF9bJnW7wTu7IJ+9MAbzvETmq
   SB6J8g5i7YLbReyC8GZ4yIMKAdkqUjwk2tJGEVzrusrngeZJjLRA+3Ynt
   fOzr34+MTLixkUGgxnL0Eq6X+pWALKzuGeUrlTiKAvQIyOScPav8MD3a5
   mxcrhz+URP5H4ux80DvSZ9XJQ5ee1SXTG0aKw6gryw493jJsapjI5+GIZ
   r/uGh71os/hTyc+SxF9sjw/cZk0GI6CjVCNyOwT4eVqqyUEtE/UtYUDNa
   w==;
X-CSE-ConnectionGUID: AbLR6kkpRlm/YMSv/tI44Q==
X-CSE-MsgGUID: ZGyjlkQLQ1WbVKvBqVqeIQ==
X-IronPort-AV: E=Sophos;i="6.04,206,1695657600"; 
   d="scan'208";a="2616489"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2023 20:05:53 +0800
IronPort-SDR: eXB7R9RqGhGp8mphbzgdGDny3kQ8sohkh7qj89zW7Alu+bGShuu+t0y1Xr3DGnxI6F4uc/DYBi
 927ewN1ChKdBJfR3tFlLzX1qKyTgKKEHVZBPpogQ9OhVt4jz2IE+Y6y+AO4LoKL/1R0sya47W1
 E7rIGRPFjJbE1siKMOj4aK3cGISpLqJr0s0zwPWIziCOCqE6+rcTFFXsBoBJ2qO4Tbj6ij7dJ9
 GcsYFyTz6Ih/iaKsMey/+7Hmwys/RO9V3oRL5dcPi5Gqvo/FIB5qT2xzPgpokjhQPmC71lkpr+
 I/c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2023 03:17:18 -0800
IronPort-SDR: prqoUH4AvALcF4lMZkLMwcFKpQaWkFwN21HEk+/klmxiCSWabMz+BYYe72NQqlvX8nBBvNZOAp
 /tSoLON524UujyOgf320zNorcaaI8DqHBiwvqM6YArILOCU8MryjXUZ4YX5243CtI0yp758Sqw
 xSx6J9xvvlqgGU5dFSPdB/q6M8BM1lXEExhY87ff8IeMsKZM951cP0tQBdur85KNMtWVN03HTZ
 ehcG8BLsKZURqisV5b3jMx6fFx4PcnG/CEoH5anCguV/zl75V2im1PvvPPDdc6651lbx43+MgA
 GJM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Nov 2023 04:05:53 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] nvme: do not print subsystem NQN to stdout
Date: Fri, 17 Nov 2023 21:05:50 +0900
Message-ID: <20231117120550.2993743-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
References: <20231117120550.2993743-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_040559_150269_DDE6FD25 
X-CRM114-Status: GOOD (  13.08  )
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

The subsystem NQN might be changed from the default value, but
that shouldn't cause the tests to fail. So don't register the
subsystem NQN in the 'out' files to avoid a false positive.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: remove only subsystem NQN from nvme disconnect message]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/003.out |  2 +-
 tests/nvme/004.out |  2 +-
 tests/nvme/008.out |  2 +-
 tests/nvme/009.out |  2 +-
 tests/nvme/010.out |  2 +-
 tests/nvme/011.out |  2 +-
 tests/nvme/012.out |  2 +-
 tests/nvme/013.out |  2 +-
 tests/nvme/014.out |  2 +-
 tests/nvme/015.out |  2 +-
 tests/nvme/018.out |  2 +-
 tests/nvme/019.out |  2 +-
 tests/nvme/020.out |  2 +-
 tests/nvme/033.out |  2 +-
 tests/nvme/034.out |  2 +-
 tests/nvme/035.out |  2 +-
 tests/nvme/036.out |  2 +-
 tests/nvme/041.out |  4 ++--
 tests/nvme/042.out | 14 +++++++-------
 tests/nvme/043.out | 16 ++++++++--------
 tests/nvme/044.out |  8 ++++----
 tests/nvme/045.out |  2 +-
 tests/nvme/048.out |  2 +-
 tests/nvme/rc      |  3 ++-
 24 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/tests/nvme/003.out b/tests/nvme/003.out
index beb3561..dc45bc4 100644
--- a/tests/nvme/003.out
+++ b/tests/nvme/003.out
@@ -1,3 +1,3 @@
 Running nvme/003
-NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/004.out b/tests/nvme/004.out
index 2559905..177185d 100644
--- a/tests/nvme/004.out
+++ b/tests/nvme/004.out
@@ -1,3 +1,3 @@
 Running nvme/004
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/008.out b/tests/nvme/008.out
index 62342e7..f7411f8 100644
--- a/tests/nvme/008.out
+++ b/tests/nvme/008.out
@@ -1,3 +1,3 @@
 Running nvme/008
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/009.out b/tests/nvme/009.out
index 853663f..4d53a8e 100644
--- a/tests/nvme/009.out
+++ b/tests/nvme/009.out
@@ -1,3 +1,3 @@
 Running nvme/009
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/010.out b/tests/nvme/010.out
index 90468f5..18b52d8 100644
--- a/tests/nvme/010.out
+++ b/tests/nvme/010.out
@@ -1,3 +1,3 @@
 Running nvme/010
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/011.out b/tests/nvme/011.out
index a780def..ebbb4f7 100644
--- a/tests/nvme/011.out
+++ b/tests/nvme/011.out
@@ -1,3 +1,3 @@
 Running nvme/011
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/012.out b/tests/nvme/012.out
index ec4bea8..5074d3b 100644
--- a/tests/nvme/012.out
+++ b/tests/nvme/012.out
@@ -1,3 +1,3 @@
 Running nvme/012
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/013.out b/tests/nvme/013.out
index 10b78ec..a727170 100644
--- a/tests/nvme/013.out
+++ b/tests/nvme/013.out
@@ -1,3 +1,3 @@
 Running nvme/013
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/014.out b/tests/nvme/014.out
index c431864..a6f98a3 100644
--- a/tests/nvme/014.out
+++ b/tests/nvme/014.out
@@ -1,4 +1,4 @@
 Running nvme/014
 NVMe Flush: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/015.out b/tests/nvme/015.out
index 829cf40..f854f0b 100644
--- a/tests/nvme/015.out
+++ b/tests/nvme/015.out
@@ -1,4 +1,4 @@
 Running nvme/015
 NVMe Flush: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/018.out b/tests/nvme/018.out
index 6b0e814..94b937a 100644
--- a/tests/nvme/018.out
+++ b/tests/nvme/018.out
@@ -1,3 +1,3 @@
 Running nvme/018
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/019.out b/tests/nvme/019.out
index a52325f..710f15a 100644
--- a/tests/nvme/019.out
+++ b/tests/nvme/019.out
@@ -1,4 +1,4 @@
 Running nvme/019
 NVMe DSM: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/020.out b/tests/nvme/020.out
index 9e293ab..61be280 100644
--- a/tests/nvme/020.out
+++ b/tests/nvme/020.out
@@ -1,4 +1,4 @@
 Running nvme/020
 NVMe DSM: success
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
index eb508be..c9614cc 100644
--- a/tests/nvme/033.out
+++ b/tests/nvme/033.out
@@ -1,3 +1,3 @@
 Running nvme/033
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/034.out b/tests/nvme/034.out
index 0a7bd2f..e342d97 100644
--- a/tests/nvme/034.out
+++ b/tests/nvme/034.out
@@ -1,3 +1,3 @@
 Running nvme/034
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/035.out b/tests/nvme/035.out
index a602713..8cbdea4 100644
--- a/tests/nvme/035.out
+++ b/tests/nvme/035.out
@@ -1,3 +1,3 @@
 Running nvme/035
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/036.out b/tests/nvme/036.out
index d294f86..c14b0e1 100644
--- a/tests/nvme/036.out
+++ b/tests/nvme/036.out
@@ -1,3 +1,3 @@
 Running nvme/036
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/041.out b/tests/nvme/041.out
index efee74c..1d0a5cd 100644
--- a/tests/nvme/041.out
+++ b/tests/nvme/041.out
@@ -1,6 +1,6 @@
 Running nvme/041
 Test unauthenticated connection (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
+disconnected 0 controller(s)
 Test authenticated connection
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/042.out b/tests/nvme/042.out
index 7d3d21a..e042095 100644
--- a/tests/nvme/042.out
+++ b/tests/nvme/042.out
@@ -1,16 +1,16 @@
 Running nvme/042
 Testing hmac 0
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hmac 1
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hmac 2
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hmac 3
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing key length 32
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing key length 48
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing key length 64
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/043.out b/tests/nvme/043.out
index 7419f91..a4a9a66 100644
--- a/tests/nvme/043.out
+++ b/tests/nvme/043.out
@@ -1,18 +1,18 @@
 Running nvme/043
 Testing hash hmac(sha256)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hash hmac(sha384)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing hash hmac(sha512)
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe2048
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe3072
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe4096
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe6144
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Testing DH group ffdhe8192
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/044.out b/tests/nvme/044.out
index 53fdbe1..58f296d 100644
--- a/tests/nvme/044.out
+++ b/tests/nvme/044.out
@@ -1,10 +1,10 @@
 Running nvme/044
 Test host authentication
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test invalid ctrl authentication (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
+disconnected 0 controller(s)
 Test valid ctrl authentication
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test invalid ctrl key (should fail)
-NQN:blktests-subsystem-1 disconnected 0 controller(s)
+disconnected 0 controller(s)
 Test complete
diff --git a/tests/nvme/045.out b/tests/nvme/045.out
index 48f7e6b..84a69ef 100644
--- a/tests/nvme/045.out
+++ b/tests/nvme/045.out
@@ -8,5 +8,5 @@ Change DH group to ffdhe8192
 Re-authenticate with changed DH group
 Change hash to hmac(sha512)
 Re-authenticate with changed hash
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/048.out b/tests/nvme/048.out
index 7f986ef..c1c0979 100644
--- a/tests/nvme/048.out
+++ b/tests/nvme/048.out
@@ -1,3 +1,3 @@
 Running nvme/048
-NQN:blktests-subsystem-1 disconnected 1 controller(s)
+disconnected 1 controller(s)
 Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4452274..34a144f 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -430,7 +430,8 @@ _nvme_disconnect_ctrl() {
 _nvme_disconnect_subsys() {
 	local subsysnqn="$1"
 
-	nvme disconnect -n "${subsysnqn}"
+	nvme disconnect -n "${subsysnqn}" |& tee -a "$FULL" |
+		grep -o "disconnected.*"
 }
 
 _nvme_connect_subsys() {
-- 
2.41.0


