Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683EC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA9B206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dqF2o4JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA9B206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8/y4u4nVZwph7wGCFPsOsJpHmurkA6E6SXlgu62BgqE=; b=dqF2o4JCJJPD6LER8LppZg5Xh
	3CfVvsTccMLYIAemgqYVhb3UJHPuD0Vluapsq5uSqagIFJe5JCrQpQr0104d5/mDtEWBTyfdXFLqS
	K0kEom9HYOcAIIi5oj/1e3jR8119eOprlfLA9VGYdJVI5BfnITDVaj3XrYoBPCz9CR+ICu/OqZnD0
	Ppt1opeFsbnf7L4Jt8sy/CiTzZWG/W2hlRMpTwwRR9+/BzK1+mgo/LsNHkcuF3dNhF7CUVDrNJ8qL
	HHg5yzAt3XaPPHcgT7RkzT7le/Uk5MzqKnEXsEV+JiE1NJmmxmHzxIDTU2vCmfKBhM3wQmI+P1wwc
	w8CqkbLtw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bOb-0005JR-B1; Tue, 11 Aug 2020 21:01:21 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bOV-0005Gm-At
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 21:01:16 +0000
Received: by mail-pl1-f194.google.com with SMTP id z20so111877plo.6
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 14:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wu2ghV8/u7ubjX0NqevskKUcN8L5GxZ12zYaXNIR/rs=;
 b=B9deEkd3OtfDKuM1pqzeUsGdIJyyABnQlxZvYXZ0CNc1HllNMDnnVG8nMvc7Wtachl
 hG77p5/o2BMUcEFmEMWx00zYOT1CKCBdVRZO3tOr5rEuK+ZleOPVT1Mcw/4Sh1Q7mhMT
 Jr2IY2UJtJLjzGlk8Z2NU2wBtGKkwYSF8g/TNZX0Dgg71ncN9WySNX80oThFtklTJCiy
 YM2VNrMclKi/HKwGCbN91rHLWWBZC+/opud4tYC76J2GlT677Jn9MXB9H/jXhUIDjDOV
 rtm1aMZGTIcNCNESzU5nfZ0yRXQlML6/tnXjzM8ucshG0xNL2aNw6XRduqlMRpZ0/HnM
 Yqpw==
X-Gm-Message-State: AOAM533VWycE3plJar1noCGydh7sO7bVO2057piIDiaOLJ+AQGhgbbhw
 I79h85XuwKvPYdwEf4kwdBNsRUDswus=
X-Google-Smtp-Source: ABdhPJy1A2fkE0DgHkvpCpLysoGsL3aivBYSh6UivpDO1nkvX8tpZ9hIVvUemIK/Y7u8Y4ZfzNT5nA==
X-Received: by 2002:a17:90a:e94c:: with SMTP id
 kp12mr2643131pjb.115.1597179673316; 
 Tue, 11 Aug 2020 14:01:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:01:12 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v3 4/7] tests/nvme: restrict tests to specific transports
Date: Tue, 11 Aug 2020 14:00:59 -0700
Message-Id: <20200811210102.194287-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
References: <20200811210102.194287-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_170115_404388_F2D3080A 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Protect against running tests with the wrong transport type. Most tests
cannot have nvme_trtype=nvme and discovery tests expect the $trtype to
be written and verified in the .out file. Adding a couple of helpers
to restrict the transport types in tests.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  1 +
 tests/nvme/003 |  1 +
 tests/nvme/004 |  1 +
 tests/nvme/005 |  1 +
 tests/nvme/006 |  1 +
 tests/nvme/007 |  1 +
 tests/nvme/008 |  1 +
 tests/nvme/009 |  1 +
 tests/nvme/010 |  1 +
 tests/nvme/011 |  1 +
 tests/nvme/012 |  1 +
 tests/nvme/013 |  1 +
 tests/nvme/014 |  1 +
 tests/nvme/015 |  1 +
 tests/nvme/016 |  1 +
 tests/nvme/017 |  1 +
 tests/nvme/018 |  1 +
 tests/nvme/019 |  1 +
 tests/nvme/020 |  1 +
 tests/nvme/021 |  1 +
 tests/nvme/022 |  1 +
 tests/nvme/023 |  1 +
 tests/nvme/024 |  1 +
 tests/nvme/025 |  1 +
 tests/nvme/026 |  1 +
 tests/nvme/027 |  1 +
 tests/nvme/028 |  1 +
 tests/nvme/029 |  1 +
 tests/nvme/030 |  1 +
 tests/nvme/031 |  1 +
 tests/nvme/rc  | 16 ++++++++++++++++
 31 files changed, 46 insertions(+)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 8540623497c7..8cfcb75e5142 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -12,6 +12,7 @@ DESCRIPTION="create many subsystems and test discovery"
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/003 b/tests/nvme/003
index 68f823011d7d..5f695c27fe78 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/004 b/tests/nvme/004
index af434674beaa..03ccd1e4e6b4 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -14,6 +14,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/005 b/tests/nvme/005
index ff0975ce7c28..7081faebb801 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -14,6 +14,7 @@ requires() {
 	_nvme_requires
 	_have_modules loop && \
 		_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/006 b/tests/nvme/006
index 3f161d08bc22..1137ab9c43fa 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/007 b/tests/nvme/007
index b0e61186e886..106775e65d84 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 7ffac945a58a..fbba7ff59aec 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/009 b/tests/nvme/009
index 9ac5cb479983..39a216dc7822 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index d90ca9d88053..02b653bc993b 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_fio _have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/011 b/tests/nvme/011
index d8badbc00846..349ac080f58c 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_fio
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index 93b6cfaf4c77..c64ad491266f 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_program mkfs.xfs && _have_program fio && \
 		_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/013 b/tests/nvme/013
index 3bae2f5edb3d..b9452d8061ec 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_program mkfs.xfs && _have_fio
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index b61e7182af66..40cb1615bef0 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/015 b/tests/nvme/015
index 05195e3bc598..b57680e7286e 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/016 b/tests/nvme/016
index a5ad973dc246..8ba0a895fbff 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -10,6 +10,7 @@ DESCRIPTION="create/delete many NVMeOF block device-backed ns and test discovery
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/017 b/tests/nvme/017
index 67d7ffc72e93..36b14f677449 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -10,6 +10,7 @@ DESCRIPTION="create/delete many file-ns and test discovery"
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/018 b/tests/nvme/018
index 43340d3c4d25..e4cd79350971 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index 98d82ae21b42..a697c3ac3d02 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/020 b/tests/nvme/020
index 2d4c0152bc55..6d7d5c99410d 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/021 b/tests/nvme/021
index 03b2ab749052..5a60ad4c8744 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/022 b/tests/nvme/022
index 977b844ee117..2cd224fcfa22 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index 6c3b44174884..07b48a3c1bb5 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/024 b/tests/nvme/024
index 9b5f6a44a916..14c331cd377a 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/025 b/tests/nvme/025
index 9f0e9f722a02..21b033c9c2a8 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/026 b/tests/nvme/026
index e60e73b2c26a..77f7043c8e4a 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/027 b/tests/nvme/027
index 805a3c63eba2..f950422824bb 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/028 b/tests/nvme/028
index c9bd3dde7f20..10e13b4de922 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/029 b/tests/nvme/029
index 7bf904b16edc..c871fb48fc0f 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test_user_io()
diff --git a/tests/nvme/030 b/tests/nvme/030
index 220b29f42962..314f39e93de2 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 001f9d2b0b3a..1df4dfd6cb9a 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -20,6 +20,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f0497416a..306a12440c20 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -46,6 +46,22 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_nvme_trtype_is_loop() {
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
+		return 1
+	fi
+	return 0
+}
+
+_require_nvme_trtype_is_fabrics() {
+	if [[ "${nvme_trtype}" == "pci" ]]; then
+		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
+		return 1
+	fi
+	return 0
+}
+
 _cleanup_nvmet() {
 	local dev
 	local port
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
