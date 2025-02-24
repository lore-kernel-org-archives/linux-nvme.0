Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B16AC021A6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+GQfFVTJ2P7WKTbwXSsHMwQZ8z76gpn/5lmvgs2IraY=; b=WqYRccbXCrQUHiroC77NOUYOsq
	khuIn4cO7VPiOns4U7BBQXL+lVOhkjAREwCzolOXypk72J0yNdoV27h3hpYNpnNFMcfsViGsMN3Eh
	izdHKF8OC7u6lKmI9Ndff1tphpPh4jBV81QE4il6Nj82IVZdiRjowFC1c0nG0umBKuUrVxAXJKoBR
	UyZ+Ds1LsYX8o2LYFfTpBAE/o0Ad/Pr2PILWuarluU50FuGPhEAsM5DBk1YOIYR8rgI8f56MoseGo
	qiEfNzT/dTtdZ68nAKVw6kAewcMVq1E9MJqhWXnvsvLYwA83AYzyZaM2U66SKLFNGU5xDrcpot5dV
	15l0KTqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWjd-0000000DQYj-1Dbx;
	Mon, 24 Feb 2025 11:34:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWW3-0000000DKXj-0noO
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:20:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9A5D75C6BAB;
	Mon, 24 Feb 2025 11:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7686FC4CED6;
	Mon, 24 Feb 2025 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396050;
	bh=tVJjRg9ubQDrUmifk852LmaOIyncW3ntt0T+jOsIDhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/oRhE62Z+ou/Bgju7cZnKX24qJzu3ob0kNOXuDExIQkN2NBVYdk9OtJ7Oqd2NGPc
	 FzHTguYOh8Ary4HFkjDQZlPNDxU/muqcKBhekd2aGRibs5s7jDm/CYN2Ydudegol61
	 kjBwqyzaH2me0/1+YNrclmU1ikePtTXqMW91dz4d3QKLFror6GHnxFMR/a67IjD5xc
	 dqnya9bAD79YiLNFCPdL/Yn2KQutdS1P/A0XGAuE0pM8aIEKlDSC0Dz8IcO1LKtlSk
	 CUlOOg1tEl3ItbRKDrAizekY9Txsf8RTZDWoV5NPef0mt+6ZEzU9l3XXCdRXh4U+3F
	 jJmNRCfoOHyFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 7/7] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:20:30 -0500
Message-Id: <20250224112033.2214818-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112033.2214818-1-sashal@kernel.org>
References: <20250224112033.2214818-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_032051_297760_821BF4DA 
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
index 93a19588ae92a..a3293d12d8841 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -444,8 +444,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


