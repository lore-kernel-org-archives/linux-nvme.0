Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEE6C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16CD207F7
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="srGDdI3r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tPoyX7LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16CD207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cCGK08cfbsDDAk3N7c/AfrAZDqhxCqg+p83cIImZ5CA=; b=srGDdI3rZWw4AbD12s/dSh/hD
	sR9Z8PdtvWkODeK2VgITjQJq1Zb9L0WXKa2FKncmvHlgS+jGyQPsrF5GGRSEF8+lqOe1HU5UHBS4n
	tUiZ8OsBKeQD1Nrz+6EKaBKR3ajnSQLb3vDwAxdbrAL2lhvuxyGmx+ZXudcnCwekMh3/czagL4mb5
	cmclLHuDEU/1rgZnAtjU3UCRglLGLRTx0/a9Ap9/QSIMWUmMwtA7Hv/ltuZ0+0WXi3OmqGCPDRs4y
	ITlJPS54tDV7ACOqW7v5S243mphJdOzCSO/5SK/KlZ0giSvnOwJ9YUzAk2flqAwMlW9YtNWDkiTxH
	xwZ7dyzig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBNtw-0006KR-7X; Thu, 27 Aug 2020 19:49:36 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBNte-00067j-Cp
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 19:49:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T2/WWXhmesEttKgAkD/m71X8OynQjfURTrXfzc8i8WQ=; b=tPoyX7LBneOCOkyMdOq4SKMsX6
 QcY9nftn2g//8rXYw7GJw0gf0+TsfLc5f9X9wvu7BxVbZk9dIA63DyN3zNSC6z/DmHQ+vKvRm/RBH
 uN4+mCDhXbrnhoBck7eOsDaBmrTTsag9KIK6DIbzU+HVZAbwRU/N2trZQ6WL+vUuShuARehPTBBI7
 zSmDr/SOSC0ol2ialz0Aei/XjYw8fQq8p6yJcgP3ir/G3UoTe53go+EEHDhUXUJok+hJEIq7w1MJT
 nagPMnqCrcpzqU7kGGe+YyaOvDTh/ugdxHFcyZRZL5bou3OpN/WJnXmLLx4Hy2koORRKAAYVA0ACO
 IgAztFIQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kBNta-0000Ce-Tv; Thu, 27 Aug 2020 13:49:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kBNtZ-0001bw-RV; Thu, 27 Aug 2020 13:49:13 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu, 27 Aug 2020 13:49:03 -0600
Message-Id: <20200827194912.6135-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 02/11] common/xfs: Create common helper to check for
 XFS support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_154918_655138_EA2FA979 
X-CRM114-Status: GOOD (  15.92  )
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

Two nvme tests create and mount XFS filesystems and
check for mkfs.xfs.

They should also check for XFS support in the kernel so
create a common helper for this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/rc      |  8 ++++++++
 common/xfs     | 11 +++++++++++
 tests/nvme/012 |  3 ++-
 tests/nvme/013 |  3 ++-
 4 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 common/xfs

diff --git a/common/rc b/common/rc
index 7f02103dc786..3dd1ab76f737 100644
--- a/common/rc
+++ b/common/rc
@@ -181,6 +181,14 @@ _have_tracepoint() {
 	return 0
 }
 
+_have_fs() {
+	modprobe "$1" >/dev/null 2>&1
+	if [[ ! -d "/sys/fs/$1" ]]; then
+		SKIP_REASON="kernel does not support filesystem $1"
+		return 1
+	fi
+}
+
 _test_dev_is_rotational() {
 	[[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -ne 0 ]]
 }
diff --git a/common/xfs b/common/xfs
new file mode 100644
index 000000000000..d1a603b8c7b5
--- /dev/null
+++ b/common/xfs
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2017 Omar Sandoval
+#
+# fio helper functions.
+
+. common/shellcheck
+
+_have_xfs() {
+	_have_fs xfs && _have_program mkfs.xfs
+}
diff --git a/tests/nvme/012 b/tests/nvme/012
index dc86ee647729..981e7779e21d 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -5,12 +5,13 @@
 # Test mkfs with data verification for block device backed ns.
 
 . tests/nvme/rc
+. common/xfs
 
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_program mkfs.xfs && _have_program fio && \
+	_have_program nvme && _have_xfs && _have_program fio && \
 		_have_modules loop nvme-loop nvmet && _have_configfs
 }
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 0ed52926363a..228fab9ff02b 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -5,12 +5,13 @@
 # Test mkfs with data verification for file backed ns.
 
 . tests/nvme/rc
+. common/xfs
 
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_program mkfs.xfs && _have_fio && \
+	_have_program nvme && _have_xfs && _have_fio && \
 		_have_modules nvme-loop nvmet && _have_configfs
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
