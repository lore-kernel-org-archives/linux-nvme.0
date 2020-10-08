Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B4EC04EBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BDC21D7D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eYRrDw0y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="sACgK/RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BDC21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z73xP26D2f9ZpRS+J2En3XMFZLVilTpoz9SPAq+G0Cg=; b=eYRrDw0yfXamdJvQKvat70YiJ
	crxGlPxeuufKVphcjTIqMh9g9S1WFNi+iaZJ37Z0kpdePU35yh68+9s/isl+RdaPZupqcjNDI2Svn
	lpQwMnB57fLBElg+Ig9B0ihjShnziPFcEGqN6eFdA8S21WPP+udQfLURlzEBabWheeHxnNTV6hu4g
	mBwToaSdiHfHghfiUUIoh9FZa1N4g7NVVve4P2Z9kwLePLwB5hBx9hyyojcxZ1Vt+QpF2Phtqa2JE
	HX3QovpmWHxLLGpj3cd6tOgJiycK/M2ZlN+hmm8IgvXa9MC2Vo3Ja2Xmd0H9pODwmiCLFKuex1C7Y
	sTJEGuoAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQYyC-0003Oo-FU; Thu, 08 Oct 2020 16:40:44 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQYy2-0003Jm-EK
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 16:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jmZbySZXjmmi8+BukunACpKuNnADqVJZ1o4R+xzQg+E=; b=sACgK/REf+ZkmnOQitiTGrI+zK
 AGXi0oH7ClYOzdzkOROScK7euCGD9oX43xnfmvg0X0tpdvRcdFIXoatlTS/zx5wLibAh4fCnqKvez
 ucQQ1soaxH9Ux2+HCIoeSf19XMcJfcSt2pFFpTeuQiIg3NAG6rB4qIugQokHw8U7l5IcxwJ3U8gLI
 COhYZWW3WQHLbEvn5voJvV4jOpGM6u0Mb3mA04GNT4I4YzQoVFHrAGDz9noaBQlwvjp7RgqzeCiwG
 WOaM+Cx4S1QXkfK9GTHtxq1qOsQlAobYxIBHJcsJkymJl90kBNYMiSHry5mnjC/2LIyweZ3sga621
 NdrvBAPQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kQYxz-0000ij-Po; Thu, 08 Oct 2020 10:40:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kQYxy-0003HL-V5; Thu, 08 Oct 2020 10:40:31 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu,  8 Oct 2020 10:40:15 -0600
Message-Id: <20201008164024.12546-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 02/11] common/xfs: Create common helper to check
 for XFS support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_124034_510232_7BA65FFB 
X-CRM114-Status: GOOD (  16.60  )
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

Two nvme tests create and mount XFS filesystems and check for mkfs.xfs.

They should also check for XFS support in the kernel so create a common
helper for this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/rc      |  8 ++++++++
 common/xfs     | 11 +++++++++++
 tests/nvme/012 |  6 ++++--
 tests/nvme/013 |  4 +++-
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 common/xfs

diff --git a/common/rc b/common/rc
index cdc0150ea5ea..44cb218c2fac 100644
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
index 1dbd59804ed7..1d8d8e3cc271 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -5,14 +5,16 @@
 # Test mkfs with data verification for block device backed ns.
 
 . tests/nvme/rc
+. common/xfs
 
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
 requires() {
 	_nvme_requires
-	_have_program mkfs.xfs && _have_program fio && \
-		_have_modules loop
+	_have_xfs
+	_have_program fio
+	_have_modules loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index df7f23e69252..3819a2730d9b 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -5,13 +5,15 @@
 # Test mkfs with data verification for file backed ns.
 
 . tests/nvme/rc
+. common/xfs
 
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
 requires() {
 	_nvme_requires
-	_have_program mkfs.xfs && _have_fio
+	_have_xfs
+	_have_fio
 	_require_nvme_trtype_is_fabrics
 }
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
