Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855DDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZSIw8AdV7bnfviiNLqRunZgI0yOg51sWNx3TO3BRe74=; b=boUVECWTUdsAgAzGMdCTjAsrSp
	wNOvamH225/kpShuUCBzPwJtWcOnkiYiWq3x/dLy2iaKnn06fEixLlMY68y9CDDNE3UTvecoRhh2C
	ZrMAZxQQG/kThLkmO63lZFMC4w9CQrJfpV1hieIgyW58aNpJ+3wMg32uQembM7JLhQMQ0g8plb38j
	zE1I5SiWds4C/B2k6Ze+8TRfYDAlYSMVZRVuSvVDO+sCa8GHEjAM/OL7wETTvHwOqBwKzmyVb0J9V
	TBL8ZGDnhasJSRVZRt7BKv9QpnHDhjUdnZAuHIAOJmV3L4gedyBqoY8Wm4x6SuhFYBL0kkEfOIghO
	ZZW5eYVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4sv-005qGj-2V; Tue, 30 Nov 2021 15:17:33 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Ul-005hx5-LN
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:52:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 45CE9B81A4F;
 Tue, 30 Nov 2021 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FC5C8D188;
 Tue, 30 Nov 2021 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283954;
 bh=otRf7DSe9U5QDSY7crYhRRCxFCnRmBu+ownlSsOmhuQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TU7TKYt6AfQkkGEicWZfy3CWF1GoRpymHNQ/l5AqyPYr11E5QsUoJnVNebMoS5+0E
 II/1gqNHOyKg2/9zveURBqTXz9cY5tKku3kSm6SA5bEy5fooUgwNQ04ah6+yXJYSOK
 kxXlp5zxYfhoxpIdtsRq9FMio6P2bwcTmuPG0F4j6iw3Z0buhZsvAs+8SpN7OtWUH4
 Y/isqIbHlaTVImecmxQOUURoRHOwv6yEnCb0nhvjsqIaS6myu0HpIfQRMhPUX/C4CG
 8HgGynedvbLpsIKXZ8cJsw9IuKe4LpIcaAQJ39vTW8GRQ5RZNmnLJfrPB4na9rW6Cl
 AX5wSpPYa8uaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 20/25] nvme-pci: add NO APST quirk for Kioxia
 device
Date: Tue, 30 Nov 2021 09:51:50 -0500
Message-Id: <20211130145156.946083-20-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145156.946083-1-sashal@kernel.org>
References: <20211130145156.946083-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065235_906712_62D2BD7D 
X-CRM114-Status: GOOD (  14.97  )
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
index a5b5a2305791d..5fa48d36954ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2453,6 +2453,20 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
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


