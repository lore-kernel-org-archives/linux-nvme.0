Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9927C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7911B20774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oij6FsLL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Koq9tfvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7911B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ENmoIKR3PjHryWk1xkxkFkWh7Czo9afT0G+ihX/3fkc=; b=Oij6FsLLOYWIAYYQw68T21+Cj
	xIIw4IWymt03Ndb2cE5mhSO3ri1CskR2MUpZRHIkFJoxgmjX1fo1SrZ556eJjy00DaJx31Xzyk7X3
	x68Sistv1odW9BHliDWV9oBZk1CONxX5MMonB3msk9tfjinPKMb2+qWFi9kqY3qj0U0UDFedxbGbg
	sbdQZj4YYy/3Si8OPsoDr+njprF8KRooFbMHypzCqHNgS8nKHmatL9nJ2mF2bC5IkHO5dDq5R5/gr
	9e1k4K4tbGKsWRezdy3k1E9BTKxB/pEP77+KOlBzzFevdd1jYAzRfeeNktqFujoJQOxctcIRw9TyF
	PGStBb3+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5CxC-0006z4-Lk; Mon, 10 Aug 2020 18:55:26 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cx9-0006yP-SA
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:55:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085724; x=1628621724;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JY1M3o5sZxQ+t6ECekUVLdULlRhdsJKmqgzbag7Xguo=;
 b=Koq9tfvQzCf7OL3qj/1Qcs+1NLf9F0yXXVjbTUj6jaqk3BNJ3g96b5d+
 Z2zLh7GJtSF5GgMUcwWd8VWoX07MLZs1diox8bzFuHUrH0TAzWO+FwyKR
 hVhOzrGzMPBN9VNFOVyGljbh/Cr7CnOBSnt6pKY2MhQf3fWlQBy18EMvP
 O95f70FkV7Ux9WlLK8h8rqVxEfePAW/C/fIm37R3HUUrQuS8Q/ZBNCiLO
 7lRzqc1h/Ky878bWQ3n4kPzRHrdBVgvpKOWFOq+Ar8ePAIsatf1QsM6E2
 SZobRulVQGpBT29VXbU5utX85S+/Zaz2ry+DOUYeXyadk+ygYJImmhqpa A==;
IronPort-SDR: wRwI9fbaDhAqPXgkb+B7bCgVY8vZ/FpvqZCqb4wnE2bB8I4arvJFzliSQGGyQ9Joj3bIw0EkiL
 z8VwPWZO5bab+Ekoexk1aSxUZ1FLFkTzFQmquEIYSAmhYDfn9Xan3pMDCT7GIhNecHmArwNEv8
 k984tuLPDEmIWSJY6wZTfB3bUu81N4Own4T/XQJcy7u0jurMiea1qqGK2MoVtp6DsBLjALaDIk
 XvyFakiJrbeM7IeYrxT05clGKYocy1aRXVOv13OHatWnYSNtkoLd9FV7gdmObPm3nneeyF0U5k
 mmg=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144651205"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:55:23 +0800
IronPort-SDR: zBKpBZxqHSjniPQY1gjWbbXwecd8iSI/SrtfyyiXIWnxB6IRqxVZGq3jMkkdAcPB6Zn8v1W+h2
 z9AcGXOdReXA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:42:33 -0700
IronPort-SDR: qFIIOV746DxkB04B2Oh700USFJK3WnXFTZfyn5nKeGm5+vzKAw5j/DhBwFoE4TE/hSxlCMGMav
 no14D1or/3SQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:55:23 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 03/14] nvmet: use consistent type with id->nlbaf
Date: Mon, 10 Aug 2020 11:54:45 -0700
Message-Id: <20200810185456.7713-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145524_502027_49BECF23 
X-CRM114-Status: GOOD (  12.86  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In function nvmet_passthru_override_id_ns() while iterating
over namespace lba format loop variable is declared as int that is
inconsistent with the id->nlbaf type which is u8.

Make loop variable of the same type as id->nlbaf.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b675662654ae..13d73f36e927 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -112,7 +112,7 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 {
 	u16 status = NVME_SC_SUCCESS;
 	struct nvme_id_ns *id;
-	int i;
+	u8 i;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
