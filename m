Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33268C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:07:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D0F6008E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D0F6008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7cIzGn0TP6Bt0WWoNpBGarC9If4FI/PXEhThukWOrcE=; b=MYuHDvDLFwC4i7rPE5qQOkVu+
	yTUDeBpRS7Wybnc37LYUnh2dTQldSPksq3Sgr8NT0kbeXWOXpVpNQJhQt3lDBEc5Qk47HDMYoYxuF
	4FO6vTpgtd6zoxwfexPcSmpC59MXiD5pfwJGWp5BHJh9QifCki2DL6TldnFuX6QNRdLGU71Kw+vjF
	nh5Epg0jyS6CM3fOSS5IL+ZCVSDie3kevS550K0htn4YdrI2NRCnRPA3GZc8rD4/8OGyFx5CAzUO5
	wcCpzmvbHRWHc8ueLUnadAxm3mBNVNkCbQUWY349UKMSLdihf/J8ZSF0bshP8PEUZ9JPJl17cT+zN
	Z5i8XA4xQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lirwT-00GyMx-Kr; Tue, 18 May 2021 05:06:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirw8-00GyJX-1d
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 05:06:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=T4qkEMoMLwWq+h47lzNUW5CxgVVW5AeXY0x8Rif7Emo=; b=iKQuvI8e/lgS88XDgJww6RODut
 sAY/MKhf0+/hfV5XxBE+uqT/bO1ZDTWlKlbUk1TenmFHioOZ7Tnuq4ikNbIbgOtCpIqnvQupRhPOU
 i4VqsB6pAGXxHLzm6Ycoo/rChLuVczRfY8hQ9WyrgJYHLTVGlGa2Owh9eLwi8EeGBCyXhRw/iStN5
 /yt/VSxwUwtc7Vt9aMNPAjRfdSY2rS8aum5WdxmDMjp0Q8Q5/rg2gkUVIEcVkyMqWJf/hQ4suSJF0
 KEfmedfR6R6eYTMQ0PYuQ4ftem13o//43Cy1prVFycdpB836tRYSFypLpBXq6K3Rsweb+9CtpnxPd
 uHMAXU3Q==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirw1-00EJcL-FI
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 05:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621314444; x=1652850444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=govE5EyMNYkTgVrg50vScRnt2cW6vdBhB5RHB3V3SAA=;
 b=aj0u8SRt5MthuNR05AzZizG/otgOkcv/hcTrr+um1J5fiPP2bo2hQlKO
 046QmtZ9oh6B9vn6Ka7B2t/PtrkyJMFDUCsfMHVoCbP1uD+kUkN8yBA9E
 PzzcX+w1uyTEPe9PNsvK2KHhNRf3b7f6Sr7CKfj8GEVr1RfTJqYcI6rKV
 pVo3U4etHjLtptqSCstYrk7/fyif8O8Za9PnxpLnL3pFYFLB9CFV707oi
 77DB5Qn+0CowA+ifxLKe2CCCp/FqlmDCKjZjBspfg5fzvkS79cHdCTejd
 BARcO2lOZ8fdHJQQdYBj9lsqp3/G4RR8+qkxZwFAe/9aKSNhlQC3hYeli g==;
IronPort-SDR: B4ul5xBFuZGHlhxaa1geoVvz87TJlpcrqy7kFJCL4J3nVTeyDfWcVnGgyrDeEr57nj1fFEqOTD
 UJyOamO76sAl0THdrqRGImistZ/TARfNcN0enZWeMNnN2hBYIA4aWDrkYFa7D/Otm+gzmXNrp+
 hqe0QfDbu13wJQM13R0A3hucUYUqiNiNLMnLgJWvxg3msBv0xR1BUPIBg5bYA5+N4HDSd5Gyut
 jaRTm1IL6J4hGRsogRqx/rE+AiBwHpUCb76o+pRmJydQku/Tllkqt3QPwsKmqZ85bcWcZz0+jQ
 r5U=
X-IronPort-AV: E=Sophos;i="5.82,309,1613404800"; d="scan'208";a="272473201"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 13:07:19 +0800
IronPort-SDR: 7XOpKDTAEUFrWZJF9acSdERoZ2uQhw1MLskDlvw4t9dZcqh3YcUwZ8P2jytf858Bb/tS2Xinhs
 phzP1Zxr3+7v4U+idQOAcDByD6bS/o5vGhKC4lCA6dDr9tMIJ2wNE/vblhhx1fb75+YSYDJRJS
 F3TwQ9cyP6SZ6Qk4fkmS3fqK+R9QjfiX7+alghGwpPcYXFtb8414FpE3t4erZhHw/DoodpI+Bx
 0uT40tYzRYsk//JmK2dHtSpUlwKj2y7HZwyqKu0OY/OyMpOi+eS05H0f+rE9sbwDpLSrS2jzIt
 GXI/0Oc1BIzHf8Ljb7m4GClU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2021 21:44:47 -0700
IronPort-SDR: 5TnFcFqeXIfJQKMnWNTxiZKTuAgcoT1pBnxEgH5Qw55q9oetRPd56DXymrWqQkDJ0X5DCTR1sm
 NpyIskt+0//ytuNEqn/jWlzz5Ke929TCiYNwuhUR2lwM2aG8Nm13equI3xQzjrMuwrw0Fm6O7D
 5mzxkL/zO9QSpU0dqE1UXeEsLsxd7mDuura9U7PMZ07ifL2+NL/cN+GM/IN88QWBcBd6ha37N+
 WUyh+P4ivkiIs0YB+0992ueMnsV+iy+2hI+LW19vkq0yerOmaJdc5/87+4VRdBsVNtAGoAWQq0
 7Pk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2021 22:06:21 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/4] nvmet: use nvme_nidt_len() helper for id-desc
Date: Mon, 17 May 2021 22:05:56 -0700
Message-Id: <20210518050557.14961-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
References: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_220625_587965_C31AE8C2 
X-CRM114-Status: GOOD (  12.02  )
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

Use the previously added helper to remove the open coding of the
NVME_NIDT_XXX_LEN for target.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dcd49a72f2f3..1a58719ef952 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/rculist.h>
 #include <linux/part_stat.h>
+#include <linux/nvme.h>
 
 #include <generated/utsrelease.h>
 #include <asm/unaligned.h>
@@ -622,15 +623,16 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 
 	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
-						  NVME_NIDT_UUID_LEN,
+						  nvme_nidt_len(NVME_NIDT_UUID),
 						  &req->ns->uuid, &off);
 		if (status)
 			goto out;
 	}
 	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
+		u8 len = nvme_nidt_len(NVME_NIDT_NGUID);
+
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
-						  NVME_NIDT_NGUID_LEN,
-						  &req->ns->nguid, &off);
+						  len, &req->ns->nguid, &off);
 		if (status)
 			goto out;
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
