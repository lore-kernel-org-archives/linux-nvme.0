Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40190F5A8CE
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ks/kPV6KM5qh7zx8h8Sh9vjdlfuUH/Z42xMVQT+4k5w=; b=WCYbwEUrj35arTy6E+rOAEB0pv
	W0G10SWXo5JqFn2qujdWL6SVmGacT+zFixfxPR5xkGb5AlMKy8v3aqKIZZbrH/yW5Uu4DPGhF3HIs
	xvPHn+5vwti00iSAVX6SdvLtAPaxEMJXj2UXPf6oPmlrPsQB30tvBaZ5unmTQoEki2ohhJ2gn1/js
	oeMadjPy9XTMhcMbB8PS/YjVKgxxs0ntfw9WZpQQ3r9I8itXICB6hg/N3MYRRhfbg2BQoAwjmmmK8
	hh6A1Qj763gO2lJsfDhNUygb4vDh4PxUrDHqyjiVNVu64gA4YKBUeUBfppaLGtpydagLUn3SwSQkD
	oW6kh+gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wExrD-00000007oIp-1hRp;
	Mon, 20 Apr 2026 23:16:47 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wExrA-00000007oI5-3LZz
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 23:16:45 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso1258053e0c.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Apr 2026 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776727003; x=1777331803; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks/kPV6KM5qh7zx8h8Sh9vjdlfuUH/Z42xMVQT+4k5w=;
        b=qcNq3viq5WcnTj5EMpE7XVs96dJ0YkhUu4uyJ0a4h4tMGLOXt0hnhxPr0p9P8gCCiG
         a2hNsSeKG9hY6SLBVmCuG1hZEIDEkfeZ9MgJvq9GSAZ6OUS4kBWqzrSSlFWnUcwk5XI4
         /+x3cRbuow1dZYfCVb0Kh8nLC8O+UwwgeNoYcOO5aFVPezsY9hdinOj7x39CHjuEXOnC
         HbHz0Xeu8FOJ/iOkpLQrZeOoo32Rdd3B8Bz/9c3eSV7TdVFg1XfUA6u5j0Kpht68Xe8H
         nCvb2qKfzQrauFPI2DRf1bWkbEMxpccsHqalosg/nsF6VpEGkSlmr/jGE9/MEYKJX/7x
         NYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776727003; x=1777331803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ks/kPV6KM5qh7zx8h8Sh9vjdlfuUH/Z42xMVQT+4k5w=;
        b=fBiwOmk02gW0aTrM9hwTvRgAVKqfh5S7W07h8nZ1y+/OI1trT2JBePqj6ulUbUbben
         mG52TkdlTl+tjF6y6+uRCvu9eTKtBUoSTSNkO8X5gDT42OT05gxhCYecGQakDNb/HqxX
         ye6iwo/7mJg2ONmMWA5cqFGvSpjUSOhFornV7aMllCf89IxZxibFcslq3cwVQlAUwQ2a
         3R5JeAIX1HhATDTOmNcsV3RvTEizan18Xa+FpSQiBiiTAsYPhpsJGDrLSiDEC47IO0jD
         zM6y8/g0fBKE1Wm12n2mds8Qw4/IM6eqFHt3ndRWoYXtTHp7Yk9Hao+M/Fpgt2Dr/waN
         FETQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t9ewtMmU6qllshUbsyIszy/duxxxrHqHqg8fkevqF0RuanLs0dAIShpFFPARfLMDOTy0ZGViu1I97@lists.infradead.org
X-Gm-Message-State: AOJu0YzJwOozDEcspByw/m1EqadD4HEmDXSye7QrHDvlbPji7FzTpozf
	Fxko35k+WnrhyuvgP1vu8dVuGPEy4jdC05EzqxYD0fSGWukmxzb/eBe+
X-Gm-Gg: AeBDiet5QrhZ4f5A+IcRw0eP3bwkV05s0FWepS/SpRIcZTaPm6+reSwVAgsqbTvIfw6
	gLFEgrRTptu+BSQNuWmyPkUQcJS9tGnfJlRRbDIwQlgI09kLaQlqCYm7lECO4RkbLF718HcIUgu
	T3bgGRw+7Z3d5fpJqvyR9eaF33qIVu6vYF/aVvQTmnSXcOVRIZp+TU0Heex8kUWevQcZcaeWP+A
	qf/0qQDawAWWH6Q3lvHkDoozVWemLujxC0SyFg+c488EKA5kM1FWA765JNkNlxnKKezdhufq7pU
	NdIZjtnhhI+W5S1tTO08XEi+HWvYfSDuFdNUlCwSXNnoblTJ749UMCdJtb07bC0VCXHaDTeN1cK
	jDHmne/LKDdqzXtTfjY5TDPOHsMokTMmerGRNw5yiWyivrm7zoU4Mo+TlXf1ieOI1i8XHvGCP/l
	vuS7Up2p58obQpEdCP66BrZuAk2kOZwr1zPR90EsTYUYiOK/MDeP1G
X-Received: by 2002:a05:6122:1d91:b0:56c:ce8a:b07a with SMTP id 71dfb90a1353d-56fa589cdb0mr6794650e0c.7.1776727002733;
        Mon, 20 Apr 2026 16:16:42 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93253aesm6835593e0c.14.2026.04.20.16.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:16:42 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombardi@redhat.com>,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH v2 0/1] nvme: core: reject invalid LBA data size from Identify Namespace
Date: Mon, 20 Apr 2026 19:11:13 -0400
Message-ID: <20260420231116.748204-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418042835.420281-1-coshi036@gmail.com>
References: <20260418042835.420281-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_161644_861475_C6FBBC7B 
X-CRM114-Status: GOOD (  13.58  )
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

Thanks for sharing comments! I did such changes in v2:
- Remove Fixes tag(Keith Busch: ds has never been validated)
- Change -EIO to -ENODEV (Keith Busch)
- Add missing "queue_limits_cancel_update()" in error path (Keith Busch)
- Add warning for ds == 0 (LBA format not available) (Maurizio Lombardi)

---
On Mon, Apr 20, 2026 at 02:51:00PM -0700, Keith Busch wrote:
> I think ENODEV is more appropriate errno.

Fixed in v2.

> you're missing the corresponding queue_limits_cancel_update() for this
> error case.

Added in both error paths in v2.

> This fixes tag is wrong.

Removed.

On Mon, Apr 20, 2026 at 02:22:04PM +0200, Daniel Wagner wrote:
> This fixes tag is wrong. Probably a5b1cd61820e is the better choice here.

Keith pointed out that ds has never been validated so no commit
introduced a regression — removed the Fixes tag entirely.

On Mon, Apr 20, 2026 at 02:22:04PM +0200, Maurizio Lombardi wrote:
> ds == 0 has a special meaning: 'LBA format is not currently available.'

Thanks,added dev_warn_once() for ds==0 in v2.

Chao Shi (1):
  nvme: core: reject invalid LBA data size from Identify Namespace

 drivers/nvme/host/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
2.43.0


