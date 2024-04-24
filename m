Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E24C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3JIrKOQYvunMvl3HyjL7RlalmxbY0exVgUye5+Wbphk=; b=VN5pjBJv1BoVtMT4Ji4HdpACwe
	ptH5cgrtwcalVcd7n9iWNA0GtLSYlC10zAkdfqKsqctOXi3oCKBmNM+0RY6YYr+fSyF03bMvZ+6ih
	DRg4edO7vgsiMEhYAypVX8w1rqUVocenR2V63D7l/6jqq73IWw6Jf5Y/uwUsRR/TWYypCG83tutOV
	RjZ4bpl+b2ccW04VUWrIKDsnyJWhDSUt4e0Kw+RpJfp1ph0MVDg396N2F0rFdYjPu11b2ekNB3ABD
	k1EdPgeQQfExSJo808Sd2rmH1TCR3AnXK8KFgik9sfPUGfgGrP83Qzp60bAAzRtiTpM4tuxszHwwI
	WgvIOwNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYjV-00000003ShP-3mQN;
	Wed, 24 Apr 2024 09:16:05 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXY5-00000003ByV-1hLd
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945613; x=1745481613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wEETruXenXXhFB3ZAUX4lMN5f17bmvYtqaqOJwjBWaU=;
  b=IjdluCOyKdZ3+U0KzdcA1taN9y7D30xkwVnOtxSE03xFwhnAQv9hiQRN
   /JNio+sPeEVeWh3PIiRe+nXUUZA/doILijVBClfXbIezk/50jiAYXuWPe
   j7NBLc27jkzN6rljfvbpQyqFbc3wVCUSkZtOLoaXocN/jwOSk3fZz+O8j
   D9dx9fGLH5M7Y35ktKZcsdahTO37+IQHuOQKPAB5iAzOTjbYvMEykzR08
   Gr7kWdHgPz+DZW+FqVRSOKr5YeKYyJGh6lURBgKyNcY2/lUBh/vnGGTQo
   IgtDo58LVrI9wsZjdYRUsnSIScXi0e887GO2aEOkLuy/7kbp0CBOHQdWI
   g==;
X-CSE-ConnectionGUID: yyC2KLB9Rd6myy38SoLBpw==
X-CSE-MsgGUID: jKmzi4MuQKiTCiEZDNZUMw==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14140808"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:11 +0800
IronPort-SDR: /ddDdTE0/iS0nKbfJLYqQhjymL28nlaLkdRlGwrCIHJ0Skp1LR5p1rmqHEEMi7hoFJkfIjh5w6
 477EhmjyRLvAApx7zqTKTzU/o7yogG/v+R1Ie37/6TpWYylcdKDqMftWH13VkQW0tLBGM2h4Qj
 ciDk6hRcmpfg33aW8fntUu3Y62NkgRGmQNsCNddNT+WWvYzw0YmZT0ETaMsAxLoPlmMClAPmA/
 jhjmpyNaN99sRL3pE+NI8OzVXuYaVO4wx3ejOjJhrRL/Ac26DHe3r94egnRCpPY6eROtHgKEeK
 dl4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:02:41 -0700
IronPort-SDR: GAVsd/wV3laXdCWYehhnAAsAtGEkkIXAGIRDibzbicOA019uihWuMZDXpGFqAk666VQLCvH6bf
 bImMlth5HdUwcWsvQynflBAwz5IORorxAS6K+ZVS3ep/wonY6WSgDGV3syf5XFLJBHynsCyxVP
 8ibwMfL/VmQfJc/cW2ltEtBXxQ76nRhMEoc3QChCiTcmCFJNMdDnFJ5aAeBeeCfahLXvD28W9m
 KGkHl603Xr+ZMRyBp4wQ4dpe7pEnDl+1Z4tyUupuvu37P3ejOZH7zWIgnwihI2VUUC1EW7x+9Y
 6WM=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:11 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 14/15] nvme/{rc,016,017}: rename nvme_num_iter to NVME_NUM_ITER
Date: Wed, 24 Apr 2024 16:59:54 +0900
Message-ID: <20240424075955.3604997-15-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010013_764803_4F020792 
X-CRM114-Status: GOOD (  11.91  )
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
index c018f7f..8762a56 100644
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


