Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F197DC4727E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 18:54:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B252076B
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 18:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2qfSQKhN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="OUtQk0w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B252076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7wbvRTIzxTYbeolDhiWYk7FYfFKF/X8fVZ6VJCAFxBo=; b=2qfSQKhNMZ+tAMb6ztOfKdjkF
	IRrr1IMfEwhHc9TS5zKxhh1372LjjX1wN51hmjQ8wdftECSslFzipiysL1AhVgUIQuQZPxrnZu7so
	xbRKZzxJALVTupfJH8+duA2PuGDYoa6VLZAh1Og9bK4WrkMV83Ond2jm+K42ns/DIglkqWppCEjrs
	iqNGN3cPV/YW3Ha5IxH5qhTNAyX8t6gVNMFOUGQ6LRH9FIt0mVj64QtDYIBtobjk+7BcKe65XWEb9
	T6tbVTUf9tEdnK/6wT7+Y7zyboC7IUquHgcdywrvX0fs9+WqyhqopYXO/3DZXmh4xnJdgwPHu5tKZ
	jk1kZJVTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNhFQ-00070H-VI; Wed, 30 Sep 2020 18:54:41 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNhFI-0006ur-JS
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 18:54:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UpWM+yjj8ziy97ndQzgM2ZJFF0WlYfaYMS3RABD6FHI=; b=OUtQk0w6VLrF2XMMJhvoxhd58D
 WxJk162Ct6437Xt2MV9Vcsxa6lNuZtmreRU4E2BvOebfWncRcu2Tr9kAOCLgwFcws5mrc/bOVzDEJ
 ZsAw9ZDMgaUiJSLihuQSS2cKlW4HTOSryFYk1dDsZ6b5ogP3ubn/BOr/t18qaknYSSfW+a7onDZ6L
 35b4nga9qlsWzQArvALcnM3q+31UzrzH4Gx5wjboHLutCWdHzPo4IWCWylqVM/OiHyjHly1rnDAYD
 QLfjTKal6SD3IhKQjUK4PmFPML6PnF/XRoap2lzae+heRrxp7tY28ZRjGDq9XnK+aWCUXJlLY7pE7
 BAfuSLJw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kNhFH-0000uy-Au; Wed, 30 Sep 2020 12:54:31 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kNhFE-00030p-Hp; Wed, 30 Sep 2020 12:54:28 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Wed, 30 Sep 2020 12:54:22 -0600
Message-Id: <20200930185422.11494-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930185422.11494-1-logang@deltatee.com>
References: <20200930185422.11494-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 11/11] nvme/038: Test removal of un-enabled
 subsystem and ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_145432_695818_C605FC0C 
X-CRM114-Status: GOOD (  13.15  )
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

Test that we can remove a subsystem that has not been enabled by
passthru or any ns. Do the same for ports while we are at it.

This was an issue in the original passthru patches and is
not commonly tested. So this test will ensure we don't regress this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/038     | 36 ++++++++++++++++++++++++++++++++++++
 tests/nvme/038.out |  2 ++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/nvme/038
 create mode 100644 tests/nvme/038.out

diff --git a/tests/nvme/038 b/tests/nvme/038
new file mode 100755
index 000000000000..24f02d4ad4d1
--- /dev/null
+++ b/tests/nvme/038
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+#
+# Test that we can remove a subsystem that has not been enabled by
+# passthru or any ns. Do the same for ports while we are at it.
+#
+# This was an issue in the original passthru patches and is
+# not commonly tested. So this test will ensure we don't regress this.
+#
+. tests/nvme/rc
+
+DESCRIPTION="test deletion of NVMeOF subsystem without enabling"
+QUICK=1
+
+requires() {
+	_nvme_requires
+}
+
+test() {
+	local subsys_path="${NVMET_CFS}/subsystems/blktests-subsystem-1"
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	mkdir -p "${subsys_path}"
+	rmdir "${subsys_path}"
+
+	port=$(_create_nvmet_port loop)
+	_remove_nvmet_port "${port}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/038.out b/tests/nvme/038.out
new file mode 100644
index 000000000000..06bc98022c33
--- /dev/null
+++ b/tests/nvme/038.out
@@ -0,0 +1,2 @@
+Running nvme/038
+Test complete
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
