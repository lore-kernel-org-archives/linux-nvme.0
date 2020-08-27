Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693DCC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32329207DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0FDxRRWo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="b1Tt20hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32329207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1uIuDbiAQvUMz9MsAMXc/R59cCk/4DDNKuYDKO/TnyE=; b=0FDxRRWoRGSPHfmVahP7rjEKH
	MLVXF1ZFslebQyo/Z60iJFqtdy5vGT4WglvDXYV3uQoEo+IlyTFDDQmf8GaaezmKyImND7ihwHSZK
	dZ30lT6gwgB9KSF0aEfdQRLGFixkji3GMfqnGb/cMzcs6bEFLSWdw6dJzIuVlEnapQQPScdDuBzdd
	VmGxZIWopCuBYld5k53MSjnW1wwWcRpZUxkxSH7YtQvdBolglyXbeLd+m1pOSnBuotCEdZ+bYdsYy
	dQmrAQ3yMjS8S8qM5+Qs0ifL36W0sJRIZOSDOUh8y5i1ndk6UbCNReQ2AdsvG/ZsWNDjg4Xm0MUeL
	zyTQ3MubQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBNuZ-0006hc-Df; Thu, 27 Aug 2020 19:50:15 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBNth-0006BW-UU
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 19:49:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eKZPvO1tKWLtBvuic8IXvf9/O03akYLNwwlOK0SGW5I=; b=b1Tt20hrJWzhLnvdH+/lzWKrLT
 Ycq5eHtejxhOMBEWa48hIi0YYVul3/02FjMcVJk4akVyqTAy/BtwrfM+vqYT6c7uheNiAjb1dJUbr
 nLxZ0oKb5NPfnpy2d3/TUD4JW6oVcHJxThtL6XWqpeBHGA3VTx9ha/5G6eqXuxxjztwwcymr6mr0h
 wc+phqREowva9NKwtzXZhWzdwjIEKyuP5wRwJb6e9e9Ipkpkcz8l0wADYa9/Q9aKfgoK+bx34oF3k
 Zl+icF/1m4HV1D9YpFWt5WHR6xU5OhMTGeEReAxP54rvfELiJQIAEGqmQ5XRzhMMD6uwjQlj3f3ar
 aPG5SRqQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kBNtg-0000Cc-IX; Thu, 27 Aug 2020 13:49:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kBNta-0001cB-Cw; Thu, 27 Aug 2020 13:49:14 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu, 27 Aug 2020 13:49:08 -0600
Message-Id: <20200827194912.6135-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 07/11] nvme/034: Add test for passthru data
 verification
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_154922_115816_1F568156 
X-CRM114-Status: GOOD (  13.50  )
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

Similar to test nvme/010 and nvme/011 but for a passthru controller

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/034     | 37 +++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |  2 ++
 2 files changed, 39 insertions(+)
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out

diff --git a/tests/nvme/034 b/tests/nvme/034
new file mode 100755
index 000000000000..18a539319c12
--- /dev/null
+++ b/tests/nvme/034
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+
+DESCRIPTION="run data verification fio job on an NVMeOF passthru controller"
+TIMED=1
+
+requires() {
+	_have_program nvme &&
+	_have_modules nvme-loop nvmet &&
+	_have_configfs &&
+	_have_kernel_option NVME_TARGET_PASSTHRU &&
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
+	port=$(_nvmet_passthru_target_setup "$subsys")
+	nsdev=$(_nvmet_passthru_target_connect "$subsys")
+
+	_run_fio_verify_io --size=950m --filename="${nsdev}"
+
+	_nvmet_passthru_target_disconnect "$subsys"
+	_nvmet_passthru_target_cleanup "$port" "$subsys"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/034.out b/tests/nvme/034.out
new file mode 100644
index 000000000000..5c851b46779d
--- /dev/null
+++ b/tests/nvme/034.out
@@ -0,0 +1,2 @@
+Running nvme/034
+Test complete
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
