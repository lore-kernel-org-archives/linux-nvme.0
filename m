Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A300BC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C455207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wq99vQam";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y7IMzrbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C455207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sNwTBYN4NdGCFT/xNO/hBO3m5YSRoftZaIekRAUsaUk=; b=Wq99vQamyXdNlLmX5oSn4DvPn
	uOpxRK+MIPoTEEo3bfwfzGY/AJzHh8cAN1bBc8ewDroTzGQDkR7u0us1z2Uki9Dovf6VzzaHQYfE/
	yFi72CDpGXja4efIP3+V8vUVWE8ilbjfAquwZvJBM//YT69rioaf+bxmLFldPKoMIpfc8DuE7zgqX
	DNsrHRViDC/WNszQFK37qEPVfGBxP0/r+MDRm4DiFFOHvPuuyknesHjFcOBSksxaxDnETqPItapkV
	o4qJtdIgH/WgmClP0Gnxe4eLm1QQ5jP5VbJVq7KjR8bZu4JquNDAS6s9bmfpaut5mVsvd3gKmFacA
	cTCZiIZlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsGx-0005U0-SD; Mon, 31 Aug 2020 22:27:31 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsGu-0005Qk-Au
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912848; x=1630448848;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=olD5/J5IlIAeb4FZi2sdN90ck5o3pDJeBTUFQVK8xCo=;
 b=Y7IMzrbgmObwt1VDTYUBN7XPx/PsJgukbr9kQFAR8ACuHhcYNnRDqLuE
 FIE0Pp8zf9U7M3NGyKPZlFxfD0mHtQWz5z1gVfDDGxoVl/ptd9oBBnjCw
 qsp+OYG1bjjxHTe5HOvDKYpMAnB6Fe2f/oHEmVm4nejkTilN0RT/4qYI7
 TwF57bJa1Rrf6HQgtxssMnm5DHcaOKyJEVEoQ78eU8iQHp/HPtE8wNC5w
 c2zKFSf4KzVL1zlaHjYPNYaBDxt+IfuF9Cc/ft2WTbhoL69WgEceMzxxZ
 a1vL4sJjaB5A0vylHuRLpbhAQrCkZ8xTJKzZivMda4uA/Yz0b00bIzoox g==;
IronPort-SDR: sKAeWSWtAO5U/kknp1YS7Po7MjDLSsvUL+bv7rgDlrGewHpgfXk3GvrGNaNk5ar8+tCVvrPyKr
 bCE8fVy/yBU2tbH3VbDr3vh4rtz2/Hi6QNDzE/vBqGsjqvZVKMmKGRPuuDARpJA6o+LNbTdauj
 qZYWyEMxiF/HTMBE0L6doaETGLZqwLF9upxvs5ho8nq2J6OnT+iZdKAm9TyoHb3Dv5EjwlYBfp
 56VxczUSEw1hjjz8CfrqW7YZEULHSRQljPNZCuKk6a+c6/prUWeS/R7GszDdYIcqliZnBB0Ls/
 zPE=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="150600858"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:28 +0800
IronPort-SDR: 2Y6F/aBhAP6tgm1y7JwuD5+2zmWlVnETwMmGAsQwUTemZ5BxycIqHv+OWmpLgHcsEklo+Mczcx
 SUQh52t5hp0A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:14:56 -0700
IronPort-SDR: /MeCS+J6xajFwR0yXeP8FcA3jet22RiLDqeLCTdhNMVpQXc8UG3isor5T/2vfgs1qKIFJSwoqh
 O5x8HqJ+f6gA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:27 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 03/12] nvmet: use consistent type with id->nlbaf
Date: Mon, 31 Aug 2020 15:26:58 -0700
Message-Id: <20200831222707.35611-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182728_597526_34909729 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
index 18e96eda39b1..15dd63e14227 100644
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
