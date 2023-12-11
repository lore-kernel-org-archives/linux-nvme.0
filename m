Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD681C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VsIqhABW2DjdR69/avX8LdAwbkkej2yV05fRuqNtLXo=; b=1nmVFr21eU8UBIoqxql6ABYhpb
	lFGe0Wyk6JBN9ICvzO2P61zcIbhPV/36rS/K9dHs5GgC/OKjItL7JEcoIMGTiqotpwzJ+/ye3VY97
	mWIYXjqwSUDFE+4cWlPUATS51yWqQiELWVWd570m5IxE1YPrUreS+bb3nh81HQK6DwA04sfeCIwgm
	gn4LDAgocY4uUBQlpPHzauBv6gHov990SjuI7pq2c4Y8UGoGMfiQdgeTlxiZM2Ybu08+anZLunV1l
	sjuTPekZeFoXcIXZuuY63WCIqKpjR7nT22xPv+AdbJAu+P8P2IM64eJLIiYBxqIJ+55djughp8Y6Z
	TvgcGp6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgrG-0054c1-0i;
	Mon, 11 Dec 2023 14:02:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgrD-0054b5-25
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 Dec 2023 14:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VsIqhABW2DjdR69/avX8LdAwbkkej2yV05fRuqNtLXo=; b=TX/f38SdX2MdoMvEI5iVSWDYBi
	VojKdSBno42nm0BrmdHEYodt5LXB2tiEH1XnMcdANv7wYP0FKu0CBlcK8IPw9PNE0RdsmSoHT3v/X
	4J2zYl4EgtteGq3eVqcwyYoIrxdpK6RIkvDrL5y8w+u7CzAN3K5Uqyd5zW9RfRwRLk/eJMuwlwFnB
	lVah0EEyqy1bDTTuGWS/R2I0tRjkzOXA3BsK0BPACU356u/8n+yeVLcDIO6mdRb25KAzlvPMuoRRv
	aRtZ/IEioHV/5DrkdGwYQigpO3UQMpLJVRAJOpLYot8kA09Nm4oDeFYN+GoUMONWy/VNg3CsFEte1
	RUFSZDZw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgrA-0086Os-1r
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 14:02:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D3287612C9;
	Mon, 11 Dec 2023 14:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4521C433CC;
	Mon, 11 Dec 2023 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303317;
	bh=4k1SaVBa0z2pNpULLs2GouEoUDKokyLPmJyx01TWH5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3j+s0Z/FO583b1b91UdG4K2MAExZZJPpvriW9sfff/oyGyzaMUckqyGIxzThTztA
	 FevWkHIszcw6w/MVBRzDYOMG+4Oc+/U6boj46N5O/4oa5xshyjdsFxJEWFYnZsJoFi
	 RxpPn1q/qXQneltHHUCAHMeVju1wtowyNTMpiVmI2jaXIWSRGuSE9/UuLm5DW8MICF
	 LCubDSQGVJSS262ggVSRm0f+C44iMUHD/TzL/zj1Kl88PpM/qwGSSzNXL+z9QvCYLy
	 KEYMF4/Us0Z3AhJX+HddEI69O4MIRiWaC9BAT2oFiYQpW/ykyRA5bDYGbrEPEC0pTO
	 11XoxFNBBXwLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 13/16] nvme: introduce helper function to get ctrl state
Date: Mon, 11 Dec 2023 09:00:37 -0500
Message-ID: <20231211140116.391986-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140116.391986-1-sashal@kernel.org>
References: <20231211140116.391986-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.203
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_140200_871080_F21ED1BE 
X-CRM114-Status: UNSURE (   8.99  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c687c287c46fadb14644091823298875a5216aa ]

The controller state is typically written by another CPU, so reading it
should ensure no optimizations are taken. This is a repeated pattern in
the driver, so start with adding a convenience function that returns the
controller state with READ_ONCE().

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c3e4d9b6f9c0d..1e56fe8e8157c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -354,6 +354,11 @@ struct nvme_ctrl {
 	struct nvme_fault_inject fault_inject;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.42.0


