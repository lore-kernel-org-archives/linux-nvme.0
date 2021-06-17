Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AADC2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 06:02:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A012461241
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 06:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A012461241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BuDDQv5Kfc78ix1C6ntYOS8M3X9dxDpq4IiKtbs9qJc=; b=rpRJHJqCWtktxM
	AUAnN81UpEwlxJRv1A05FdkmtyJn0sz4WI926QV5GXGYDiiPKzuhYETuPaelGJbc1owvz78Kq48KK
	+FaRpV38Dm7KsaKSgEk3OCB/hVndDmTIVKTmuR4bPRv9NiDcT02bfJHVRKeBSc20aKbDJHlYFVCvg
	9TMn8oq4XdvxXGFf/oO7edWPmk2QpB+cngh+kZt2zthsod0R9JtaH3NlfHgvLyYTpnVst/h/DZlqc
	7RzQf5fuxedzJi7cLi1UsVUxUTO8l/SlpYHfKt+ziwEwmamlSvKlxkaWoSLkjKFD9G8XseZNbPvPc
	eyheEHmgUmsg4bQdoE/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltl6q-0092tU-Pi; Thu, 17 Jun 2021 06:02:36 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltl6n-0092sr-OB
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 06:02:34 +0000
Received: by mail-pg1-x533.google.com with SMTP id g22so4069569pgk.1
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=qjqA3nA8Tl2YBMBX5M5Jdn9XuXHXzYsUtKNnmWCU9Ns=;
 b=nmHfpCNtr4GmAYArofqZQyiYhOEx2b+3cS0sMAKLWzYH5A7op0SLKAWlwvEOxp9HmP
 hAB/0FnuFPecXdhxeuhbu9luRDufH2lEvWN2h3yDp8b1BPor/n2qDCgz1iWyBUbetSf/
 uEuHqF2UoG2p/pLAmFiah88r/zYd5BYC0RQjXIZ2895+zOlP4NYBOzuFcpXCBI2U+DGA
 leS+gIGNvs/4nLSh5+dEKWyGmuVLGuHWw7uMYCCkzo5JYY0TRjbmTcBXr8FYtqzxpeno
 k0NkYV1iIC4gvcXsr5ih0HokqtAa2j1JBkHPAWAGPc2mm5V2QFBXXbWkmdBdqtLllDQt
 3FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=qjqA3nA8Tl2YBMBX5M5Jdn9XuXHXzYsUtKNnmWCU9Ns=;
 b=HQNliPqW9Joxsa7lgAMIeIKmHZvtVZocKkAcbo6xdDRMHL0uS3xYrEsbneZoRXZAA5
 SHjwg9z3RIb6VJ64QvQfuMnT/7GKZDud2oFA6UWk+J6/qZF1GdqYRz2eqVGHXbZjLDVC
 5RdFPOKTr55zAD7aRLfM9904bVbyZwe3Y3DK/+AisRZkj+ug9yByx3dYr7vXwpZX9O3F
 KEC0HJ+fb1V3kJB7hf3m0AFfIABghAhkL9Js9aH7UnA+l2+vBwv3rAzIBGMBVj7nVdiX
 vsXlmuuPvK6CLo2SLFAF3/hsWdRdXkXLIbED87A2dlyHLTynkm6QsivVXDdJm/Ri9lZr
 dOpQ==
X-Gm-Message-State: AOAM530fqLEXDeN7FY0cBewSjZFAsCXcWjXKz0bcQjd/KRuAo3jME+pQ
 5W5HNBSikndrWQ+z/pVK/qw=
X-Google-Smtp-Source: ABdhPJz7sBAS39BFY+QlEa8hF6jVMcgxy/VWDF85SOxrPW4RCgFPKSNKbDaZQcJfkrDwek8iiIADQQ==
X-Received: by 2002:a63:4241:: with SMTP id p62mr3538370pga.264.1623909752220; 
 Wed, 16 Jun 2021 23:02:32 -0700 (PDT)
Received: from localhost ([211.36.156.70])
 by smtp.gmail.com with ESMTPSA id m1sm4148875pgd.78.2021.06.16.23.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 23:02:31 -0700 (PDT)
Date: Thu, 17 Jun 2021 15:02:17 +0900
From: JK Kim <jongkang.kim2@gmail.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: fix var. type for increasing cq_head
Message-ID: <YMrlaTjfyy9slGg6@localhost>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_230233_831826_C8DB1C7E 
X-CRM114-Status: GOOD (  14.21  )
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

nvmeq->cq_head is compared with nvmeq->q_depth and changed the value
and cq_phase for handling the next cq db.

but, nvmeq->q_depth's type is u32 and max. value is 0x10000 when
CQP.MSQE is 0xffff and io_queue_depth is 0x10000.

current temp. variable for comparing with nvmeq->q_depth is overflowed
when previous nvmeq->cq_head is 0xffff.

in this case, nvmeq->cq_phase is not updated.
so, fix data type for temp. variable to u32.

Signed-off-by: JK Kim <jongkang.kim2@gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..2995e87ce776 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1032,7 +1032,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	u16 tmp = nvmeq->cq_head + 1;
+	u32 tmp = nvmeq->cq_head + 1;
 
 	if (tmp == nvmeq->q_depth) {
 		nvmeq->cq_head = 0;
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
