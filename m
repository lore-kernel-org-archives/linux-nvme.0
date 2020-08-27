Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1294BC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D561E207F7
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="boJi8dXk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="GTatHXPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D561E207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N91DNNO9Y26Y7vH8Q8Ds/UXRqf73VXURU7H60Hc/1rQ=; b=boJi8dXkf+VFsiQ9cA3vg69s3
	6tACPV2AObJMD+zEi27KkxPucKS+ClsJ6vwXfr63W00iHl6yLot4oICFZtaQ6SU1yKOgFm6nyYt0x
	kl7nIsOI6pthhfdboWMqS9/vGEoUGzRlJ4iPOPbt7gZL1e8xXltK39yeiU2qotmw6z5Hvf/J2ENEc
	HxyMcMiqJuQc5BJKmRqm5obaiz+UyuYrFqUXKwE7dgU+BJ1aqNNAGbXF5yiQKWSnCLv0+H5YYu320
	P4PSVykoiXfmnk3g6dTXFGLynvJObKFBcTeHScD9mvEFYJQ77Ivp941wS7JHr8SDf/IiEvfbXUJQb
	CXZVYeonA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBNty-0006LL-07; Thu, 27 Aug 2020 19:49:38 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBNtf-00068i-I2
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 19:49:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DAoZkGvyGri4FBXCJJ5289SPw0iwUdUnfJWjhiDDY2s=; b=GTatHXPthkBUKXWmo7elYdeWBJ
 6WNOdAcf7gSxIpytWrdZxGKjd9PQwleelsvuI29S4rK/aR8xDJwPyE6SmkCnqyG3ZPG9P7ragNK6T
 eQ+vZcMhCcY6dUkGIdktqDm2tRV16HwyLQWyAzAi5sUsq8a7lcf2SfTxqU9VsVAlicuxXBX8vSlVp
 F+tAvQBPcYjSy3q+LtdQdKniZE8DlxPlVfgrxBVcgDYjd3n/FVOgniytxqPaMogzC3xMdk8+gUH6E
 SRdTX/DD//bFYM2X0aYxRsEqi//JVGCuYeiY52GPpZ+FBqjloZM4NJUDM2RUIRLUBKQwHcUnkqssW
 9YScfu2A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kBNtd-0000Ce-Nz; Thu, 27 Aug 2020 13:49:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kBNta-0001cN-U9; Thu, 27 Aug 2020 13:49:15 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu, 27 Aug 2020 13:49:12 -0600
Message-Id: <20200827194912.6135-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 11/11] nvme/038: Test removal of un-enabled subsystem
 and ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_154919_773697_40FE6B08 
X-CRM114-Status: GOOD (  13.19  )
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
 tests/nvme/038     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/nvme/038.out |  2 ++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/nvme/038
 create mode 100644 tests/nvme/038.out

diff --git a/tests/nvme/038 b/tests/nvme/038
new file mode 100755
index 000000000000..29827f324155
--- /dev/null
+++ b/tests/nvme/038
@@ -0,0 +1,38 @@
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
+	_have_program nvme &&
+	_have_modules nvme-loop nvmet &&
+	_have_configfs
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
