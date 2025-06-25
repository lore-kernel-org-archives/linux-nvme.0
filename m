Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF934C7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXXWIY89cmgTXxqNg0t5+/RhLh4DC+XXvvBEAOxiv6g=; b=KYvcvadkqIOwFkgrZoEVFrcI/f
	MyEqsmHDXyD+l58+JQv6eucnFqXUS9f2giZIdL2puWjESVr/8nt38ZLLUVTjDNYQVChZoGkb7Cdxf
	MzRAY1hlOWSPGqart4yJB1dGy9VmUuYzCaU5NRQOZ5lB/EHOrn9jeNLWph705HJczhRjnjPzXJHqY
	l2QPKpNK2DjhxOIiiNxL+RToNDILuPvf365tqw7jOaG+e5gAimz7C20LWu3J901bIoELwEEOsQi0A
	Vb08CcDWXdlxsE4Bd/KdkEa4bpPpFNq3NVsjulPAXuiejLC9aZhDx/1l2Xcs0IsIfhEZW5HS3nA32
	I0vWJEpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT0l-00000009HzG-3R7g;
	Wed, 25 Jun 2025 16:30:11 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOYw-00000008Wje-0Or2
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 11:45:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851910; x=1782387910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXwdL5wUZAqT//wh8UKlLgeP78FHgRETbz3LAYMACW4=;
  b=IQciUORpinxF0A2b9RO8BvgmIEOPF59x3zIsXAMP9I9gIP53Lpg9uje2
   gQo+FmU4QuBUU1UMoTcRU489vvpVZV2zkYQceG4CCNsXmoAQTbpryIH06
   Lr1qo6ZUXOYn3wA0XUE9Q7EnFL5ljhz4xaLB12S0KBvoizm0nLGwOJ85O
   /EvxPCd+5vg9VRNAbeZQdtzngOhf4HKBnOCv6B9JIbjaUDl9agF23IaWK
   4foptv8pKfxjsDNMCuQqkLd4ddrbF60UGHpMdeRLhHIkKw/M9g0Io/4dj
   ywMqpQ4wnUSwDXZRq21n0QJf6uY/RwPDrUer5H+573I4HRa+A7+cteK1S
   w==;
X-CSE-ConnectionGUID: BBI9AOmLTv6Fbf07X8pOtQ==
X-CSE-MsgGUID: geks31hLRJyHt+S4avTQ/Q==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85954401"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:45:08 +0800
IronPort-SDR: 685bd2c4_Nwx50vTrf4ejRJynDhe/C5n8wwhyAZi5RgNeAxxtqGzeJiI
 1KtB9Aqa4BDOmLW/duv9tkOs4bH22Ea4oi2BeZw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2025 03:43:16 -0700
WDCIronportException: Internal
Received: from 5cg2075g47.ad.shared (HELO shinmob.wdc.com) ([10.224.173.209])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2025 04:45:07 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] nvme/049: add fio md_per_io_size option
Date: Wed, 25 Jun 2025 20:45:05 +0900
Message-ID: <20250625114505.532610-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
References: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_044510_165130_1B07A3C8 
X-CRM114-Status: GOOD (  10.03  )
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

When TEST_DEV namespace has a format with metadata, fio workloads with
io_uring_cmd engine errors out with the message "md_per_io_size should
be at least 64 bytes". To avoid the failure, add the option
--md_per_io_size to the fio workloads.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>
---
 tests/nvme/049 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/nvme/049 b/tests/nvme/049
index 7304d66..70a6d11 100755
--- a/tests/nvme/049
+++ b/tests/nvme/049
@@ -15,6 +15,15 @@ requires() {
 	_have_fio_ver 3 33
 }
 
+metadata_bytes_per_4k_io() {
+	local phys_bs md_bytes
+
+	phys_bs=$(<"${TEST_DEV_SYSFS}"/queue/physical_block_size)
+	md_bytes=$(<"${TEST_DEV_SYSFS}"/metadata_bytes)
+
+	echo $((4096 * md_bytes / phys_bs))
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
@@ -23,6 +32,7 @@ test_device() {
 	local target_size=4096
 	local common_args=()
 	local fio_output
+	local md_io_bytes
 
 	test_dev_bs=$(_min_io "$ngdev")
 	common_args=(
@@ -39,6 +49,9 @@ test_device() {
 		--runtime=2
 	)
 
+	md_io_bytes=$(metadata_bytes_per_4k_io)
+	((md_io_bytes)) && common_args+=(--md_per_io_size="${md_io_bytes}")
+
 	((test_dev_bs > target_size)) && target_size=$test_dev_bs
 
 	# check security permission
-- 
2.49.0


