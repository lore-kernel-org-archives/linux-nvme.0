Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BEEC433E3
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10442075A
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0tldw+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10442075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tvm5GFFoCuKv9LTQ1UmgN2N0tAtLVJdkkGtXYoUVWbA=; b=u0tldw+w1ts+kok7tvVeNdS8k8
	NIarsITDg3C8ohd3YOjtyAqnwtq1r2sgoCdbRaxHsSascNWMrkkjEPWNolWbPtKfrJpB5sbW+Xn4f
	D4OUm2OrU8C1mOljXytNVT+lMJIStzAC2yD2W2Um5sJmpoVf4+EkNbT9cnDOTx+rTM5PhsxJ7IIK0
	srD22XN5U48q978scK5EWjiH8XB4Dj/hpXr6BmH7plc2L5g6Otvy5A0aKB5nSMvcXW/PviGXZvHnl
	quUd7bdaDk3v4Qz6I8jfn0hgSBTzM1Vm1OoZyubyRZqO2f26lYYwAV2dwOezIJGCDppT4sa08F5RV
	H2tB7mVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UHC-0002kJ-7Q; Mon, 03 Aug 2020 06:48:50 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UH9-0002jS-8n
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:48:48 +0000
Received: by mail-wm1-f66.google.com with SMTP id t14so9186713wmi.3
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RvtTADagnnCiX9G36QO3CyWOxm7jHsOMd2MXrfM8ToI=;
 b=OBfA1cw7e3QoGsA2hdfd8dybMgSExYSnLS2xoeKS18daAo/QxjOCl/2KxLw9R7Sydv
 919pLaRZkBBDLlAQilbgto/6kzW2MQAk+J1U2iUmucKDh7V6DLfFwhCtTwhHY+Ea7RbW
 OMMWSKei8vQS1R5uLwPAaqzbU+3hq197yu6vRepKxpBU8geCZxJL67O1jlhHeRkEMghA
 6MplHPMRare/grpnxLhFfSTsT6foTeGd8wMSNflxT1pPALkONNcqLyOMFIcBD54jhBZi
 9vazxAKw2+/fwOdQAjHWy+3oPdFYNk9+2oANaDDAe462jhJ2huM6uI/feHZ/VOWJhelJ
 2HNg==
X-Gm-Message-State: AOAM532uRONpakjr2Puc6ksz2mvxOfbEkWzmPJfL/UQ2N4IzIjoTjX4T
 RCtC9ODmgiWDdqn+a7Wdu08oqXhb
X-Google-Smtp-Source: ABdhPJx52Md5rJgjGZ8CPbneLqtQGF7YKsMVc8jbC6a0uufWqogdjFNCawJWI2Mk8V2WL9FSenNu0w==
X-Received: by 2002:a1c:7e12:: with SMTP id z18mr3330246wmc.188.1596437325717; 
 Sun, 02 Aug 2020 23:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id z6sm23740647wrs.36.2020.08.02.23.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:48:45 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH rfc 1/6] nvme: consolidate nvme requirements based on
 transport type
Date: Sun,  2 Aug 2020 23:48:30 -0700
Message-Id: <20200803064835.67927-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803064835.67927-1-sagi@grimberg.me>
References: <20200803064835.67927-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_024847_361043_76369ED6 
X-CRM114-Status: GOOD (  15.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now, only pci and loop have tests, hence these are
the only ones that are allowed. The user can pass an env
variable nvme_trtype and check for the necessary modules.

This allows prepares us to support other transport types.

Note that test 031 is designed to run only with nvme, hence
it overrides the environment variable to nvme_trtype=pci.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  3 ++-
 tests/nvme/003 |  3 ++-
 tests/nvme/004 |  3 ++-
 tests/nvme/005 |  6 +++---
 tests/nvme/006 |  4 ++--
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  4 ++--
 tests/nvme/009 |  2 +-
 tests/nvme/010 |  4 ++--
 tests/nvme/011 |  4 ++--
 tests/nvme/012 |  5 +++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 |  4 ++--
 tests/nvme/015 |  3 ++-
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  4 ++--
 tests/nvme/019 |  4 ++--
 tests/nvme/020 |  2 +-
 tests/nvme/021 |  4 ++--
 tests/nvme/022 |  4 ++--
 tests/nvme/023 |  4 ++--
 tests/nvme/024 |  4 ++--
 tests/nvme/025 |  4 ++--
 tests/nvme/026 |  4 ++--
 tests/nvme/027 |  4 ++--
 tests/nvme/028 |  4 ++--
 tests/nvme/029 |  4 ++--
 tests/nvme/030 |  5 ++---
 tests/nvme/031 |  5 ++---
 tests/nvme/032 |  4 ++++
 tests/nvme/rc  | 19 +++++++++++++++++++
 32 files changed, 80 insertions(+), 54 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 07b7fdae2d39..aaa5ec4d729a 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -10,7 +10,8 @@
 DESCRIPTION="create many subsystems and test discovery"
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/003 b/tests/nvme/003
index ed0feca3cac7..fd696d9efe2c 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -11,7 +11,8 @@ DESCRIPTION="test if we're sending keep-alives to a discovery controller"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/004 b/tests/nvme/004
index 0debcd9c7049..b841a8d4cd87 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -12,7 +12,8 @@ DESCRIPTION="test nvme and nvmet UUID NS descriptors"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/005 b/tests/nvme/005
index 8c79d234bb1d..df0900b372be 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -11,9 +11,9 @@ DESCRIPTION="reset local loopback target"
 QUICK=1
 
 requires() {
-	_have_modules loop nvme-core nvme-loop nvmet && \
-		_have_module_param_value nvme_core multipath Y && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop && \
+		_have_module_param_value nvme_core multipath Y
 }
 
 test() {
diff --git a/tests/nvme/006 b/tests/nvme/006
index 6c8e18560264..3f47613d52d2 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -10,8 +10,8 @@ DESCRIPTION="create an NVMeOF target with a block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/007 b/tests/nvme/007
index 58f4bf8808a1..0902745a4ab2 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -10,7 +10,7 @@ DESCRIPTION="create an NVMeOF target with a file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 71ff4d962b00..f19de17fefac 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -10,8 +10,8 @@ DESCRIPTION="create an NVMeOF host with a block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/009 b/tests/nvme/009
index 25c7da2ab854..4afbe62864f6 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -10,7 +10,7 @@ DESCRIPTION="create an NVMeOF host with a file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 2ed0f4871a30..53b97484615f 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -10,8 +10,8 @@ DESCRIPTION="run data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_fio && \
-		_have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_fio _have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/011 b/tests/nvme/011
index 974b33745b99..a54583d5c582 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -10,8 +10,8 @@ DESCRIPTION="run data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_fio && _have_configfs && \
-		_have_modules nvme-loop nvmet
+	_nvme_requires
+	_have_fio
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index 27981e903c58..0049c3d8ceb6 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -10,8 +10,9 @@ DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backe
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_program mkfs.xfs && _have_program fio && \
-		_have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_program mkfs.xfs && _have_program fio && \
+		_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/013 b/tests/nvme/013
index af5f3730a2fc..622706ec4088 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -10,8 +10,8 @@ DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_program mkfs.xfs && _have_fio && \
-		_have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_program mkfs.xfs && _have_fio
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index c255d5f12205..9517230253ab 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -10,8 +10,8 @@ DESCRIPTION="flush a NVMeOF block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/015 b/tests/nvme/015
index a8497a2ba400..40b850974b43 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -10,7 +10,8 @@ DESCRIPTION="unit test for NVMe flush for file backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/016 b/tests/nvme/016
index f1e383cb441a..e1bad2f81461 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -9,7 +9,7 @@
 DESCRIPTION="create/delete many NVMeOF block device-backed ns and test discovery"
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/017 b/tests/nvme/017
index 6787b5c754ba..2e6d649f9b65 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -9,7 +9,7 @@
 DESCRIPTION="create/delete many file-ns and test discovery"
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/018 b/tests/nvme/018
index 67d89a6f0b24..e39613709c90 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -11,8 +11,8 @@ DESCRIPTION="unit test NVMe-oF out of range access on a file backend"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index a8b0204ec0eb..86a2a2945b35 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe DSM Discard command on NVMeOF block-device ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/020 b/tests/nvme/020
index b480ee1b92d0..ccadec6a5822 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -10,7 +10,7 @@ DESCRIPTION="test NVMe DSM Discard command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/021 b/tests/nvme/021
index bbee54d16ff1..bbcb9d56a350 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe list command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/022 b/tests/nvme/022
index 9ba07c1cc50f..452e7b3d196c 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe reset command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index ed2a5ad7653f..2714571d16d9 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe smart-log command on NVMeOF block-device ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/024 b/tests/nvme/024
index 538580947c5c..1f87bd19ec69 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe smart-log command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/025 b/tests/nvme/025
index 0039fefa5007..1b9e33351f61 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe effects-log command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/026 b/tests/nvme/026
index 7e89d840529c..21a265a630ba 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe ns-descs command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/027 b/tests/nvme/027
index 4d293beb8b47..d7d33796e122 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe ns-rescan command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/028 b/tests/nvme/028
index 1280107ed5df..1643857437e8 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe list-subsys command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/029 b/tests/nvme/029
index 65eb40031888..9f437285d085 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -11,8 +11,8 @@ DESCRIPTION="test userspace IO via nvme-cli read/write interface"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test_user_io()
diff --git a/tests/nvme/030 b/tests/nvme/030
index 94020f47411e..7156cad7b657 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -10,9 +10,8 @@ DESCRIPTION="ensure the discovery generation counter is updated appropriately"
 QUICK=1
 
 requires() {
-	_have_program nvme &&
-	_have_modules loop nvme-loop nvmet &&
-	_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 892f20bad9a7..7e7ee7327e62 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -18,9 +18,8 @@ DESCRIPTION="test deletion of NVMeOF controllers immediately after setup"
 QUICK=1
 
 requires() {
-	_have_program nvme &&
-	_have_modules loop nvme-loop nvmet &&
-	_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/032 b/tests/nvme/032
index 0d0d53b325e6..017d4a339971 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -11,11 +11,15 @@
 
 . tests/nvme/rc
 
+#restrict test to nvme-pci only
+nvme_trtype=pci
+
 DESCRIPTION="test nvme pci adapter rescan/reset/remove during I/O"
 QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
+	_nvme_requires
 	_have_fio
 }
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6ffa971b4308..320aa4b2b475 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -6,6 +6,25 @@
 
 . common/rc
 
+nvme_trtype=${nvme_trtype:-"loop"}
+
+_nvme_requires() {
+	_have_program nvme
+	case ${nvme_trtype} in
+	loop)
+		_have_modules nvmet nvme-core nvme-loop
+		_have_configfs
+		;;
+	pci)
+		_have_modules nvme nvme-core
+		;;
+	*)
+		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
+		return 1
+	esac
+	return 0
+}
+
 group_requires() {
 	_have_root
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
