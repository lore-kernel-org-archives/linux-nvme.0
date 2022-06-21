Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF11EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nPJ5i+obWYB+tESCqB/NCI3UL4MD9q+KJYmS8f5/cbM=; b=RNgh3I5aDgl+VI+JdED2hcvpWp
	Qn0yhxPeh27SUszCJ+xGtq47c+vc2+0hVW4DKNE2Gj/OHMMUHuYQMD4nfNPBqO4gu75gZBAe4glm6
	BgNg5UG17djcao3/zp+mSy7x3jKsJIghQ+ngfuBRDObFNm5THg8D/zdRm812V0puihI+LKUfYCu6H
	bq21fOMbYtZNpT4qVTLGPgtpASkYfWrHa6AyoWP+9hD3tR5B1NNxmvUBK5FjlGRCeqe00FdNhER5F
	ULGKz63HB00n49fl3E+1xpJQY1JbI+Bfp8xKbdRXQbgwwgn+onb57D/8ZTS4/+pAauSGgmcZ3qCHO
	FXH3ydEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kqS-00775a-3i; Tue, 21 Jun 2022 20:51:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpM-0076PJ-Qu
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:50:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5A3FC61892;
	Tue, 21 Jun 2022 20:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCC1C341CB;
	Tue, 21 Jun 2022 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844624;
	bh=xPbzL0wDc6CwHXS68a6rilmIYemKUNjBohiq+mwTVsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcwytWdMJEalMs8e+43HgrXzYARYWTLQeSe6RFede4OarbbCMbjhI/308m0LPUup4
	 HjwDmK3z8/jj4k1KfuVNwlTDXc17wl5iqWVSnCcod1pFiQvoswIWgBrdzzU0MyvxMf
	 C5EZxpSYJ/gbDqwL2D4/g8VmGA667duf5sXXFz6L7toO4P1ZdEcPJAFCxbfm9u0ARE
	 8byOB37jSB0JJZ8U3Dv/Zesxh8uWmnwvJuHjNlq0mwR+1IbdepGtGQ/nxlBE0mamR8
	 bdzt8qk27o6O63p9rrgdbVdrj9lX35VVf676dOKwLAaXhszaSFhHkQC2MwNJb+8U2l
	 atgvgMpP4TGNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.17 06/20] nvme-pci: add trouble shooting steps for timeouts
Date: Tue, 21 Jun 2022 16:49:56 -0400
Message-Id: <20220621205010.250185-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205010.250185-1-sashal@kernel.org>
References: <20220621205010.250185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135024_943671_63BDF4AC 
X-CRM114-Status: GOOD (  11.90  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 4641a8e6e145f595059e695f0f8dbbe608134086 ]

Many users have encountered IO timeouts with a CSTS value of 0xffffffff,
which indicates a failure to read the register. While there are various
potential causes for this observation, faulty NVMe APST has been the
culprit quite frequently. Add the recommended troubleshooting steps in
the error output when this condition occurs.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 823fa48fbfb0..f2d8d939cc2f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1332,6 +1332,14 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
 			 csts, result);
+
+	if (csts != ~0)
+		return;
+
+	dev_warn(dev->ctrl.device,
+		 "Does your device have a faulty power saving mode enabled?\n");
+	dev_warn(dev->ctrl.device,
+		 "Try \"nvme_core.default_ps_max_latency_us=0 pcie_aspm=off\" and report a bug\n");
 }
 
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
-- 
2.35.1


