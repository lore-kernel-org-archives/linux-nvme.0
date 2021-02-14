Return-Path: <SRS0=P1pc=HQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97240C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 16:25:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B8864DAD
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 16:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B8864DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ADXuKkQ3vxsf5XesylTQeAta9TWJq9UIqSz17YZuC+M=; b=Kl52Gts9RNRHHRuzTm1Vyk4HVq
	6w0G8gGkKg29LuN7EUAlo7qXHL+wxbNb2iNSJkTZT8bI/ySU5xsGNZQ2TrIElbtMvzp/j4pfY2gjU
	2tOX2orLrnlu2j+7T10vUnxC3ESE9M8pV3U6+FUsDOeOFoFsTyXCfyXVaVJkKx5ch6H6Fch6tONvD
	UaxfxR73t/2yVV0gHgdCGuckTbxKiweA+dORD8UuzQmz7Y/Orhp3ph/Xo7rKOTaaRSpMMQeD12Y1W
	i9P0WOq98gFppuaFi12OSNgySNHBVoR+YeRQxiGMMdgbge/Z15qeiYsNtbyKltmYEcA6tq4FIpWGD
	ByKgNSSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBKCs-0000fq-Ce; Sun, 14 Feb 2021 16:25:10 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBKCo-0000fE-R4
 for linux-nvme@lists.infradead.org; Sun, 14 Feb 2021 16:25:07 +0000
Received: by mail-wm1-x32a.google.com with SMTP id l17so4097727wmq.2
 for <linux-nvme@lists.infradead.org>; Sun, 14 Feb 2021 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=+ELaV4chu83srt4ZWuqhrIlt1vL+m7Tn2tkWi7YiaVg=;
 b=cuFTJyDS7BJjedLC/SA7iVBxyJzGZfwl2gz92lpVrxoZycUvEkjYhi2c/vpubAVgeV
 MO/FD7lRJUS9TjC6P14r/2+iDVZiUiMacr2hC4oSWWc87W/6o0xqtwcTjnoZuDrPEnZA
 H/hoBG46B8J5CdZQYHA5sWv+GHiLetUD5+xaIlSNWAmQopy8qEn8ZnN4+5fIcVM48NjI
 MXpoayHeKL0WoCKt2iC0oqhTGLawXPshorLZav5v20q/u0b6+u1UwmIC44GeDA6F7CDO
 fmLs9QPesatnA9BR77aTpGtBFeq0RaEiiz1B+JHX80h0oOhVTaE+ZBXaOSndNeXVlfl1
 lmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=+ELaV4chu83srt4ZWuqhrIlt1vL+m7Tn2tkWi7YiaVg=;
 b=jy0bhp9fjQt1W0ld9ebCRsXLD2dFBh9HsIuq3/ZCEV7DPnDxEvryE7/oQHe3e+KsUj
 EN6cJd0qlBangHH+WlmZod/mNKLCWALQrnUT5NpYkGLljsZHMIVMaZ4LZPJe8LPLOSfv
 bhXJ1xprXvJ5CqqkXV3tVqPPs66Yx8kyY5x+cpL7fsamwOjeAkNhmFOmK4Rqd00w+T+G
 1Y3IINNhEV67htMxO8nl7uEkIfHaKCwbQ4Xd9JrvIrTTF1hvFAH4MHaBRIaHAa8gxT4L
 RHPtPoxl+/ZlUdLgnvge5tnhbuENQyd4d4Kfqg/4G4lWZVfTAqubW+v1I+4eusCVNRB+
 /wPA==
X-Gm-Message-State: AOAM531hq4nYm56FFEwm4x8pVoe37CY4wwVXBEAGaZX0YZDpA+775jcT
 +Yj+bKDozP/60hWavvMYVUkUzBAch2Yf3g==
X-Google-Smtp-Source: ABdhPJwAmdEXRvXI4Vca4Tf95d9DadY9VYyuXocGNP1ny/aF+5u7df2C7t9ggSq8BXY9G7d2A+VoTg==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr10569695wmb.117.1613319903352; 
 Sun, 14 Feb 2021 08:25:03 -0800 (PST)
Received: from ?IPv6:2003:ea:8f39:5b00:59b:23b9:f1a6:60c?
 (p200300ea8f395b00059b23b9f1a6060c.dip0.t-ipconnect.de.
 [2003:ea:8f39:5b00:59b:23b9:f1a6:60c])
 by smtp.googlemail.com with ESMTPSA id l38sm20236908wmp.19.2021.02.14.08.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Feb 2021 08:25:02 -0800 (PST)
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] nvme: use lighter smp barriers in nvme_irq
Message-ID: <1c90fd6a-d991-b347-479c-2c8ae5a4c51f@gmail.com>
Date: Sun, 14 Feb 2021 17:24:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210214_112506_927644_FCE9C54E 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Based on the description we should be fine using the less heavy-weight
smp barriers here. On x86 this would be compiler barriers only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7b6632c00..59fee4a60 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1066,10 +1066,10 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	 * The rmb/wmb pair ensures we see all updates from a previous run of
 	 * the irq handler, even if that was on another CPU.
 	 */
-	rmb();
+	smp_rmb();
 	if (nvme_process_cq(nvmeq))
 		ret = IRQ_HANDLED;
-	wmb();
+	smp_wmb();
 
 	return ret;
 }
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
