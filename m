Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298B3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJzB0K/LnTdujZivKj6t9kGrrbrMZMpEH1n2G2tFDWY=; b=y4Mn+p0l+wkGomynkZcARlAfEK
	fl2fBY6bqcelkCxGUZDzgI69l7DXw1LyBr3kCukgPt0r4sD9jx0DCbL9igFTw2lDXUEzWw+j8IkCd
	M7kAHbXKEhEAkob97pTr5Pw3b335o4iCjosvUtGRpFrBfWyYDHIWI8oOwCQlDAH2Ok612U/ftb3Wv
	14lK+bL3DWy5vIAWRTePWApThimc/yWmyAbKQapQ2NtjNNKuK8WLuyz26awKE46FryvGb2jZx/7wv
	GDAqA6aqx4ffq0o+uJj7NLGBf3tojWF7XWJWQRpLMgYms9PsM+RH9zXIKt+2xafNt+4RlPoSTmYM2
	dK8+Aisw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4TL-005hLN-K6; Tue, 30 Nov 2021 14:51:07 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4RL-005gF5-Qp
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:49:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 86C11B81A25;
 Tue, 30 Nov 2021 14:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450BAC53FC7;
 Tue, 30 Nov 2021 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283741;
 bh=MIVBc3yxEwa8fYigT0Ew3Zw9j7BxdjWFHttWgDurcbs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lkwuPNK3SQkFwpH71lNqcvT2kuPDf7wmJhGMxB1FqbegV4XlTGNLD7rCj03gFtP44
 LVVcWSgAOxf00WY7n+Yn42pRNsBoVEbBQaGARd3wu3y7lHvXIQqpBAG2NH+rzWHBRQ
 17y7uhHD4x2+4OkOatzszgvFr9hwNT6fST+Kvbhffor5zQlk3nl/ZDG2eX65BFMN18
 wcRKQwP/G4RTuSYmurSqwVvSYA9KH1NwyC8xPMnX6td7smkzHLjY2+ZUWdWKW9sfyn
 jy0zECHgr8vPq2xgDVLuS8+3ZSQ2etne1rPwSx1wg1HZlM7hCfORa5I6CtoArCG5kx
 kHtUKQRMDaX3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 45/68] nvme-pci: add NO APST quirk for Kioxia
 device
Date: Tue, 30 Nov 2021 09:46:41 -0500
Message-Id: <20211130144707.944580-45-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
References: <20211130144707.944580-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_064904_079226_7E38F1BB 
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
index f8dd664b2eda5..4ff75d7031110 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2468,6 +2468,20 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
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


