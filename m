Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05E8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fK6JFhQFZSdQcnBGkb9k7tbZlEyVauIIW0ExwH2b/Tc=; b=33BqgMnQPsmVBD40MhcLqEjsDn
	C+fbtwhx/fTw4TGpY2/G2k6IGobxD7RrIkJseAeTcoL+KHjAREN5Q+Spmi+oyMyBFcbAVWhvfuFGF
	SCzXfqdF4QryEkb9Oi+di4Vj0cv3eQPiK2Fh6BPmnkkikiA4ADnTgAxNcbd1+elIa0ffhitUhOaZ5
	JUT0Hc4zeggHPsAQV6DNBpNQAAPnLWI+ztRSKi/1Gdc/MdklNuwK9RZZ55hv+bf34u1c785sg/pKM
	fjuLt4HeeUA5UFuTwdBqzNhKqbLAnpFvZgMkulC5HuESKnBTQrIctWJYbx/OLVnH4/HHSsUGQNhu/
	5an7xipA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4jQ-005nSP-7m; Tue, 30 Nov 2021 15:07:44 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Tm-005hXd-CS
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:51:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 06771B81A4C;
 Tue, 30 Nov 2021 14:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C954CC53FC1;
 Tue, 30 Nov 2021 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283891;
 bh=ZpQXlrXTrOMjinSQiwHRhHYMK+Ldcr0wzM0499Y6v9w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ap8qrMjo8Ff3DUD4EOAWABmDFptH7yIheTspxqbmV9WChV67Q6MM/RMxuFdQQ4/Gs
 ioSzSSIU4fNFluPDVIsWuuvUo6fx0FH5ZQAPlT7Ku8byUB5QMsP+9aKpLyGj2xAzxi
 7G4rtinUhdjINr/CM5iEOnGaabPCXmDjgQ/lZv/qX+rQ/V6jMlHbM5TvmDcNT3RLUN
 rtOoL9/jU8PiAKi6eJ2VyzntyxlqE0FizkHgxyt+7pexHakpS/kTYAnzRAnV7iN8z+
 zGnO+Io9fuZ7GYaDqkCArOofC27ziFEhkBSq7atYa4RqveG3bcTMzp2nTwEdBoElsn
 FDR9ompGOStmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 32/43] nvme-pci: add NO APST quirk for Kioxia
 device
Date: Tue, 30 Nov 2021 09:50:09 -0500
Message-Id: <20211130145022.945517-32-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065134_625242_DB98D0F1 
X-CRM114-Status: GOOD (  15.08  )
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

From: Enzo Matsumiya <ematsumiya@suse.de>

[ Upstream commit 5a6254d55e2a9f7919ead8580d7aa0c7a382b26a ]

This particular Kioxia device times out and aborts I/O during any load,
but it's more easily observable with discards (fstrim).

The device gets to a state that is also not possible to use
"nvme set-feature" to disable APST.
Booting with nvme_core.default_ps_max_latency=0 solves the issue.

We had a dozen or so of these devices behaving this same way in
customer environments.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b5152482fe4..c76f3a7fb1d18 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2663,6 +2663,20 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
+	},
+	{
+		/*
+		 * This Kioxia CD6-V Series / HPE PE8030 device times out and
+		 * aborts I/O during any load, but more easily reproducible
+		 * with discards (fstrim).
+		 *
+		 * The device is left in a state where it is also not possible
+		 * to use "nvme set-feature" to disable APST, but booting with
+		 * nvme_core.default_ps_max_latency=0 works.
+		 */
+		.vid = 0x1e0f,
+		.mn = "KCD6XVUL6T40",
+		.quirks = NVME_QUIRK_NO_APST,
 	}
 };
 
-- 
2.33.0


