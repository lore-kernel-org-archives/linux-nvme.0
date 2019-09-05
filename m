Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A265C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 17:44:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B1B20828
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 17:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hunQ7sLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B1B20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cFxob4+5+WsCINwS0/bnxoNRTcyUteRDJBiQ2YknuNA=; b=hunQ7sLP5cYzaw
	eoey8BgMLaom90ynV2nxAeBEL/wO2jwxQRD//jNfO0SGDHHiqycha9S6IXEPFZn/924GsTRxkjGrZ
	qYTAeH/zzsdJmLlaoSf92WyGT0JWERuuLxAHgJL2hrP9ye3zwavwdd0YcWrXAMVGbKkD2nUtdpARM
	WhVAe03J0EMTb6HHf/yvK0riWOo8lpfWrMolGXpjgEVEsVA22hYRaTnjrQHoyd5I/LXE/GxztmRFF
	5Wxqt7WRas0EWoAcACcl2TD3HQQDg5ehSHDn5+uXJ/plbNfqKooCirKMz7aZp43up7EqmtCfpTj3W
	Tjm8EHD67AanVCTIJkUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5vnc-0002qH-NO; Thu, 05 Sep 2019 17:44:00 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5vnZ-0002pS-8M
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 17:43:58 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1i5vnS-000641-3D; Thu, 05 Sep 2019 11:43:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1i5vnR-00082u-H7; Thu, 05 Sep 2019 11:43:49 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Omar Sandoval <osandov@fb.com>
Date: Thu,  5 Sep 2019 11:43:47 -0600
Message-Id: <20190905174347.30886-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 osandov@fb.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_104357_629614_3AD340C2 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A number of bug fixes have been submitted to the kernel to
fix bugs when a controller is removed immediately after it is
set up. This new test ensures this doesn't regress.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

---

This is reallly just a resend. The patches this tests for are all in
5.3-rc7 or earlier and it passes on said kernel version.

I've rebased this patch onto the latest blktests as of today with no
changes required.

Thanks,

Logan

 tests/nvme/031     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/031.out |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100755 tests/nvme/031
 create mode 100644 tests/nvme/031.out

diff --git a/tests/nvme/031 b/tests/nvme/031
new file mode 100755
index 000000000000..16390dcb380e
--- /dev/null
+++ b/tests/nvme/031
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+#
+# Regression test for the following patches:
+#    nvme: fix controller removal race with scan work
+#    nvme: fix regression upon hot device removal and insertion
+#    nvme-core: Fix extra device_put() call on error path
+#    nvmet-loop: Flush nvme_delete_wq when removing the port
+#    nvmet: Fix use-after-free bug when a port is removed
+#
+# All these patches fix issues related to deleting a controller
+# immediately after setting it up.
+
+. tests/nvme/rc
+
+DESCRIPTION="test deletion of NVMeOF controllers immediately after setup"
+QUICK=1
+
+requires() {
+	_have_program nvme &&
+	_have_modules loop nvme-loop nvmet &&
+	_have_configfs
+}
+
+test() {
+	local subsys="blktests-subsystem-"
+	local iterations=10
+	local loop_dev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	truncate -s 1G "$TMPDIR/img"
+
+	local loop_dev
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	port="$(_create_nvmet_port "loop")"
+
+	for ((i = 0; i < iterations; i++)); do
+		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
+		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
+		nvme connect -t loop -n "${subsys}$i"
+		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1
+		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
+		_remove_nvmet_subsystem "${subsys}$i"
+	done
+
+	_remove_nvmet_port "${port}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/031.out b/tests/nvme/031.out
new file mode 100644
index 000000000000..ae902bdd36d4
--- /dev/null
+++ b/tests/nvme/031.out
@@ -0,0 +1,2 @@
+Running nvme/031
+Test complete
--
2.20.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
