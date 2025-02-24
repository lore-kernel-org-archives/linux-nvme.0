Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89A9C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8FSGEZv2GRt3fpfPVEFVb7/Jr0GJuQSSF1EnEWt7j2E=; b=dRCnHOd79ef0BVmgKUm7Ew+TcV
	F7MYfLHbqmrpqJHT9Q3nz1pCSlABfOxO7FGhcBs+GLt6kV130cQkjSmX9Pmhle3s8bVJb5t5SUG1K
	R0oTVt/KuSPq3yeE8QU08I6z9FfheRESD5GIvlYEDmTSsv/DFI9aTUfSntvzNMyb+cHfBNDl0YigG
	9MhUF3tc500KdsFUmvxUUjKC2sibrWztG8snIwBAVk3wMsjeMps2x2XdhxSekkMa5RwP08CBLN5Rw
	AjPeP82BTF6T6Ys2fSX1SEiLY05LJg3PW3pbiQ5pCB2zOhB0cqPbPkC8E+Etv4WNiEc9OfQL1f9PA
	JfauIVqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWjT-0000000DQRh-20ht;
	Mon, 24 Feb 2025 11:34:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWVi-0000000DKQq-4A7g
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:20:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 88D5F5C6977;
	Mon, 24 Feb 2025 11:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664C5C4CEE6;
	Mon, 24 Feb 2025 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396030;
	bh=ouh81ZkBVvqfkj5b9xjg61LO6S8TmpATsTX1w6fHr/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bE7vv9+4Ajs1jHuoWse+qhpyOLVgkdfMyb9CmDEuKFy8CLI37JxhIkbo28dGdc9+y
	 20hUImwKzSOtbThVUhGjjCysZVofkgtiRBsjdlB3O7s7Ag7u1G/0DtD5PRsOJ2aWRD
	 Ov0A/5sYzlWYcOSR78QQvX2GCc/kYyP/ckfD2eQRU878gu3F3pMFZOUzcA+VMIUkK+
	 AN0ZHgZTsSMk/zj1wtCbrxcTC+HRSIepRWU0gnk8AA2PYSB5M2b4pd6Gp0LW0h+rdY
	 n0QrQ6fiC5WKJHiSut7DUY4YXkYdv69yGbvCD9mYhj0zfbpjx4Jz1W4kKC02VeA/E8
	 MIf/zgB5/VUlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/12] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:20:00 -0500
Message-Id: <20250224112002.2214613-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_032031_085110_2E425A9B 
X-CRM114-Status: UNSURE (   8.95  )
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
index ba76cd3b5f852..6a636fe6506b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -501,8 +501,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


