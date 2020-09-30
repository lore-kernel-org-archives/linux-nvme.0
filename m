Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940DC4741F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 18:55:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C46320708
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 18:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gDKNmuqY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="n81CGoUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C46320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eKqAGqk6dju9FBVXQ5QgMKPsoD7dILTV122gzkdkRqQ=; b=gDKNmuqYWhX7ZpQyJQOMX6Ejy
	F/sZoKEdKc1QEHY6ftY5FFtd9+MPP1aJyw6BnEWWZN3+EzSHWEdr1DN2LV21XD9HcFYhHHW/2c9Cx
	rSssAn0lRK2mBDphOr8aKW9rvc0SjPasio7IdZFibMJ/u53CDHFDvCgT8aj5DDl/+ifX6yGEFoUD8
	IFvrqsfDBr9bHsByOvS9S3dYW3P6+XKUqw/C7v63n85oKVUYyNFMzPsheZv4Hao04tpyRZc+/ICP3
	VLUNdWtcAw5NYANRYeGyua0UTyt0csFHSe+PPCs2jd7CI66VW24CtWgq7BeGDMkXv+79o6glH1wMb
	FuGre1/fg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNhFn-0007BD-Do; Wed, 30 Sep 2020 18:55:03 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNhFL-0006wd-5M
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 18:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=usviiWmZ0kC5VegpKwKjP6cu1fNBAkz/nKsk5i9RRWY=; b=n81CGoUHMZW+KfyHCKvSbtdmfx
 WIm6mMgdYIF7wsYAMw2RNTRRIS56sR8rZ/B7RS0nRMhRGtCuZNXwraw8SsdW0K7VQ3rdKseih9Jhz
 n3gxJ6d/2LQZxtg5Z8uFv8QZ5wGeYNYG8CXt3hd5gN636/B2+v66xpLxBRSE2fPJR2bZz4X7yk6vX
 mXIz3NQv8nzfn/L5z8a+HziVg5QKBpfYVok2oyF1DOJf+jQftgxvWYCRB5FEY1xBa18jBf49Eoxcz
 Wlhc1DWGkUUMwRpE0fZz5cXvtkOaj0/MVeg8yjPjO2DxF2+OMJn4/r4kuhSW6tIOZHbXVRX4qjKhl
 hQ4sMs1g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kNhFJ-0000uz-Nt; Wed, 30 Sep 2020 12:54:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kNhFE-00030g-2z; Wed, 30 Sep 2020 12:54:28 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Wed, 30 Sep 2020 12:54:19 -0600
Message-Id: <20200930185422.11494-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930185422.11494-1-logang@deltatee.com>
References: <20200930185422.11494-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 08/11] nvme/035: Add test to verify passthru
 controller with a filesystem
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_145435_276081_11C8B8F9 
X-CRM114-Status: GOOD (  12.70  )
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

This is a similar test as nvme/012 and nvme/013, except with a
passthru controller.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/035     | 37 +++++++++++++++++++++++++++++++++++++
 tests/nvme/035.out |  3 +++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/nvme/035
 create mode 100644 tests/nvme/035.out

diff --git a/tests/nvme/035 b/tests/nvme/035
new file mode 100755
index 000000000000..ee78a7586f35
--- /dev/null
+++ b/tests/nvme/035
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="run mkfs and data verification fio job on an NVMeOF passthru controller"
+TIMED=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option NVME_TARGET_PASSTHRU
+	_have_xfs
+	_have_fio
+}
+
+test_device() {
+	local subsys="blktests-subsystem-1"
+	local ctrldev
+	local nsdev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	port=$(_nvmet_passthru_target_setup "${subsys}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+
+	_xfs_run_fio_verify_io "${nsdev}"
+
+	_nvme_disconnect_subsys "${subsys}"
+	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/035.out b/tests/nvme/035.out
new file mode 100644
index 000000000000..a6027138fbe4
--- /dev/null
+++ b/tests/nvme/035.out
@@ -0,0 +1,3 @@
+Running nvme/035
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
