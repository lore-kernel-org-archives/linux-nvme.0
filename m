Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74655C7115C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fKALQCDg/r5dFqKl+ez8IaEtrfZzwQ75SGs13UD92Ig=; b=egrz1IPlwaua7/HJk9vSJqNWpG
	YbBaiBW/Zb6VMVaeZm7cJNJVEMbdxbsiSDpbR2QqBUlFgdexKz5WrZYt1a1HZveu0+rouLhvE6dzz
	ObWkXz+X5WA0p70PfDJjUO4Dr9cod6hE0TRHRAJIQFqGXhFDvBstUH/d68kXOuAi1sS/HW5McpAzr
	cc2ngwSmZIl8pJoiniIhuNAVtIo2HRc3G7K78yK8vwcGmmKQRutmEFW8R4njxPvjb9/8aw+mnFsEY
	F+Ppt/KPq2jMYsHEghFzt9QPd09dlp9hAVNuc1xXKPnijxmsRcLC7lTUnCFIaiQn6yyZn6CNfRF/m
	anC5FZRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT0k-00000009HvZ-1qxH;
	Wed, 25 Jun 2025 16:30:10 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOYu-00000008Wjh-3bKD
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 11:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851908; x=1782387908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K5K8ZEZmhAzuvLd2wh8Qk1d7AMXq5iNFkaxq4bqNNnE=;
  b=okN97f4HQt5DTbfRWDdWnqoxx3BkTyC02Z3ql6aKpfSrTGuvsEwAfreI
   Y79s+AweBgqnH09cfsQaQaTyqJpl6lvNCmipBNOS3EtKpvbrFQD7ngAef
   3DNzqlpryZe7JCh5ukPLSKXlAJhvk4Pn3icxBUPFU94bPrBNHwIyJ9kJI
   +YmxP2FcuL8CkKKiVL/DQwPuMvwHLAAoTRgzlV3gwAB+7n9gcOCn0Nl01
   lhj8kOei+go6Dyg63YDt2ddgWi7gWhTbFuno8laCbatlosSCqRzPydA7T
   Ze4AVCNKjleTnep4Rkm+qPSyX/v564NobGSqHXpyu2VNn4LCa6IVTFZxC
   g==;
X-CSE-ConnectionGUID: K+ppdTY+RK+e43p2phFQHA==
X-CSE-MsgGUID: 5AUp6v7iSZaQRot6M+cLng==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85954400"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:45:07 +0800
IronPort-SDR: 685bd2c3_qzjlO+vLP44oN62nkJ+BYxK0i33OsWNSfpm3nYPYcfeuzLy
 2NPB28h2fQpJPHWSac6+T9xiWf1PLDmR7tFxDnw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2025 03:43:15 -0700
WDCIronportException: Internal
Received: from 5cg2075g47.ad.shared (HELO shinmob.wdc.com) ([10.224.173.209])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2025 04:45:06 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] nvme/{034,035}: skip when the test target namespace has metadata
Date: Wed, 25 Jun 2025 20:45:04 +0900
Message-ID: <20250625114505.532610-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
References: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_044508_909525_8FDD842F 
X-CRM114-Status: GOOD (  13.48  )
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

According to the comment in nvmet_passthru_override_id_ns() in the
kernel code drivers/nvme/target/passthru.c, "Presently the NVMEof target
code does not support sending metadata, so we must disable it here".
Because of this limitation, when TEST_DEV namespace has the format with
metadata, the passthru target namespaces created in the test cases
nvme/034 and nvme/035 have zero capacity. This makes I/Os fail and the
test cases fail.

To avoid the failures, skip the test cases when TEST_DEV has metadata.
For that purpose, introduce the function _test_dev_has_no_metadata(),
which checks the sysfs attribute metadata_bytes.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/034 | 1 +
 tests/nvme/035 | 1 +
 tests/nvme/rc  | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/tests/nvme/034 b/tests/nvme/034
index a4c5e97..aa6fda3 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -16,6 +16,7 @@ requires() {
 
 device_requires() {
 	_require_test_dev_is_not_nvme_multipath
+	_test_dev_has_no_metadata
 }
 
 set_conditions() {
diff --git a/tests/nvme/035 b/tests/nvme/035
index 71039ad..9eef0d7 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -20,6 +20,7 @@ device_requires() {
 	_require_test_dev_is_not_nvme_multipath
 	_require_test_dev_size "${NVME_IMG_SIZE}"
 	_test_dev_suits_xfs
+	_test_dev_has_no_metadata
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 215a10a..bca28ba 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -161,6 +161,14 @@ _test_dev_has_metadata() {
 	return 0
 }
 
+_test_dev_has_no_metadata() {
+	if (( $(<"${TEST_DEV_SYSFS}/metadata_bytes") )); then
+		SKIP_REASONS+=("$TEST_DEV has metadata")
+		return 1
+	fi
+	return 0
+}
+
 _test_dev_disables_extended_lba() {
 	local flbas
 
-- 
2.49.0


