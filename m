Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C45C2BB84
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D85206CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gzi6GtBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D85206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8erOmqVlVtb+XHfQ1wVYr4j+VTpxrC5ANq4Nbm/VSn4=; b=Gzi6GtBwDXgCkXPcePJZOJYOg
	R0v3VscSF+OEvdc5Uc5MKknCY+wv/eOpqxuy3ECVEP/J9g3snLr502L2dUAODK7VYdGVHutgxuT8I
	SlW4V1P2ALeAZ3Hs4jQ4FZV2NBHwuQ8L2u4mca2L6beDnguxwY+bdGBuClO5FWF6oLirzdBVySx5S
	YphVE13MC4EtCFYWILjqhOY6yU2KMgWglychoyQpVpML0I3uHS7gcbw8g0joecokOrMZBjDL5O2WA
	T+SGIpUt2gtwITWkt2xRE2VM6yZerBMNnrkTPiMSLqkh+e9vRUEU5Y7Irj558Rn8RawaTE1rsgoFz
	5p7WJ/gMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDwkq-0007et-EJ; Thu, 03 Sep 2020 21:26:48 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDwkn-0007dt-TP
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 21:26:47 +0000
Received: by mail-wm1-f66.google.com with SMTP id b79so4231274wmb.4
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 14:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7ub0Y3FnpAu3+m+90OvoGZcXT6a2cMjL2UkvmPpWQ8U=;
 b=NNBbDzICnOD71KGSWARXSHgNd4RnosQZutgELw9hH0GavHwlmWwTahyLD0GG/lY8Eo
 qg3eZKuTP3HjU/BZVTWInsJM79yrAeKG6v4kZvwBoABHESbDwcfJIOMMegdjfpLr+ErV
 EMFG4vqi9dXksEjsBRrKzlH7vtEew0/ZjqHlVKoRWhkhHifHFNzdiH/E9jLIX4KhGzD5
 8nkeN1M48bdm45rVqysb4BzYvJk7Evc9AOg+cvkfJfwSQubh7sklw6oZ6rCSvHuRB0Qj
 GwInV64vFvLUp3ZO9NecZBeuaNg46V4ehxySoujn2iO5J5/rL/y3pvwALTvJzvf7EVku
 EAcA==
X-Gm-Message-State: AOAM532+FPECsfcOYlHnUWc38LkB1rWC2BPc0g6kE47o/jcRHan55XUB
 UGKeVMzLpMn/lBIDbksYS6ZkmD+33ZZMJw==
X-Google-Smtp-Source: ABdhPJyOfnjPgoyRhzBwGBGRrHUMskIjh4xkFl8OoRmT7GBp8o449czsoZjaZakOblkzdJ1six3PmA==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr4302271wmi.19.1599168404799; 
 Thu, 03 Sep 2020 14:26:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:26:44 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v6 1/7] nvme: consolidate nvme requirements based on transport
 type
Date: Thu,  3 Sep 2020 14:26:28 -0700
Message-Id: <20200903212634.503227-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_172645_977465_9FAB1609 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
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
index 325f2b656613..df0900b372be 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -11,9 +11,9 @@ DESCRIPTION="reset local loopback target"
 QUICK=1
 
 requires() {
-	_have_modules loop nvme-core nvme-loop nvmet && \
-		_have_module_param_value nvme_core multipath Y && \
-		_have_configfs && _have_program nvme
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
