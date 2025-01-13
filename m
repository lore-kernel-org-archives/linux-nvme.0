Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55636C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xoRcpfCn/zOzkb+79WN2x/MznYZxVGzTkR1Ql1vVmo0=; b=qkVfrfw6ZiOGrnUMrc3o3pCPYY
	CNfBz1CpsM9jnOlmZz9PtTe4imJ5yZMoBxZlBhk45MX3p+eFVF7HNYlgzCZYMl1pgC2msM3WTCNmS
	eYagzZpeaasxyk4D0iPsrq+/WqXc9pUlg3iba8yZ3FXmZ8Dn4FwqZSsz7ytxI672HCAxNWu4qd1V9
	/Vci5ZAdSxp5oWIsMJfzeAqsfRaY1MlcEwGeLUftsDsRCbGh2BkpDpqqmH8V+zaMji/AHv8coZHC9
	GuoK0h/7MeFGwrNVYpmTa+Rr80VJm9d0nZC3u9G+YHz/2HQoS8VVHgLJ8+uOf2tKuay7QfAscMt58
	7Bz8gpZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOGS-000000062hl-3fMA;
	Mon, 13 Jan 2025 17:30:12 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOGP-000000062hI-39xl
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 17:30:11 +0000
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso350155939f.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jan 2025 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736789408; x=1737394208; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoRcpfCn/zOzkb+79WN2x/MznYZxVGzTkR1Ql1vVmo0=;
        b=au3C+MKzkma69HDYhHQvR+jxc4UMfCrIhV+eDGA/OWwh+zK5WP3G5xwTzfEtfFMGzK
         Na5ndLTXqodwt3gsazmBeLC9Nv1gmJx36vbUZtni3A18nGkat276dQVJaMt4XgpWyExj
         XAD+3y4CaPqD+c4eZeC4ed+EUINcv70by3D0dXC/nbp4hVK8AU6QQVM9fZiy4jHl9+fn
         LkftMSNdLyH68254B6jeMmYFvIxK1TNZ1a7DRC0UY8wJgnoF9H/HXXHZ5M4BUXJYKkkD
         6t+qpgNzo2MYkQ4WkPQ8iHdsIAOmPFo10rdmKVP2t06qChFJIdRMI0rnncN2mcNVngMS
         4j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789408; x=1737394208;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xoRcpfCn/zOzkb+79WN2x/MznYZxVGzTkR1Ql1vVmo0=;
        b=tNjOUvpotXln7mQ6zPJxEOXgIbPDsr/EpM4LmFwMHqaAc620uj043Acz6+gAHlbpjZ
         DSMoasPCVGTjVRAhGp55ZcZwlSLSbHf3nOgNe6mLW8mSJsXaWPaHGS/fYwPBDLdKmi2r
         OSEywHhV0IVnfyK7aG5X26mR8FNFi/XxoHewIKtNm51bzGBUD1d1wtDxVwInyBLQHr+y
         p/BE7bDcb4yTCB7VPpUBj02W5tWQDrUbq2NxhNzvPIcnFpKtgbttJuiVbWpa/UjBs2u3
         KR6V4AaAePEbYAi0Nx1dbXrzptZuP/3QNHxtBYx+dCt/T0jGeWxkElJI2pW/wbr3d40t
         sz1A==
X-Gm-Message-State: AOJu0Yye02QoJAs60cinGVKLHwR8brxeezW9/5wnJt/Pib14OfVwtjyl
	SAAZg+wb3mv8kgd/rXqePJvS85nuQM8Taed5StU2yWGaWgw8a2ucHEar2ki3snfXgIVT4PuCGoM
	K
X-Gm-Gg: ASbGncsHpF/j2SDvX5uIASvfF+AgCTAK7MpLeRiDYJ6bUrP7uePC6Ovjkf0pod6dIoc
	XKBxye9KVOUrCRVE+vSSz4IOzzjyQRg/Mt+Od3bhwDcVcUDakYvXkEv6lIJ2btiN59yk3lz/gp9
	atmv9JheDFAn0DYfU1ij9pgfAV1kP7mQF/gEx6iFgUni/dupuQ68446OphrepCKKjbYsq3smMeC
	d8FHNDoALO73z4MhxkkBufUC9ADtme/1XXoFheQyzEVTY2pcZT1
X-Google-Smtp-Source: AGHT+IECikxsWCNxNnaV/pkTwzo9j4x319/Ecbl45eTO3TC05feItG64Ptt9BJnDYfT2ojdubKJPYQ==
X-Received: by 2002:a05:6e02:19c6:b0:3a7:81a4:a54d with SMTP id e9e14a558f8ab-3ce3aa7c305mr178899665ab.20.1736789408236;
        Mon, 13 Jan 2025 09:30:08 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b5f9385sm2858813173.3.2025.01.13.09.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 09:30:07 -0800 (PST)
Message-ID: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
Date: Mon, 13 Jan 2025 10:30:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, keisuke.nishimura@inria.fr
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: fix bogus kzalloc() return check in
 nvme_init_effects_log()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_093010_060632_9A606F4B 
X-CRM114-Status: UNSURE (   8.80  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_init_effects_log() returns failure when kzalloc() is successful,
which is obviously wrong and causes failures to boot. Correct the
check.

Fixes: d4a95adeabc6 ("nvme: Add error path for xa_store in nvme_init_effects")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Caused a boot failure on the first test system I tried. Not sure how
this got this far without being seen...

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9e7f1bb81973..0d21258e2283 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3182,7 +3182,7 @@ static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
 	struct nvme_effects_log *effects, *old;
 
 	effects = kzalloc(sizeof(*effects), GFP_KERNEL);
-	if (effects)
+	if (!effects)
 		return -ENOMEM;
 
 	old = xa_store(&ctrl->cels, csi, effects, GFP_KERNEL);

-- 
Jens Axboe


