Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C39DC0219D
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 01:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=COYSgIKQ7pGoVYQwYP5lom9dMeJVRf1PCwUrnBMhBE4=; b=M+qXxTQokiibsY3uIAwLmFMC1i
	7zACfM+LPek5rmYpXA5AO4w5buSfiTTvcR4oFcVw81wYBKdKS/ldFY6+u7cdUCmrMCbz6MLkL9sUT
	N5eYlITFhpooC2CeOpChVkwaFlcYG+rn3NQFxqiupI6img2qXqt3XOsd1b7VbrJHKyQ75RHTYvGl/
	ldb0HTZcFVCLkLixm4F8cn7G+RMu5drvP774IcizwEX7TVMB5y2t6hSsmAYsfLTymokiWhIi2MLp0
	pWiYti9JtKleXCand9kstyVT431h/CWgtDn5XNQog5D1MtEpwcYR7nI552VRCxVJSM3uwZNaiwXaZ
	u1lO2q2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thf8I-000000027xx-3pF9;
	Tue, 11 Feb 2025 01:32:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thf8I-000000027xH-0vKX
	for linux-nvme@bombadil.infradead.org;
	Tue, 11 Feb 2025 01:32:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=COYSgIKQ7pGoVYQwYP5lom9dMeJVRf1PCwUrnBMhBE4=; b=GsVe90tf2UdmSIa4zufCZdgstr
	wlmzP0SqI9x7y/jPvLB0RToO94A2sFchP0ZJM7BrnGs8lbMEniEeA+j9CAAEQndc1wyWJySnoBS1E
	Z9Vbrw0VfUKlGF1/xajeJdcK8kxw1O0SYfftKUWfi9NVOX0GXfOXJWhZWlvwpw6paDsGUBJLvDSh8
	hldyiN6PSvQpsBsPuKmOkeszVzO+yluZhWTW2oh/qs1Jd7WZJpCgmDsRM9s4etQ1EB5PAj1pPQOsV
	bD191FNI+QZMYKtxNhGwq1pat+F+TcNc8qKWTFw7kAo8W6kM1kD8RLsfdSJCNSfNqWkIXmVigbNIl
	7/Oq/5AQ==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thf8E-00000000QyW-3AgT
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 01:32:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1C60EA42096;
	Tue, 11 Feb 2025 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B13C4CEDF;
	Tue, 11 Feb 2025 01:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237529;
	bh=joTmstJh5P/C7qhbFmS7I5l3jHWOY12qVNch68QcO68=;
	h=From:To:Cc:Subject:Date:From;
	b=HNZD6mVghzZRbzRyw+WEDY90zSvrilRTQiHt4DdPDcgg6gKsRL8W70UaPAhLZaW/8
	 gSgvmUpdiOgER9rjNXyFlvO8R0po4HlupGTShTowYksDMR6WV1f7TpK5qct7dvi2PV
	 G4gyEXsWvd0/s3Cy6zB/qajfzmlIDZ0MGBiuBNZF91cMj3YiuDOk4Ml0baBu2u+3H1
	 rBdE6tw1GhGsFzVaaQhlQCKSZrMEkkPKT7pI/eBpw0whrMmi8x79oqfqwvMwehUJA4
	 M00dO9PfNA/KXSVm2R48MdLddniXVhnkQfRj3LGu58W+TodFyeXVnC77kZR9Rss7+3
	 BtkaXGC9rlk5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 01/11] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:31:56 -0500
Message-Id: <20250211013206.4098522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_013211_013636_A8FCC678 
X-CRM114-Status: GOOD (  12.00  )
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit d3d380eded7ee5fc2fc53b3b0e72365ded025c4a ]

The initial controller initialization mimiks the reconnect loop
behavior by switching from NEW to RESETTING and then to CONNECTING.

The transition from NEW to CONNECTING is a valid transition, so there is
no point entering the RESETTING state. TCP and RDMA also transition
directly to CONNECTING state.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3dbf926fd99fd..2b0f15de77111 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3525,8 +3525,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
-- 
2.39.5


