Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C770C5519F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D92206D9
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0XbXuHAT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bH7WSw/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D92206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OLfKCiMjDs8h9WFFS2SlqxscPlB679LCA7lg3czrvpU=; b=0XbXuHATzbBmTv29Z+/ulT+Yt
	XVneB2QjTARcMs77FQ4xf1l8JsZmlssIWXuY1hiRo+jEcovjFUQ9ANUI69le1t03wY+3Za4zzC407
	wLSqP/FGQv/ig2qsvvbdMi2zQDTpD3fWef74kJeVsJArdQBuq0mFaJBw9WYonlxejSUrhcwdKqVxu
	r+WiLh3o/Ry5nORvy8pT3LwaVDQ3FGZ4E7w5C1iBaPxj+ZwkP881VN5ynmnBoPyRviopRs3l8mTnb
	6f+csDCqtf5Kpb9kYaNGdCuKWVq9flDZR5ssBB+fFHR19oR3x2s19HJq2TU7oblSb1nJEbBj6xK0+
	ux8fLpNZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khpIH-0008EI-2z; Wed, 25 Nov 2020 07:32:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khpIB-0008CF-O2
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 07:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606289563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCz5ifcT7O2+wDdEnfcaQQvtu4Jd45LXFSIcs0dZ4Oo=;
 b=bH7WSw/qki0TjdGlMk1Wkq8y0JVMMpEnjBdsgPhiF/fRxmb2c27/iBhT3A/ckvYrZpIYhF
 UGdkswLoWPlOKLMmmHc9Ksh7wT5ZcXr8iMIsJ1teIWGvRGyGjIFovBNjo4bZKWV/z9aOVG
 9cxl+7zY/t6ZHmnIfCBZ3KndGbRiYfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-nxaaoZn9NFqtpLqweA0gtA-1; Wed, 25 Nov 2020 02:32:39 -0500
X-MC-Unique: nxaaoZn9NFqtpLqweA0gtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B51C71005D4F;
 Wed, 25 Nov 2020 07:32:38 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E05BF19C46;
 Wed, 25 Nov 2020 07:32:36 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V2 blktests 4/5] common/rc: _have_iproute2 fix for "ip -V"
 change
Date: Wed, 25 Nov 2020 15:32:04 +0800
Message-Id: <20201125073205.8788-5-yi.zhang@redhat.com>
In-Reply-To: <20201125073205.8788-1-yi.zhang@redhat.com>
References: <20201125073205.8788-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_023243_827518_0526C98C 
X-CRM114-Status: GOOD (  13.18  )
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

With below commit, the version will be updated base on the tag
fbef6555 replace SNAPSHOT with auto-generated version string

To reproduce it:
$ ./check srp/015
common/rc: line 98: [: ip utility, iproute2-5.9.0: integer expression expected

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 0d7a3cd..37eb873 100644
--- a/common/rc
+++ b/common/rc
@@ -95,7 +95,7 @@ _have_iproute2() {
 		SKIP_REASON="ip utility not found"
 		return 1
 	fi
-	if [ "$snapshot" -lt "$1" ]; then
+	if [[ "$snapshot" =~ ^[0-9]+$ && "$snapshot" -lt "$1" ]]; then
 		SKIP_REASON="ip utility too old"
 		return 1
 	fi
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
