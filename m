Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635D1CD5BB1
	for <linux-nvme@archiver.kernel.org>; Sat, 23 May 2026 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mwL5MV6S1AMPCz9BF2d2Kabj5bce+BBSzVoHTJ5nQQw=; b=IF2VQwrkzCjhmysKvZGF2kTFu7
	Cgj2moUfF+Ja/x60Pq5fUVRczDIadeBMUGyCsb0HRenqNMB/1xLNVKsEclFZvXKcYTx2UAPVjADTf
	VWAIxmE+h17g72sIrZkPEiPP+dZ+gu3LmboujySpGlQSbBAXiQVFhySLMjxaQwkVgyDC/PgU/eEwi
	GLkLF5IQxTB9MNfJhePkUSpa0KnuSPsXQo0BtF0LUfO1/X3Yb8kGcaywt3PY/i6UC38yWwAJAu8Vd
	bvidOjP2ktiE6iLpBAWg7pe19c3Gx1ynInFIfiRaM48KQgF5kgBm98PPlRCRjTDYt+21e8z/GE079
	Pi8nlAPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQknw-0000000DAxu-1MKR;
	Sat, 23 May 2026 11:46:08 +0000
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQknt-0000000DAxB-36uG
	for linux-nvme@lists.infradead.org;
	Sat, 23 May 2026 11:46:07 +0000
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-911449d9d03so953653285a.1
        for <linux-nvme@lists.infradead.org>; Sat, 23 May 2026 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779536764; x=1780141564; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwL5MV6S1AMPCz9BF2d2Kabj5bce+BBSzVoHTJ5nQQw=;
        b=UI0IsqtfCuiv6PGHn/wqEyRRE/DBC5ji/r7M49G8NA2a7eDZXUpW1C52hBOgT0EK+D
         lHUuTVWENx4PI9bYZ77h3v6PzkLp6elGEiQ7jdkzptNXJo4qwxGYvvCVyQ5uuVrsNfPg
         vn+dXe/rGErveFtHNotV1jFKe1Sdgi2t3zet674aHD+QZ+qxYaPFdeDiirepoXFQ5IEt
         zPtkLEwX98080tKFfD8INqRvHI/tbt/BXj0lSjGORiK6bm/m9OcdKGuhwJktaknD9fjk
         0PhaeT3aDzEH+csbc3r7k3x4xUM2qtXkikXRktpmugP8qMT5/jDXidw9dmC1HANLJl7R
         WcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779536764; x=1780141564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwL5MV6S1AMPCz9BF2d2Kabj5bce+BBSzVoHTJ5nQQw=;
        b=BKsuI3wFAudE00ShlXgSXPN1mlfuficGPsZKCYhf7aQQ9rphB/m2E8olQLJFSjPSK3
         Gvxak3oBTFLICxfRAbgIJ0Nl7rGlM2c8gqrv51HXxZLmkdbRuAyRzkNk7+u7IBhNPWqd
         Tof+cKXx83baCeBjLyOEAcdcB9o4WEvxtSRc/amFzBOAKRA0IsyNJHGeEhxqX+2UqFYi
         rddNhWWqM5keniy6j+xg8ge/dxNCnaSrFS6gKzYjGnhln2/OdGJvpiYZvFlEY2N43KCj
         FeiPJxXyGsFwmKrnViPISnI8VgSNx7s0odvev5vc9iKVoOwx3dvbY8WSV4SfgQ72+/Q8
         TQZg==
X-Gm-Message-State: AOJu0Yw4oTZw/OBdtCBEaF6XPQaMhGm262BgmR+djT4f6N0H2324pgU8
	JIMzStUw7tZhXFmdGk4A1l58lwu825K+jy22pMlgBL9ZdCzv6F0lVK1z
X-Gm-Gg: Acq92OFHqrH3/SfJHCZcXh3pw6YanFiXxAeBzJYprh4X1EK+Zp7339MOUb+X1b81lEv
	zPCFCSM4kjAn6JZPYLpXaYz6ZRnZ2B8V/1qCFlKEtuv1tADMNMlPIe9VTRLP6rLTmuJQG6NNo9C
	ntRB3p5DFg/rdwESn0I0IZ0yY6Nx2zBGaCMNqhiMQp+LgOCXVPqrKmN7oaaZtDt1qYxgyrTiWE9
	AW/CnfiVkDB5PfRPfyRotM8m31NA+AjHc99gdW2/9woeUriUzlDNj4hSrskKBtPxoQXMhTzcXQA
	agd7y7Ckv6Q6Z+kgphXE0ROA82uQcqXKtk0s5pDyBtjYlhOOYvl2DJN+suIKKAaRhLCNe0+awMk
	Ja0ajsBuvcSIMJyzLLBEg2w54qNFDTM3eHjym0ld27jssBb8mkDUrb0qMquNE04xYo23wAKFZ87
	duSQ/kBT/6eZS9CELYiTTKASfislx2D9KWtVMA0kJ+iq96Y+45i/lgPgfRy62NL0bbDLYNKoSr3
	DK07YKjmiVCvCxudEpO
X-Received: by 2002:a05:620a:630f:20b0:910:bb22:d426 with SMTP id af79cd13be357-914b49a0b5dmr791369485a.33.1779536763899;
        Sat, 23 May 2026 04:46:03 -0700 (PDT)
Received: from mobile5 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba1b49csm376914985a.44.2026.05.23.04.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 04:46:03 -0700 (PDT)
From: Mike Bommarito <michael.bommarito@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: log when APST skips a state due to latency cap
Date: Sat, 23 May 2026 07:45:52 -0400
Message-ID: <20260523114552.101452-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_044605_790175_1898272D 
X-CRM114-Status: GOOD (  17.24  )
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

nvme_configure_apst() silently skips any non-operational power state
whose exit_lat exceeds ctrl->ps_max_latency_us (set from the
default_ps_max_latency_us module parameter, default 100,000 us).

When the kernel skips a drive's deepest non-op state for this reason,
the user gets no signal that anything happened.  This is a frequent
gotcha on Intel platforms that depend on the drive reaching its
deepest power state to allow the PCIe root port to enter L1.x and the
PCH Southport to power-gate, which in turn is a prerequisite for the
platform reaching S0ix during s2idle suspend.

Add a dev_info_once() at the skip site that names the state, prints
the actual exit_lat versus the current cap, and points the user at
the module parameter to raise it.  Using _once keeps the line to a
single instance per controller; users that want to see every probe
event can still enable dev_dbg.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Mike Bommarito <michael.bommarito@gmail.com>
---
Build- and boot-tested on Framework Laptop 13 (Intel Core Ultra 5 125H)
running Linux 7.1-rc4 with this patch applied, across multiple boots
over three days.  No regressions observed in NVMe probe or APST
configuration with the installed WD Black SN850X (15b7:5030).

Design context: the conservative default cap and the per-device-quirk
mitigation were discussed in 2017 at

    https://lore.kernel.org/all/20170606095454.GA13569@infradead.org/

and retained.  This patch only adds observability for the silent-skip
case; behavior is unchanged.

 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad6b1..220e844e852c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2943,8 +2943,13 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 			continue;
 
 		exit_latency_us = (u64)le32_to_cpu(ctrl->psd[state].exit_lat);
-		if (exit_latency_us > ctrl->ps_max_latency_us)
+		if (exit_latency_us > ctrl->ps_max_latency_us) {
+			dev_info_once(ctrl->device,
+				      "APST: skipping non-op PS%d (exit_lat %llu us > cap %llu us); raise nvme_core.default_ps_max_latency_us to enable\n",
+				      state, exit_latency_us,
+				      ctrl->ps_max_latency_us);
 			continue;
+		}
 
 		total_latency_us = exit_latency_us +
 			le32_to_cpu(ctrl->psd[state].entry_lat);
-- 
2.53.0


