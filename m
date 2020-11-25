Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364A6C56201
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960DB206D9
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CFxuz27z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hY0HULI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960DB206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VPnrtURADQS2IuUPIn7e26SrFF5dO8yTEkdc/ca+dGQ=; b=CFxuz27zvTPr88uc2yfuNg0I0
	oEQREDWvUMvJgmlV6vLk8NCyvH/21uYWthc+JtqJOFXdESYvQoAISAI6xWGu7UE9dN7l2Vs41lhew
	2/4ZeBY7h7Ojt6iTjrfWPnjplWs5p9f1Ea7QGyS9Usdk37FNNxkp4ZQxBs9HC/LQVdoCGKFfFi9GR
	X7XwwtKxa+jF9HyyCxglUVN2c7bFNtpJTUD00jylAxQkBl3YHZ1YRKiMoajR0jFg2LyXKlWXNJiZU
	IflZqU4MImbnR6a+PJWuo5HfgfQqVCSplJEnclJkUH7jt4M0jc/H3rnpLfst37sG/J/E5EL3fiGpB
	mzvMh/hoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khpI8-0008BH-K0; Wed, 25 Nov 2020 07:32:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khpI6-0008AZ-4L
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 07:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606289557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h27fAXdGuV6wrMdtw8W1ctw5U/mIM8/bS3+3KYoWkS4=;
 b=hY0HULI23r7qxtdvnISdkbAHxuLxtzQNqodGzBhv/fAN6bZ5Jw7ISFM1VvH3pDvSKXaacL
 k2+2bt4CmlFybSU1lyAZKw0OnBpi6sUH4+6LOwCQYYnSNnLzc2bWgzZ5FQLLjDLh3lMSZZ
 aOFZbnNHtY0rRlutbYnMujDUi2KD3E4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-X_2anpEKPm-jCkno9Sk0Gg-1; Wed, 25 Nov 2020 02:32:35 -0500
X-MC-Unique: X_2anpEKPm-jCkno9Sk0Gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A2D809DE0;
 Wed, 25 Nov 2020 07:32:34 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AB3519C46;
 Wed, 25 Nov 2020 07:32:31 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V2 blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if we
 set multipath=N
Date: Wed, 25 Nov 2020 15:32:02 +0800
Message-Id: <20201125073205.8788-3-yi.zhang@redhat.com>
In-Reply-To: <20201125073205.8788-1-yi.zhang@redhat.com>
References: <20201125073205.8788-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_023238_224651_01E7C82B 
X-CRM114-Status: GOOD (  12.52  )
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

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/rc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index d7a7c87..fc06856 100755
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
+	and multipathing has been enabled in the nvme_core kernel module"
 		return
 	fi
 
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
