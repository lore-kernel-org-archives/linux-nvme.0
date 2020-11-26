Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04752C63777
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A92020B80
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eZrg2F43";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlYKV02A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A92020B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OLfKCiMjDs8h9WFFS2SlqxscPlB679LCA7lg3czrvpU=; b=eZrg2F43LMd6VRsvQIKrUE93j
	GDEueMf2SsJJKBl5hVWTM6vBAX38PQ+pu29K2VNiPVbfGEX2JsJbyoEWMwTwSXU0JzYfkC3PKpwgj
	d6yHlf1IECLmMkzEAtrjZ8CQ0c31wwgBnseDTzSjon1Itja4PAjM7ORfTitCCmbnDSjutSgfQqN3V
	9n29wG03/Qlnmm3VZv3aEfSwdPPjrYabtL+1EbwMq6v6Pbnng5pWPgzGt1hrNPTUvmhmjg4Yk5dcS
	bQUoN8yvmgo9iYT1X1MjSMwtuoBs3f7cKshORXyHuylSJjVF7GgRLK5Q/49zcLsviLkLWXsM7EGTF
	fL9xJKaJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiClI-0001Ar-N8; Thu, 26 Nov 2020 08:36:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiClA-00018D-9k
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 08:36:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606379771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCz5ifcT7O2+wDdEnfcaQQvtu4Jd45LXFSIcs0dZ4Oo=;
 b=IlYKV02AVutypv6fQhbuj4O1ILkk41Yug+Bpq7UZ9/vE/K6MBZjNFj79TJBBjxg193uCiy
 r96ARrRIyOlPkvboZajCcESfhk91tSjglUKakmSxyXhBU9kJDA47Gi8b0pol5cAPXkJFc/
 YPhcGW8S/LCLOcdkK8qBtXUrOaO67eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-G4Ty0S98OrSs0KpjHCQsRQ-1; Thu, 26 Nov 2020 03:36:07 -0500
X-MC-Unique: G4Ty0S98OrSs0KpjHCQsRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 507161012E83;
 Thu, 26 Nov 2020 08:36:06 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78B9719C66;
 Thu, 26 Nov 2020 08:36:04 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V3 blktests 4/5] common/rc: _have_iproute2 fix for "ip -V"
 change
Date: Thu, 26 Nov 2020 16:35:31 +0800
Message-Id: <20201126083532.27509-5-yi.zhang@redhat.com>
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_033612_496376_7555E613 
X-CRM114-Status: GOOD (  13.24  )
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
