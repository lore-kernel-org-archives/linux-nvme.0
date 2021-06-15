Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A113AC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 18:58:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660B660FE6
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 18:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660B660FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AmRVGzYQBuouez3r9v7vQ7pl8pH6k0hsQ31OhZv0ED8=; b=rzKE1/f8uYLqLY
	6gSyyQdH/JWaUnMFCd+3xP9X7+6a5r2VwkFos0HE4ucOGoK4ilxymq+B2yCjdi+YqadYovK7PhYOo
	/o9tMCgh38MWK6p4bNZx1IFf74A3vaPz+VybZA1Kc79J3yqgJfiYdFn6isXutBhbtXtPdemN35xPW
	bdB54CCLtGTDcksQi5iSzxStMHiq2hLPj0Rdd6t+LCg1nGff+27dwU85vqWbC3pcqT4Ep076ASBQf
	0FRm/gfuD0F4Hm19dMOgUMnEKhlLtfoS0U7nw7etQ90yoRIdwLWZJOAyOhbOU2J5JPGzT1IPAA/wJ
	O3+4MU0UwvX5IQNjFipw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltEGF-002HYH-VJ; Tue, 15 Jun 2021 18:58:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9PV-000DEY-3X
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=HJALBhcYR4KNVbLJRRuBAX0LppBHGN9W98RdT54w7Lk=; b=oFC/EApkH9qPKFGbqFkCo/ba5P
 6XP9jJDTutXWK96B0H9xOI6jX5jiAofNksOukU0fS/zj2/kbMfVWAYXdklwtsSU6JGnvh5U36AGi7
 JI2iNp61L25rFaO+CUdIXANcqrFw9T5zA6wh7TMH5H6nNv8BQ1GYgnwtpamSTDf7362ad6qFo6Byz
 KQEWNHbnQbl8MRaFhdtDpTqzwm3Wso4G8USnVAWyZHzDLRcWtZTiKyqOlwUt8nCZWK0NAifPceIgG
 CVhwFQ8quJkgSvGNqrHtgMDouq2zgWp5UiYW+e9dQnoVuKdxB+/m7sKGiLrjis5InsIq5rdpqrhlD
 c3QAztmA==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsz5X-007H7k-0b
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 02:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623725168; x=1655261168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=id27J5eHSZOOGbUu03TwfG1eRUDQgJMKQC48BztC9T0=;
 b=gqf/6pvUd6/FdlbfA9dxSgoDpTSl3JNcszbSO+WMNg0YqmjQMVKISSeY
 lYANSjfEj6+XHj9sNaKmRSyW9YhnRGVCmchgOmikOUlord26mJTpaRMfe
 h6KIdUUpe3x5eu6r7G6dZusdfzaupNunV0u9mI88+UuLjoyoZYPTMy+zC
 vdXbWr3Yhy6pEFcElcmdsY8ucLyzs8YH4Jb1+F67cb1ERR6Me3pH17THx
 G1V8yPFq2CH7atEiflDZT6aTZdrlHKfSkB6Ck0hm0hnXi4U0pIQg/S9hv
 C1pu2vZmqM0sVxGyf4Pdrr4Dw+Zz+eV5RM7mYgKuNbyUo/EcBWwIpLIZb w==;
IronPort-SDR: JcITpAZoQaQGS95ForBq0AWTaa54UQP7xQItDaa7aVgwbxRM+ILGFOnDjyuShdNX3dsWonD0Ce
 vVchCGgDJ4OgjFTyleHfKmTQJCBgKnLAfLmeT91An4YyIpaqohHwK22U7yRekeg9Lmx4LrUv0z
 1cyJ7zGfqKdYFuIMBR3ocxIklg6kxunmjsC2Fvc/We6uzrjx9U/BaEeVYxPrPDdXRSdLKhSr0j
 R88MnXv/vkkGyW5QSOKLjQiYFxQqGwzz1R2Vw3lcSy5JxHYbIwZ8PVEMOR/perwEl42HXX35lw
 Wpg=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; d="scan'208";a="171905927"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 10:46:06 +0800
IronPort-SDR: KP02L+Ase7i6IPjUu1oeUvp6wZ4j2JE2M7ie+n9PZHk9qA6xfAtDWcWi9xR6j8X3sTZomSrG7q
 f4AoiF2u7RQQ1Z164KI4FyKejjURDh/RRaUCxhLkxAyeWSRgiNcB5Hk5MmaZAt+QXEEg5PeRgH
 PuR+EWXBrzM1GXfiJOfS7AjJvIB61ilVhLdlaEYTy8e31D7fj1acsTGu96OysLDaiE5OM9uWgy
 cIjVhG83rnTN81WYoFoDpW/vJZfFFoJUkW7dtVygqScyHyW0Nk8yQuiNagVfLRGe5usMjwjM/u
 PVEZBIWe4ijf3WPmIntUwefp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2021 19:23:37 -0700
IronPort-SDR: uOED7fXALGRblbKJiGW2v0TDBHtfmDQNQ7tPAqDupeO6IFJCkYjW13VVql3+KPe26wdyFd6qI/
 z13rbmbsTSxwu141V+ansrx4IZFcLtU+zcYO4rDFK3sNLG9FOBL1NUSs7lpRBQ0g8HZuX2sROv
 saKysDkJi6OydN2n70FBdxl0TqZHP+vfu8wpJsuF0VcoLSSjT3/nSSVanEew6D70L3yGix446c
 e0gIFUOibmyBwgynMoZb7cNJXsyk+ppCXfdHxo2ZCDmFVyrVJSxX++1iKH1bJxuc/ka8Ruhy05
 8qY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jun 2021 19:46:07 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/4] nvme-fabrics: remove memset in nvmf_reg_read64()
Date: Mon, 14 Jun 2021 19:45:51 -0700
Message-Id: <20210615024554.42585-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
References: <20210615024554.42585-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_034610_638878_D64248C7 
X-CRM114-Status: GOOD (  11.55  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Declare and initialize structure variable to the zero values so that we
can get rid of the zeroout memset call.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fabrics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 690e749eee83..506bb976251b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -186,11 +186,10 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read32);
  */
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
-	struct nvme_command cmd;
+	struct nvme_command cmd = { };
 	union nvme_result res;
 	int ret;
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.prop_get.opcode = nvme_fabrics_command;
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.attrib = 1;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
