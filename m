Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59703C021B5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZ05WeM+CJDoKE8IUhPXQmenJckYn3Bh2p95sAJXLYE=; b=y0q0IdZgj7k5dz/28oC1ghRvDp
	OPhLwJCanwUTcmzakNNDhdAuyvFq+zRgtIxEmGg9tCGBXluvv0NZswhr+hb5Egi9DzGJK2mOYqa1u
	YPAlkoe4wFUA98a3cygRdyVrsmClHhj4L3ycwSz4LiK0ubya09nhcIJXHAGbWhbbcinztBO6OvPp+
	l3NYdWFF7DoDtr8MJQN7bssFzKJ7GDLpoG1PWgvNK9rvzed6Mrn09Efwjnpy1eDIrYBb2c6b6vW0f
	Daepoky+11+yh0DlVa7ZoMmQdQQoUAW8feFTYsBBNuZYg5tdNtEDAcPUxXKD2AvxulhGnXi+/AR4h
	qCr3st+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWdK-0000000DNr1-3f3M;
	Mon, 24 Feb 2025 11:28:22 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWTG-0000000DJMN-1uer
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:17:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 22E4C611B5;
	Mon, 24 Feb 2025 11:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71B2C4CEE6;
	Mon, 24 Feb 2025 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395877;
	bh=dqPuA9v4dNcw/imLKMmpcyLGTWuXEGp8WqzvpE77BxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRv/rhdf1SjMeTipnptVZsT96UQQuylA/QxkXecCo78d9SyV6oMCeTdRNrLt8Mext
	 Vhzjd1iDwy2o1508FBfrA7Nka+Kgdl9vvs9rrx7hR326mxdYwyONfvQRK6O3uvo6mH
	 YexruldfFLUORhF1K2NZwU2Ulvx9lLwNPHjT16Fwz3y3OOVkn2xYYbSlj/133IlhEo
	 g5tDFdNTZb1GJT+gC69kAQ0Y/7ODxhdom1ttjafaqCewXXMPHf3WdaSvvUZeuOeBbn
	 QnDmGkmDtNaIxhyrneSp9b9i2TfZa8m+2h0UMdjVcs+5EJCyLZUunn0WpATdwvxRzm
	 or808WViWnLiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 31/32] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:16:37 -0500
Message-Id: <20250224111638.2212832-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit
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

[ Upstream commit d2fe192348f93fe3a0cb1e33e4aba58e646397f4 ]

The fabric transports and also the PCI transport are not entering the
LIVE state from NEW or RESETTING. This makes the state machine more
restrictive and allows to catch not supported state transitions, e.g.
directly switching from RESETTING to LIVE.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46e04b30f6425..cf0e7c6d5502b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -564,8 +564,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
-- 
2.39.5


