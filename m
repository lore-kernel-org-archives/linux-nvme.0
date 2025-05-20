Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C246FC3ABDA
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 06:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lxNYfg1g5aKtrML2rHAXwbKY2xZijSBu6zHgR8Y+JYA=; b=4usf+/VP2CalG+k5aQ3ZMLt+yP
	+PcGLUEYXHMQ4HT+QpotOyo7rXYhouq9sF5yyEO9A5WZwo1WWAZPcCMLsj4oUVu1kNNXFkIfMLeZm
	uV9z37vajGb1P/nKjTmPkQbOFNZ5A0OyfabCdggtPAAcG24HXNw87k7fXfeCmNdnoDS6IX3/8jNXr
	kMJtfKnLBm4Ja7FWngTBT1u6XJytczsAn6ofKToafBYjN+oEUfL8AaEKDrcW1AUVhyux4w5Nv2twk
	YJyvORlGLchWz0V+xW88ebxqWLVtQ1RP1Fbluhd0LOuh5VYpUpkey7LYF0QWKxSLl2+ZHIewgXatp
	QM+XWVUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHGJ7-0000000BfrK-1F7z;
	Tue, 20 May 2025 06:18:33 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHGJ1-0000000Bfnx-15sx
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 06:18:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747721907; x=1779257907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FiBMttK158WJrcXtcAn57JlGzNe/1EHR/uRF4eO/4DY=;
  b=Un2MHfwf5jFxGentyZYfc/MxmEm6SFhKiH5iCc0pAa/ZIbwJGvJpBO1z
   VR9igKc4BUCwsWzcOLADs7zjPhSJIida/WvoLOyrpJ7RyweRjbF5I23o2
   Uv29xTw84KNY8G9J45OTzGPE5DSJHVkoVNa1ytEs1XuCAVIBzBcKrR3OW
   qAe6Ui6xQMGY8hPxjVJqI4TuxQSCPscBmAoJ6LQKGqEw9itMCFr2dwp6C
   85PrRDv2KxJ6jD8n+RU9xdh8dSBWYN4lQX5gcsZrr8s7kQSYGNTrPEJ3F
   om5Mj1GBiJFcf31+Z2HWLqlyRcQKUqVh19J8MhHvm4KbSATmapco2XVkH
   w==;
X-CSE-ConnectionGUID: u5iMKg1zSLWMXtyIWkyOMA==
X-CSE-MsgGUID: 2AYRqx8BTmWhfyC1d9ubdQ==
X-IronPort-AV: E=Sophos;i="6.15,302,1739808000"; 
   d="scan'208";a="88516365"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2025 14:18:25 +0800
IronPort-SDR: 682c106d_voqyLKURrCe4iHRWn0rk/Y+PSfBItZjSuPFQNY8/Im8PHBG
 /CTfHsMnFL+aehhZhtNP8E7SvcOOJvzUr8EmGOw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2025 22:17:34 -0700
WDCIronportException: Internal
Received: from 5cg21741nf.ad.shared (HELO shinmob.wdc.com) ([10.224.163.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2025 23:18:24 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] nvme/rc, md/001: check that nvme-cli supports json output format
Date: Tue, 20 May 2025 15:18:19 +0900
Message-ID: <20250520061819.1148033-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
References: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_231827_365222_3485C74C 
X-CRM114-Status: GOOD (  17.05  )
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

When nvme-cli is built on a system without the json-c library, the nvme
command does not support the json output format. Consequently, the
"-o json" option, or in the long form "--output-format=json", of the
nvme command fails. It causes the helper function _nvme_connect_subsys()
to break. This leads to silent failures in many test cases in the nvme
test group as well as the test case md/001.

To inform blktests users this prerequisite, call the helper function
_have_nvme_cli_with_json_support(). As to the nvme test group, do the
check in group_requires() so that the check is done only once for all of
the test cases in the group. If the format is unsupported, the nvme test
group and the test case md/001 are skipped, and the reason to skip is
printed. This change makes the nvme command existence check in
_nvme_requires() redundant, then remove it.

Link: https://lore.kernel.org/linux-nvme/20250519054905.GA6156@lst.de/
Fixes: 444f0df9f0c5 ("nvme: check for controller device in _nvme_connect_subsys()")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/md/001  | 1 +
 tests/nvme/rc | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/md/001 b/tests/md/001
index f1d92c8..ca7c56a 100755
--- a/tests/md/001
+++ b/tests/md/001
@@ -26,6 +26,7 @@ requires() {
 	_have_driver dm-mod
 	_have_driver raid1
 
+	_have_nvme_cli_with_json_support
 	_require_nvme_trtype tcp
 	_have_brd
 }
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d86dc13..9dbd1ce 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -55,7 +55,6 @@ _set_nvmet_blkdev_type() {
 }
 
 _nvme_requires() {
-	_have_program nvme
 	_require_nvme_test_img_size 4m
 	case ${nvme_trtype} in
 	loop)
@@ -123,6 +122,7 @@ group_setup() {
 group_requires() {
 	_have_root
 	_NVMET_TRTYPES_is_valid
+	_have_nvme_cli_with_json_support
 }
 
 group_device_requires() {
-- 
2.49.0


