Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27D4C7EE23
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 04:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vi7eNChRavz0R31vl4WWHbX9K38qPddxMAM6g8r25hQ=; b=Bo4fPgEAd30cdzHhljQXw5nPUo
	TPNxMLyOLljLwdDwEixNDpIRa4e26nBYu8gWRC/uih10MrR8OjDFPwrSw2duBWSiizotOn/u/c78Y
	MVa6qgUmesldCa1ZAVYnu0iHo2Wfr/xG//xELsm3RS/F8xHNsAAKrTjcyv3rt5ZFfB3a+s7HAw86z
	SD4LMTyx8KSF3RV1JkhVa6svdmfDpLe4QSJ6pREWP3rMMbZhziwfhp4ScYpQW+/Th3NtQMCrYIKC0
	HvIetKrBwJxNebA7DEl2nuUZR/jsd8NyR19w43rbDOjqUj5MMgnEHeEViVcq9SJtbRFSWYwUO1w4k
	5g0Pwz4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2PXS-0012iU-1m;
	Fri, 26 May 2023 04:58:54 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2PXO-0012fp-2q
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 04:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685077130; x=1716613130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKtGWlSuxI8HIrrsVoZWoKYq9tElwtCzY8UQvSZ/iSc=;
  b=InXDXOA4VEmNWfe2fO0FhtVUY95ACLFU9yWEg0HXtw/I4mIH8XYGzLiN
   wEOWav1rzergT44lEhCM2DJD9KBhwl34fakAmR/xCcELQTsZ6w4/yaIRh
   vEQpheNjYli4tRqpbvAthJsUXBZrUODV/CUhNp76auy2s5NodZTxZQpob
   /4cBTk4ZHsZBPn6T6KcAsyJyeEooRzSMLcQU3bbFQ2OIKuslNLqsFs9Zv
   hh8UXpEG/ZS08kutTyaqrczsD16nK1tD70AILA43dtuU2o10HtXykhwS+
   +kq4pP8+s2lKKlOtoePi6zVfErUCI5I5OupU9gUr+J+bIWG4k5G50+gCR
   g==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231705019"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:58:46 +0800
IronPort-SDR: ue+ZmV4+wA71LaMJWBXyI3A/5j/sc6V7rfPmKJU/l/VzUAUuPZecjR5TBuY5XSd0dLZdliwHyd
 VNiXdcZXmdqutIm+Bgu78saF9NZwbSIBcI3kCD8jUTWnJyiEZfNG3nqc8LofnrJlVaYmJ3z9a5
 vkAvHjz/eSdXXALlc2O2XOWo42/AuPpxC04mr5GCdgMoQDhJK990DMDOEKi2kvBu0umEZM4oic
 3IBaMMtUFzx+fnegI/CH7hCd1SW8PJANNC7fzoyQvL3SjHwV2QiFq+FR8dLwCpMPDokrA7b34I
 wec=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2023 21:08:03 -0700
IronPort-SDR: tEwFH3on0LDF0UbeTZ1YEde3lVMA0l34fAG8I10tuKv7VO0ruFeIp+PFA7Cm3NL2Sz+aUcSl7e
 7ZIq+M5g4YWB/gnTsJjVvfS4zJr6ADc/67ADB6Pp5/lHvDp8+zK4TfwDRSDQDOQCafF2Vk5grA
 SNuUj3fkLgI9NGsJGPwioyH2zQf18jBdUazrZpCye84moLUj7X6ue7tZW7FQu44mdo3jo+/8z6
 w9qLIjB73GSdaDat5inTGfnLIcfGyx473Bd0fjwOHCN+YhuRBIGZpKzjUTOAPy2psQ12sH7vEY
 2pw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 May 2023 21:58:45 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] block/011: skip when mounted block devices are affected
Date: Fri, 26 May 2023 13:58:42 +0900
Message-Id: <20230526045843.168739-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
References: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_215851_003497_BF180489 
X-CRM114-Status: GOOD (  12.06  )
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

The test case disables PCI device of the test target block device. When
the PCI device has other block devices mounted, those block devices are
disabled also. If the mounted device is the system disk, the test screws
up the system. To avoid such dangerous operation, check if the target
PCI device has mounted block devices. In that case, skip the test.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/011 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/block/011 b/tests/block/011
index 4f331b4..0699936 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -10,12 +10,29 @@ DESCRIPTION="disable PCI device while doing I/O"
 TIMED=1
 CAN_BE_ZONED=1
 
+pci_dev_mounted() {
+	local d dev p pdev
+
+	pdev="$(_get_pci_dev_from_blkdev)"
+	for d in /sys/block/*; do
+		dev=${d##*/}
+		p=$(_get_pci_from_dev_sysfs "$d")
+		[[ $p != "$pdev" ]] && continue
+		grep -qe "/dev/$dev" /proc/mounts && return 0
+	done
+	return 1
+}
+
 requires() {
 	_have_fio && _have_program setpci
 }
 
 device_requires() {
 	_require_test_dev_is_pci
+	if pci_dev_mounted; then
+		SKIP_REASONS+=("mounted block device exists on test target PCI device")
+		return 1
+	fi
 }
 
 test_device() {
-- 
2.40.1


