Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8860EC2BD10
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB6B21D7D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P7SYxHLA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="k9K0ZAQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB6B21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7wbvRTIzxTYbeolDhiWYk7FYfFKF/X8fVZ6VJCAFxBo=; b=P7SYxHLAeZcKbs8FeoDaF5Yf8
	As5XSen8HheYpyZVfZgM10pz92oa5G16VCOor/Jt5miD6VS53dlP80SKDXoZnRYhSW8TCrRsEc0Eh
	K+j5tax4FwaTXPnPthze3dK3JHvW7NPmllPVAOywBd/FOanVw0XjNbHzHS19OsHrdOMqLCXIKF8eQ
	p7L9Wwoa5p2O2rhPyWTPuBQDDfBepBx+3aPqT9eZClXMkZ5ETB1ywmWgVb1NDor0norNxo+ymhPmG
	Tcp9hMXxiktTATsQVMEtJQthAHxCrKpah1gXrzV8aEFPKvjkHEinpXHogdC/Of0DA9QuUdI11f+D8
	3Su/crtTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQYyL-0003Sd-UU; Thu, 08 Oct 2020 16:40:53 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQYy3-0003L2-PY
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 16:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UpWM+yjj8ziy97ndQzgM2ZJFF0WlYfaYMS3RABD6FHI=; b=k9K0ZAQ9vDNCok9vpYAJxhT37P
 yzreEWuuUDUvoJ42mR7dcucehon2sEsbg1taS1OcKjUEU7xIf0m9zPMwpm2qNZrtpxw1YZr7jT2rE
 dfCEr+lbV/VCGFokf/qR2k6keWvjYeuzex56fd7vGg6AinuUJK6WYdP7TVdM68GWunj/kwD2TWKgQ
 bTLuRY/1fAlUM5S8b+vb8YAPLyk6ctCKZFW52bNMBNhPSe1jvrVAB3KYBD0u9wcUT/YwE2VMJVGS/
 s/sHbrRSW8hqxZdK9IiAcY9UamCuSRCxPfCtnVOvHOVZMJCRJG6uFucVGE7DR8RNlAg1Clj77IyuP
 Q5dRoUXw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kQYy2-0000ij-Hw; Thu, 08 Oct 2020 10:40:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kQYy0-0003Hm-60; Thu, 08 Oct 2020 10:40:32 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu,  8 Oct 2020 10:40:24 -0600
Message-Id: <20201008164024.12546-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 11/11] nvme/038: Test removal of un-enabled
 subsystem and ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_124035_900298_55700505 
X-CRM114-Status: GOOD (  13.47  )
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
