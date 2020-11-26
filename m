Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F9C63777
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD4D205F4
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0AS7bCsJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfAQfk0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD4D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DavXAUsQTbEmmZtZnRZ15uBEB9ng6Xh9kUC0VJuAdXQ=; b=0AS7bCsJX70PBiiAfsGUQab5l
	7bHjiUIeOmPYI3CnEzB7UHJrrkUOJ+feEMav97JIiyE4xOQXh057ktRu3jsJ39N8+EWbj7N4NdqvX
	dEam27au0rHK71cK/CTfdMCNIKvPP4cvbQPWSMzfYU2tVp/izApYL466/GbksUNdIHvGqmtA9TllH
	Sr9duhLo88gbOqDoPsEL3tfcqBCzyUdE396IOoJ0KNcge+uNqSbfoWmzXLkwW+RUerlddU4MhKh9W
	kYkwUVrA7NKLFtTWLRHCfWcs4jvRMBNWg71exw00sie/uFg5m/6ihNKrUUPLONjNCwKr9joUn9Ssp
	e5kr1h2uQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiCl9-00017u-AO; Thu, 26 Nov 2020 08:36:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiCl4-00016h-Fh
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 08:36:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606379765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1JUCFxP98Y6dqOjE3XLdXL2MOBEQrR1ym0p8vqzfFo=;
 b=BfAQfk0tCcs7moiIFrXKljdemJaV2ArY9msdRTlKA+2XaPEWf7wjhtoHFoDjsmJov4b6MY
 UX/ddyxx9f5XjH6EzArRmaVOun59WoU3qZ2bRLy9by7xLw0MUmu3vwFEAzDh2+A4zpJOCZ
 gjBBsL5Kep2nuY3bBgCL+HLi+mIh1R4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15--JoODfOmPliVtZxArPpDmg-1; Thu, 26 Nov 2020 03:36:03 -0500
X-MC-Unique: -JoODfOmPliVtZxArPpDmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A277B9A229;
 Thu, 26 Nov 2020 08:36:01 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C84E819C66;
 Thu, 26 Nov 2020 08:35:59 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V3 blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if we
 set multipath=N
Date: Thu, 26 Nov 2020 16:35:29 +0800
Message-Id: <20201126083532.27509-3-yi.zhang@redhat.com>
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_033606_658351_BF4C034C 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To enable it, just do bellow step before we run it:
$ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/rc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index d7a7c87..c77526f 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -16,9 +16,11 @@ group_requires() {
 
 	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
 	# tests are incompatible with the NVME_MULTIPATH kernel configuration
-	# option.
-	if _have_kernel_option NVME_MULTIPATH; then
-		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
+	# option with multipathing enabled in the nvme_core kernel module.
+	if _have_kernel_option NVME_MULTIPATH && \
+		_have_module_param_value nvme_core multipath Y; then
+		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config \
+and multipathing has been enabled in the nvme_core kernel module"
 		return
 	fi
 
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
