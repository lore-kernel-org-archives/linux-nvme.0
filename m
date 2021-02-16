Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF415C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7259C64D99
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7259C64D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=le1V00OjAnPlI+4RLzUASEQ/9l4P/QC1J5RulqzzBuA=; b=qBEf9UKlHBush/DAutE8F1Yqh
	n5wScgwKwLDFZCGBWitOQQkX9NL0OZa06TGjjhbT3ILw0r/rz9Xsi5bB6V6eUeqYWLR1lT3GZQnu8
	4I0UOBKrJ6Bw0HJMemcA+RC89sfkR0DjkP7HaEUQjtLbas8Pc8C0ZgrCuKIwr4cySQCtYLqdskTDD
	VB6mEryRaUlEPiSq6vxmBfnzpN3TYISNe4hQnsUG0elr79EYdMuXR1HyGDo0d04JI6zjO2eaB/qUY
	3bTbswKZTBMBYAxE+TPUgaFsjtY+omW/8UipqjxBXMsYJUjYhETYxHjdr2hiSnHwXL30cFgrcveAz
	OgaT5Ihbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lC7wh-0005XH-Q1; Tue, 16 Feb 2021 21:31:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC7wf-0005VT-Bq
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 21:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613512106; x=1645048106;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EnGP+0W4a3C0ovqjygrcSkFQIphUi0vpB2VYCG1+Erg=;
 b=YasNsKlYKlBE/wQERsNgjBpW3Y4tZUe6QvLP9thZJsxksJYwdBkC8HUL
 Z/KuNNEUsKOmfInuK+FrUogm8XryUQUz7EcrqZA9EnQEGvm31j7NL/Vd6
 K9YGNZsy/n08WqqYnsrInuk1bXSTtY/jPwuAuOdJkacDRKa14Psxr0p8Y
 BbBM8Z5mBf0MKmmSqeKCXlyLY0XmVAOteHG90QuBNgSzRNrN4Q5Ch3RRR
 IyS1absXxAJkzAakeBbFiou0JFahWSJBMVtgmJs+qJf2ryQPsHafnPtX8
 LEcOAGASOZiojmwMVA118nYuIe5Ahq8pHp1d11JVnCAXPrS1WKA+Qkp4q g==;
IronPort-SDR: Vr8hSNzZro54t56P6m5nKxULoGrqr2Z9ZwiSUYwD5+DAaBu78iapTkEzya9u4wnk3PaiR0IeOB
 ZRw+o8uDZIQKzVa7iBK8FzfiZgPS2KlVM/vsyHV44zlAYwbw9pWHsB26u0s94d//69ufeQOQXv
 aJnZnwGEGBhvdowvxc7/MXF/petkW7+2DcjFNJmYB0DELMaiYK9ktNLH6v+Ij1bTwynSv1LDrK
 8t1iV63cf+jDo0IOApP0/SA1or26k+KMkl+/CzEOT9k9R7XAbttwpg1YC5HRtqSYen3CJVLc/2
 fhE=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="264264375"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 05:48:20 +0800
IronPort-SDR: xphgltWdfBXIo7jCGb/Cu+54tuU9khEzjKpN370GIA4bPJHoAsJcoQfo3f44HJv7lxF4kEeWGp
 QbGuPitry6Qw74GG41DURjDY/e0jOhZYhQlZrpE6+Vat0zU4cvOS5zz+b4Ly6PEdGThmv2R44q
 K5Jwsk9rOM7BVgh65InDz1Na6GOh8UcQMcpkTxKEVJ5A2wluLmnRJWzM+XyID6NsRXVO9rkqB2
 HNV3lrvtZ269zAmcBwtMtuD2psSsTTkAMfp5mYTnz28fTya4L1lemkECpJe2ksXmM5l5REi15+
 xQv1CYScwe6wpkdqWdVmCHza
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 13:15:13 -0800
IronPort-SDR: D5WkmLvCEcx0copGveyl5fwegi7YlZSRNL8tkc02fcBu+bQ2Ogl2zwCGIr7tDSdrr/7epA6vik
 MEVIaWQq0kEBQbpy7l1siPwglDgQ21whu/njweanM5zTzYoVWdTtgCSHeV5BxPeJh1jb1rMKMA
 bLAieaAdkOX0bcqYlH57JnzapBRanxoHUObQT3tV/ksf0jiFBWmAkzvSbSKJ9R6lmhH8nQlvgo
 MWVHYoOev968VJLdr/UbF2bELkieND6MCMNPaU5AILfdN8ZU6mN3M/HL4hyFmXrESf7a37D9W6
 LGw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 13:31:41 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/6] nvmet: check and set the right err location
Date: Tue, 16 Feb 2021 13:31:09 -0800
Message-Id: <20210216213112.20078-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
References: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_163145_597185_62F82616 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_execute_admin_connect() doesn't check for the right
error status value that is return from the nvmet_alloc_ctrl().

Check for NVME_SC_CONNECT_INVALID_PARAM & NVME_SC_CONNECT_INVALID_HOST
before we update the error log.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/fabrics-cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 42bd12b8bf00..cf0baa911db2 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -191,9 +191,10 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status) {
-		if (status == (NVME_SC_INVALID_FIELD | NVME_SC_DNR))
+		if (status == (NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR) ||
+		    status == (NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR))
 			req->error_loc =
-				offsetof(struct nvme_common_command, opcode);
+				offsetof(struct nvme_common_command, dptr);
 		goto out;
 	}
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
