Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055F9C71135
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f4/Ige/sf8ALdrOOrc8s1o+9vQGE4NnkodKIyazMvUQ=; b=MTSVEWv12FG5WOzvfUn2Qs5Fiq
	Hdr7ghSgldfwwXznEmVJlGAaMr2yZ37YNEarwRRshZJaJwZ9n30l7kMTNCfYhAEh7MBI6pWDJ62/Q
	V9PHq2OwCBHSmnckbYAOmO+vwLkG5pgh5Kj41WLdUNgO0WfK95p643BSKNXAzG0K4Ns5nVGMHSskh
	yMonREkSGJl4VWf/J0MYMsHy5vqS40PbldObzuV4aflY0n6mN2SvqyhNsDA2z8Kyb3a8lBDNjZYOW
	YAR6ujtGgu2Tglj63rQouBNM+yYH1rMujKURn+suC/Cix//DUIHKAWokYneTK9069H85v3c2sIh/U
	niejYnfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR05Q-00000003DCY-2VQ2;
	Mon, 16 Jun 2025 03:00:40 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQzFr-00000003875-42P8
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 02:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750039643; x=1781575643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6lQZzUKKZqWZs1iFHkbKcVSvNP2oOVBrjY3NE7Z1hSs=;
  b=JVWoLZzLgF/8hNVWP4ubuPhsoCbeboI832a7UggvnYNFQllouu0voTHr
   vXHx+fOqmWUxbCLZGYmZyH8vWMaLNBr4m50Z4cdasnx5/TknYjqMbjmdj
   RkxoQLOzaKa9wB87SG/1rcAH2T9m5AewBZ6W6BiASgUIdDbkH5WHXQ4T+
   GhNZkqQ2rFOmT6qgdLEjOklB+DY0y1UkqiHRL8KLux+4MHJa7yS/U5uNu
   x+Pnpw2LGxXSfJt1FttnMIZQwiVKFxxR3BZVpSti/5MBpo3ei9/jhmAk+
   IeZZYDb6SWFjZsFvq5LCAU1L8/z1hQn/VlZi8t8Myao3ndojg3tGHCp9S
   g==;
X-CSE-ConnectionGUID: tpfPg2JDTHK3ZVF2G2p3fA==
X-CSE-MsgGUID: MKR/Y8IsQEOQU7RnbYPNSQ==
X-IronPort-AV: E=Sophos;i="6.16,240,1744041600"; 
   d="scan'208";a="84623412"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2025 10:07:19 +0800
IronPort-SDR: 684f6de6_6cVdvpMAGRNdWJACt/fFLVYCQ3+1P9sVOV6J2mqWxeA8v/G
 ReW5eRtHuOwkDgCIjm3fxpcbYWC058xexJ2jWEg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2025 18:05:43 -0700
WDCIronportException: Internal
Received: from wdap-do3irrikgj.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.172])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jun 2025 19:07:18 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@meta.com>,
	Keith Busch <kbusch@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] nvme/rc: introduce helper functions to check namespace metadata
Date: Mon, 16 Jun 2025 11:07:15 +0900
Message-ID: <20250616020716.2789576-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
References: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250615_190724_011273_98EC08F9 
X-CRM114-Status: GOOD (  11.45  )
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

To confirm that the TEST_DEV namespace has metadata area for each LBA or
not, introduce the helper function _test_dev_has_metadata(), which
checks the sysfs attribute metadata_bytes.

Also, to confirm that the metadata is not used as the extended LBA,
introduce the helper function _test_dev_disables_extended_lba(), which
checks the NVME_NS_FLBAS_META_EXT flag in the flbas field.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9dbd1ce..215a10a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -153,6 +153,29 @@ _require_test_dev_is_not_nvme_multipath() {
 	return 0
 }
 
+_test_dev_has_metadata() {
+	if (( ! $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
+		SKIP_REASONS+=("$TEST_DEV does not have metadata")
+		return 1
+	fi
+	return 0
+}
+
+_test_dev_disables_extended_lba() {
+	local flbas
+
+	if ! flbas=$(nvme id-ns "$TEST_DEV" | grep flbas | \
+			     sed --quiet 's/.*: \(.*\)/\1/p'); then
+		SKIP_REASONS+=("$TEST_DEV does not have namespace flbas field")
+		return 1
+	fi
+	if (( flbas & 0x10 )); then
+		SKIP_REASONS+=("$TEST_DEV enables NVME_NS_FLBAS_META_EXT")
+		return 1
+	fi
+	return 0
+}
+
 _require_nvme_test_img_size() {
 	local require_sz_mb
 	local nvme_img_size_mb
-- 
2.49.0


