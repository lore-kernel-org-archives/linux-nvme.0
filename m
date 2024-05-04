Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD92CC4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PvbVjV8jgBQJIdQKdtdfA+jp75nEOe25zwnVdGYZno8=; b=rhGNWUD2ULs9qisnyQbqlqi2vs
	QMPkdYRNUsSWxhZJ2vXgAG5CFEhv5DkJcB6Q+h9+pj1aZsIV6yQBMPosC1USEd1bV9rgeH13SCe73
	526WHie9mXATjTsCBMZALHH56uQDGaBmx3Khg9V4XXZxbV0tLzyTeITxVDLztE0Yv3VlaGUwy3xum
	J2eQwy5mTuaKbcCG2sw0Suc3O4KJN5tgQqR2nyiKIP16oXJiwpC8MSm0RD+Rf4oJy2E2RmYW9dgMK
	iy4rY0rapDEGQusMs2bNTRGE+hpCxPX/0XDuDvSv2BRZpUIn6gcNurXOPhDoDFAd+kYkzOwvHbo2c
	E9GUKhdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AYv-00000001ZlA-1lwR;
	Sat, 04 May 2024 08:16:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AY2-00000001YrU-0y8W
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810509; x=1746346509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P5q9gL3DmOdRu3GNWoTEQhagzOV4QzL8Rtx94737wF0=;
  b=fZftGRPzU5roLuKA/dIIEKcqTE8LRQakN3TpYPNw+l6lXUbP8W7aujKv
   8/uErO96/4IBWmLshtvwqA1vAm71LPKjvoU5Jpy0ouEUxZd/vCOLecjVO
   A1o6meoVuMcEXK1XpMAk50ujdv4ctc0HyL3jwqi30NekG0tIzTytahS4+
   X8Ag5uNw3AU9QKAkJ+gfZ1Kb58okN3ZHfhINCbGaJyqBycuwZiWUpk4i7
   2rHNZlCXA/x1h0J1kzw4AhjRfWsl9CPA2e8pOmJkq2TkoTwtNfnXHsAFX
   jmafBN8F8WeQ4SNW+hkWeTPAyCOXBv5E7bAWAPB8G9hT6ozC9dtgDdSl4
   A==;
X-CSE-ConnectionGUID: rW1dyQB+Tcu0ip+sg6LDuw==
X-CSE-MsgGUID: UJGyJ4o+QWC3teJqbVWbNA==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540350"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:09 +0800
IronPort-SDR: 6xRWs7YZPep8nYHD9MTcehAOJgUczcfwzyevtycBkT8Uu4+Dm6FQ0Di/ly3+2OddWFgQEo9hvx
 KNN/JNSzxnVnqTHc2HBeoz33zeCBb350xdRzJ+Vpq3QiSUMWPiYraqdawq6maSntFVMGO6QlSl
 L02LznsKMknqvlzSEjTXS9mcnUBxdj5HNKg/hbDnk0TG9gw+N2m1ykc/D0D5eX4gzY6ykl6fPE
 jZywCMRm7IIqyiDE4x+22DLs6lg7ED903/eLv5qe79yv9dRIDsZOKZDk3sCsNncz3f56gbRmu/
 bhM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:07 -0700
IronPort-SDR: K+FpRuSxzQ8RzKwVSAclukCTJYrI0z4fPzXf4jwEtUhChsaPqMqqN8h7Sinkg6eHUfNX8qnYLc
 OtlIH7g9gXMd7G2798ifjf6PhCMpqzkzAZAkJLPJSjixuRN1+sszHmCcqOadMm0Seij2n60qZr
 zrTFpRFGcEwmNy080yGkrffv6v7ZSNb4RFoAjdr1gscxvvgewSg1QofUo3je/i2brsoq6QPNL+
 Vxz+MSSHabNXRRFFFvktVUGYTWEoGnT9CmRsMeYy8JGUjHJTIM3Aox87QxX0OqFwl9i7eqU5EU
 dqk=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 16/17] nvme/{rc,016,017}: rename nvme_num_iter to NVME_NUM_ITER
Date: Sat,  4 May 2024 17:14:47 +0900
Message-ID: <20240504081448.1107562-17-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011510_649064_988D7819 
X-CRM114-Status: GOOD (  13.05  )
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

To follow uppercase letter guide of environment variables, rename
nvme_num_iter to NVME_NUM_ITER.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 5 +++--
 tests/nvme/016                 | 2 +-
 tests/nvme/017                 | 2 +-
 tests/nvme/rc                  | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 736ab48..7bd0885 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -117,8 +117,9 @@ The NVMe tests can be additionally parameterized via environment variables.
   Run the tests with given image size in bytes. 'm', 'M', 'g' and 'G' postfix
   are supported. This parameter had an old name 'nvme_img_size'. The old name
   is still usable, but not recommended.
-- nvme_num_iter: 1000 (default)
-  The number of iterations a test should do.
+- NVME_NUM_ITER: 1000 (default)
+  The number of iterations a test should do. This parameter had an old name
+  'nvme_num_iter'. The old name is still usable, but not recommended.
 
 ### Running nvme-rdma and SRP tests
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index a65cffd..d1fdb35 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -23,7 +23,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	local iterations="${nvme_num_iter}"
+	local iterations="${NVME_NUM_ITER}"
 	local loop_dev
 
 	loop_dev="$(losetup -f)"
diff --git a/tests/nvme/017 b/tests/nvme/017
index 4f14471..114be60 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -23,7 +23,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	local iterations="${nvme_num_iter}"
+	local iterations="${NVME_NUM_ITER}"
 
 	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index ef7b966..6fc0020 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -20,7 +20,7 @@ export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
-nvme_num_iter=${nvme_num_iter:-"1000"}
+_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
-- 
2.44.0


