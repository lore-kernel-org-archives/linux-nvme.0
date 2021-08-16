Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B09C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 18:11:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE43360D07
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 18:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE43360D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=60tTjC7Kk9Zjl/pUiDcS3Ug4pFBPCrwDKbaJTBxy0Mk=; b=fTodC9gYFBErgm
	7Yyk/U6K8wK2XFoxX21rD7UUgVNZPeJsnYvjTKVmM9ezYHk+9o38EO0hwqOiXUYpQcOhTn1syKzuZ
	S/fCpt4KKhP0npBilQwVXswiqd4EEnmxWeuD5njiqJR5gvH2JIZFK82czfQMqa0GKqvRsfJOpUkN5
	jSE+WBXwr9L08o07Yfo9cYCowxCDSuNcDVG6kJR9mhTp7MN0WlrijZOpB5iu8oER5OBTfAx429dOD
	XZSBHkKkk3vsF65XhInEol9bS5WHltEz3BEjR3UtU56LA0HdDoRIu7AEWjOia1Fak7ImLu5xcLuyH
	tab15R/GFG/ygytiesDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFh51-00HZ7Z-SU; Mon, 16 Aug 2021 18:11:23 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFh4q-00HZ5y-2w
 for linux-nvme@lists.infradead.org; Mon, 16 Aug 2021 18:11:13 +0000
Received: by mail-pj1-x102d.google.com with SMTP id
 u21-20020a17090a8915b02901782c36f543so33793072pjn.4
 for <linux-nvme@lists.infradead.org>; Mon, 16 Aug 2021 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+8fWaGpEqm0oyTu4waZtiVggNWTxRgnVj4sFm9AFV6c=;
 b=cfb1g6QLkKScbhKdKEnNjjyD30gUYxmvND5pHQMSswYePz05mdEWtxcpIOqO2jlFfQ
 Z3RFogsunf5Jrp1o2Kn8v271YHIuFXYpamzxpj3AQDopiQUewLbR694citbjBl2Sux9a
 g15Y9Mzc5/cYMXTbfetOrbTPZsFiBP4oMNSpWvXPNnedH8b+oQYqdhv4rFBNR1ZJ+b72
 Obi0DvXk2g9FzAqg/OCK1arfKop//xA48vi1JGro0S+QkEtx/LRBudTAAeBOGZVMmU9j
 UEBKoVrWkYo7xWFT5sEDfIXHGRyJctcyHJqw2xsfXMn7ujCV82oICt+D+CN16An4D+iR
 fZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+8fWaGpEqm0oyTu4waZtiVggNWTxRgnVj4sFm9AFV6c=;
 b=lYSijAMrq7xt3oJAuScysXTYc0z8VEN9X52HkEYcidWjaef/N91+XmwQLZe1YEA5mE
 e7cDqzN0nX79jhfwjlErV4MSX1PSmmhbFZ/zQ5pPGmih1Am9GIs6pPS7BAgyPPG+DN27
 6TCBIj0lT3zwjPI/YLr4jrMoeTk5200i5kigiKyzNxVSGS+qy8+svTKDSC/6ZSxlPcBi
 8ZsI4SuA7Idk4Dxyu9N9m++8NoY1auYKzJFxSqzdG52mEugyFFl+SB00QqCBcuCSa3Lh
 qqKI+FuGG9mNfw8lo5kKXzzgXSOfpx14o8EJfKYwjLIVm8w8E0BVOwXXP0EgTsQL/+2B
 4PHA==
X-Gm-Message-State: AOAM530TcKYb4c+wi+CqhjWxnmpUGNnFAyTFMbyMG7IA7u/RHJDWfqGO
 uXyNSsE19XO2bE1DIWp2ZY9doB3dAEmQXQ==
X-Google-Smtp-Source: ABdhPJweiSeqZ4Q91/A6X6Q1esufUnPRV5qo+77oWac/++FCdCh9FwI8Mda8SLICWZv147wv6PVdwg==
X-Received: by 2002:a17:90b:2487:: with SMTP id nt7mr442502pjb.6.1629137471192; 
 Mon, 16 Aug 2021 11:11:11 -0700 (PDT)
Received: from ideapad.. ([161.81.119.34])
 by smtp.gmail.com with ESMTPSA id z2sm80731pgz.43.2021.08.16.11.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 11:11:10 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH 2/2] nvme: round max_discard_sectors down against
 discard_granularity
Date: Tue, 17 Aug 2021 02:11:02 +0800
Message-Id: <20210816181102.4412-2-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816181102.4412-1-tom.ty89@gmail.com>
References: <20210816181102.4412-1-tom.ty89@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210816_111112_168928_66CFC7A9 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3a1bfb45da2a..dff165b92ff6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1636,6 +1636,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
+	ctrl->max_discard_sectors = round_down(ctrl->max_discard_sectors,
+					       size >> SECTOR_SHIFT);
+
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
-- 
2.32.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
