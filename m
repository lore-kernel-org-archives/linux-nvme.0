Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B8C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3E321D7D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qcjc8gbA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="D75tK0Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3E321D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=btU3rgZl0dFe/I5U9O3Q5cIeLJ0jRWih1P30hxyfjPc=; b=Qcjc8gbALrnfG5CREX7tkbPPh
	iOFAFi2UxYV/JDpOyjowm6kPJPodEREOO/l7UsD1Wp92E/mavOQlnyQJIirGri2rWxEAyf2K25FkV
	Of5a7LGnvlV18/CahulAtXE/gL/l93Y7FRXgF+O9cMqtU85BXSluBCH/JkUg0loCsui74F+7JkpxE
	YRO7MH29deOk/QwWzb4LmyTyHeh56ofMPNHMpfZsf2zJ2Y9jKSglbnv+hVqWSJhec/n+4v/tFaxRU
	6Sze1tP5i8Q2mYMHrYoX/bK/Fze20s0a+f2Agy+a7tJXN5gFcGMItgw11ETPyHY/OE1NJPIN8RnRk
	C7KcOKOOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQYyS-0003Vt-UA; Thu, 08 Oct 2020 16:41:01 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQYy3-0003L3-QB
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 16:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JVPaqWSpQ5haRzwQ/xrH0Kw+7eTy8s+uTMUVQHnv9sU=; b=D75tK0RyhJR2HHe/DtlEMbJxIM
 z0xj8dOPwTKECazARHSzDWszjyEbONSzNUcCK1DG0XtNLIF8OiOnZoLcO2rXpiSNG0EQYX+UM9tmn
 U1jswFKsjJ84q2khZkApmz9J1Ta6eAZ78VNifWynmAlFuZ+QFyvL0wZ/iH/ylspgV629ax2FhhNKa
 yTM9OXpiNt0xCodXJpZIBNpohtOR2ExHx074/8Dbvg7DlcJ7yyugjJ0XSRSEw/KqA9QTqceptvm+p
 5M9ExP8szDUu40g2OqR1psTgRGZpFdPvVp5FekLF2f1isUjNxPE0lN+V34qLmur0ZH49DP3hYYMIp
 yevVChKQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kQYy2-0000if-If; Thu, 08 Oct 2020 10:40:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kQYy0-0003Hj-0s; Thu, 08 Oct 2020 10:40:32 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu,  8 Oct 2020 10:40:23 -0600
Message-Id: <20201008164024.12546-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 10/11] nvme/037: Add test which loops passthru
 connect and disconnect
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_124036_151071_06CB0583 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Similar to test nvme/031 except for passthru controllers.

Note: it's normal to get I/O errors in this test as when the controller
disconnects it races with the partition table read.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/037     | 35 +++++++++++++++++++++++++++++++++++
 tests/nvme/037.out |  2 ++
 2 files changed, 37 insertions(+)
 create mode 100755 tests/nvme/037
 create mode 100644 tests/nvme/037.out

diff --git a/tests/nvme/037 b/tests/nvme/037
new file mode 100755
index 000000000000..fc6c21343652
--- /dev/null
+++ b/tests/nvme/037
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+
+DESCRIPTION="test deletion of NVMeOF passthru controllers immediately after setup"
+
+requires() {
+	_nvme_requires
+	_have_kernel_option NVME_TARGET_PASSTHRU
+}
+
+test_device() {
+	local subsys="blktests-subsystem-"
+	local iterations=10
+	local ctrldev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	for ((i = 0; i < iterations; i++)); do
+		port=$(_nvmet_passthru_target_setup "${subsys}${i}")
+		nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" \
+				"${subsys}${i}")
+
+		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1
+		_nvmet_passthru_target_cleanup "${port}" "${subsys}${i}"
+	done
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/037.out b/tests/nvme/037.out
new file mode 100644
index 000000000000..eaf903d0520e
--- /dev/null
+++ b/tests/nvme/037.out
@@ -0,0 +1,2 @@
+Running nvme/037
+Test complete
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
