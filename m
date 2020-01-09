Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8757C33CA1
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7309B206ED
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IgNozIaw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fHsYTfPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7309B206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=326lXHwhDAlM0ISlKF6gBbpRyyNYjfVvw/YSzycCfRs=; b=IgNozIawHeG/PY
	i4IYF+ORA4tGqt/kIgjjE6L0xy1FiE6OYhrWU47ExFnyhVyMvcDGbeO9i7ptC013DjGDIfhPv1hfd
	QyqbYF+Hgqd0pc17WePzSf9hGqZ7dsKxviQURR4M/jp07vFkTN3/0jDJ8aOGH7Tou3k6jh8/5qW4+
	KHrlgtat73oR6sxxcNufjNADcYDELgBhyovgM2SIKFyLhdCHxmlB7fwBlLFcDvAy6S6ek0J47CiOE
	QhkpMnEHo1Jpf886mO5BxjLBOOvJSwTxJoNuwV2ai9LmmbWTjv+FX1vtjbeAvaxCkVqXpeUsjw0eE
	OQYmsxR9sMq+0wVKvCNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipQ0E-0004VE-8N; Thu, 09 Jan 2020 05:05:02 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipQ0A-0004Tx-N0
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 05:04:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578546299; x=1610082299;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hA176hSIwOQe5LvU8gVRDvEgHSteDEOwP2pp7QzzH50=;
 b=fHsYTfPJ/gR08CDxEymjm8+ZNWnWDnApiRFckav+mKqActR23Qiha70k
 m05WvMwjA7f7yINnKLTHRC7AHM1bTkpY4Gu0u3DzqkDTyh+IAX7YwpWFW
 8rF46egWvxQ4uEJFCG1v+Y/gKdQMn27cWhF7yuc4Eesp2IxVKVYhCzoOI
 qxWzTHklEizpUsZ72gD8LmkGKu8/axJC1fG0iIdvgwR+vj3Wn07s6gTti
 bDyFd77dpzTgZ3hXcvctKN5c2Vie17bS9BpEX6R7pVbNQuiLSlUqxj2cp
 nPAyVadfZfuckj1Pu4PCDKMFPsezeQPgUoC9tRCqbxIRMCFQDFNWyrzmY w==;
IronPort-SDR: iUF0K+8a4bzbb9I6mieAFY+t81AwNKnvcIld9SqUYLlqHtwpR6vtYGKxmbfi02JTSvO0TRTsfY
 DjS2LpcDd2MZHm8FwUFL1fhpFzIzsMf3xR9iV38GVbIUYKwxQyfOHuIgpAnhNxq/cefr1EBIJz
 iSbo+V06CfScnQIcQYqkC6/VG7on4/wxdIfM9UQEcjN20VcwItev8jh9TH4IT5y/LN2Ehym4ft
 UiOndInbPWCN4KTAv87UWK5LtIXVqchaxehkz2fd4XYjmu8jwpTBfO4S69kUn/PbzXn3FL+b5o
 YNI=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; d="scan'208";a="128585951"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 13:04:51 +0800
IronPort-SDR: c2B0bkzQ18G6P5Cw5uX1fq9Oer1MRG24qXkXX5GIcRd89sFgL5basDlYPTv/GQRcP5t8a46/xE
 15sTAhgXWgXbnriaxFN46UQcb9EmTmA6xsz9CTIUX6l9gZdBIJyTktTYfYnZHrt82od4GQUFzh
 FyFyfERgFVG2qM7+iM4t0y+8Q0N4cWhbuoIeHuAyxQM1mykAR2b2j/FFamvlTGffovfFvd1gU+
 eSinTYJUsE9/STUW563hQeIZU2s9Ib44gcjirnZbaKmmYU0YA5B3bsZnW0mtHAoeDGqesr0zyf
 DsnszwWHnEOvLKtV+frstTVV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 20:58:38 -0800
IronPort-SDR: zqz1/PHUJ4KymCiG8O4DTqjUB4QLr2/xYOg5SfoXLsGd/0IxV4rp2h/djeYZAvkOiARd1QWLne
 aGckJcdS5HW9TRkg/D5u+UiYTZrvXKEwjIsSf5Dk9yHM4i+wpDMWKW78NJ3gknqgn8BcyIY9ff
 cKTBuGx7TtlXg33Ib23USpC9bMhGEJeKNEhDrDOq82Pqs5fTlzOVc1iI2/+6lkiXqrsmhdfPMU
 kwY0ELcrkS0ppioqZN8M9Jj50b7Gwik3pzD9INemetcqVvdvJMZQ7QSj0mLs5VifpK/aAOP1bV
 wsw=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2020 21:04:51 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH RESEND 1/2] nvmetcli: allow setting of the cntlid[min|max]
Date: Wed,  8 Jan 2020 21:04:47 -0800
Message-Id: <20200109050448.5758-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
References: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_210458_789829_C26AF881 
X-CRM114-Status: UNSURE (   9.06  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch allows users to set the subsystem's cntlid min and
cntlid max.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 nvmetcli | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/nvmetcli b/nvmetcli
index 3d8c16e..4fdac53 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -155,6 +155,8 @@ class UISubsystemNode(UINode):
     ui_desc_attr = {
         'allow_any_host': ('string', 'Allow access by any host if set to 1'),
         'serial': ('string', 'Export serial number to hosts'),
+        'cntlid_min': ('number', 'Set min ctrl id'),
+        'cntlid_max': ('number', 'Set max ctrl id'),
         'version': ('string', 'Export version number to hosts'),
     }
 
@@ -172,6 +174,21 @@ class UISubsystemNode(UINode):
         info.append("allow_any=" +
                     self.cfnode.get_attr("attr", "allow_any_host"))
         info.append("serial=" + self.cfnode.get_attr("attr", "serial"))
+
+        try:
+            cntlid_min = str(self.cfnode.get_attr("attr", "cntlid_min"))
+        except Exception as e:
+            cntlid_min = "n/a"
+        if cntlid_min != "n/a":
+            info.append("cntlid_min=" + cntlid_min)
+
+        try:
+            cntlid_max = str(self.cfnode.get_attr("attr", "cntlid_max"))
+        except Exception as e:
+            cntlid_max = "n/a"
+        if cntlid_max != "n/a":
+            info.append("cntlid_max=" + cntlid_max)
+
         return (", ".join(info), True)
 
 
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
