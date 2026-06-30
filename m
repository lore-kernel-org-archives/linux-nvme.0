Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ACAC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 11:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9A5NXGGr/yhgEOLyl5ER6ye3qWQowY1q06Q/Qn6+0eo=; b=UiPHY+4FCbUIj8JgUd68iSjIaz
	QaO3WUdmO5lnPdiOWVv3yGvcmOJtQiPEADm0L7h0zKSA2MGHmmwkruXu1N8iJFVTZshAI4rTmLM1/
	Itv6qa+DQbxAUMi2KSDC1WIBAshM2VkGk0qQ91Qs1XVkJ8FE1CI9gouNs97FtLGiyAeMV6N+fS9wp
	F1xFx5We0/evlrmxTZitW0FWl6GopYfiU+5Lx/wdKpvjQMq1xORfVue0Qj3352NeLC5a6mo5C2NGZ
	LTyBmBc0PG4m87oWB7Ko4wTrvH5jLt9MmDIlmiTs0cm7CwH/7AOcRO98H0Krqi1KAr+gmqrTC+FbB
	JkEKSzfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWma-0000000GrmT-0wjO;
	Tue, 30 Jun 2026 11:37:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWmY-0000000Grm8-0cLX
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 11:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782819458; x=1814355458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N8c96ji64IbcUKcsQHJGcVRZXkt2NOPadew2JEQaCdE=;
  b=oyfW1n1gCLVD+9ZD9AtWYOqxXD5y+V879fvuoDDWr6LM/unPcBhVD9z7
   YeudrKKWeTd7K+0woxRpmlVP6pbkY6W4YlxM2Lwpa1MhOlQhx6nPRvB9L
   vZz6bbdjbFv6zFyTR5Sw3WAd3a0JJIN/3l8WNI0CTkzHaZkj7CAxFo3y1
   2B86BHlDXr7GZOnXegBuOm07lE2tq1Xq+wj3jIVfJKuIUEa2weWTGXnA3
   V/YAXNC375n7NmdtZs128inY1NXkxPO5dupKepccvAbQYpd0wXUDn12Cy
   qudT38M3LPO+Mp1GjMRUYxrfcAO9kCE9qe3wn7aR+9InrsePnW7YaTp9C
   w==;
X-CSE-ConnectionGUID: F1bx4VQ/TSGmrHIT5FgjFQ==
X-CSE-MsgGUID: xTBRqxI1R4OaxpC8pbsllg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774281600"; 
   d="scan'208";a="148580290"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2026 19:37:36 +0800
X-CSE-ConnectionGUID: iGNTUXiPQhCMuGLVSbj5XA==
X-CSE-MsgGUID: /AA2vjCHS1OhDJVddFLZqw==
IronPort-SDR: 6a43aa6c_TsrbtYzpbFYmO/h+b41FXUjs20BFjHxVCAbodg5/u2TMKBA
 FGI9Od3u5eVYwOx6Bg7pAj4pIgxRkz5BDZPl0bg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2026 04:37:15 -0700
X-CSE-ConnectionGUID: QOzh9OlaStCNSIu1vKb9PQ==
X-CSE-MsgGUID: YLHpVQDWSUa7RfCLO3DOuA==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 30 Jun 2026 04:37:16 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Chao Shi <coshi036@gmail.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/{033,036,037}: skip when the test target namespace has metadata
Date: Tue, 30 Jun 2026 20:37:14 +0900
Message-ID: <20260630113714.848831-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_043738_262284_B5B8EFAB 
X-CRM114-Status: GOOD (  13.65  )
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

The kernel commit c8cdecdb47d3 ("nvme: core: reject invalid LBA data
size from Identify Namespace") in the v7.2-rc1 tag triggered failures of
blktests test cases nvme/033, 036 and 037. The failures are observed
when TEST_DEV specifies a NVMe device with metadata. The commit
introduced a new check in nvme_update_ns_info_block() to reject invalid
LBA data size. After this commit, namespaces with zero LBA data size are
rejected.

According to the comment in nvmet_passthru_override_id_ns() in the
kernel code drivers/nvme/target/passthru.c, "Presently the NVMEoF target
code does not support sending metadata, so we must disable it here". For
that purpose, the function sets the LBA data size to zero for all LBA
format (lbaf) entries with metadata. After the trigger commit, these
entries become invalid for NVMEoF target passthru, then namespaces with
metadata are not visible as block devices through the target setup.

These test cases set up NVMEoF target passthru assuming the namespace
devices are visible, so they cannot find the namespaces and fail.

To avoid the failures, skip the test cases when TEST_DEV has metadata.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/033 | 1 +
 tests/nvme/036 | 1 +
 tests/nvme/037 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/nvme/033 b/tests/nvme/033
index d0581c2..5bb1f45 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -15,6 +15,7 @@ requires() {
 
 device_requires() {
 	_require_test_dev_is_not_nvme_multipath
+	_test_dev_has_no_metadata
 }
 
 set_conditions() {
diff --git a/tests/nvme/036 b/tests/nvme/036
index 11cd5c1..9e6249f 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -15,6 +15,7 @@ requires() {
 
 device_requires() {
 	_require_test_dev_is_not_nvme_multipath
+	_test_dev_has_no_metadata
 }
 
 set_conditions() {
diff --git a/tests/nvme/037 b/tests/nvme/037
index 33a6857..24c895a 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -14,6 +14,7 @@ requires() {
 
 device_requires() {
 	_require_test_dev_is_not_nvme_multipath
+	_test_dev_has_no_metadata
 }
 
 set_conditions() {
-- 
2.54.0


