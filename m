Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF31EC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/gj6f8/7NZ7nPoLd2fb9xeftwMm54aix0us93zyRTtw=; b=B8KpJ1NKMm3wuhrQgGI7PYTtAV
	piWmBCoXpfBHJ62j5XvdiFmrEpoJlz0iEjQf2Hz6uQCXyl7ur1bTUIXvPnZvCnfoF+4gUT6+5Rqul
	9wex1uyxe2nVeaUHnAsBT2w4SZ4GLHT3yB4PovlbayXtqVzlWYVDQIY+6pM7BCzQWG/Ln3IUvAnD1
	T8sXiM7jnPqba2ExJMi649uOUPPDceJ/pbImapg/iZiTU3f+afB53ABjWwvm4h4nP2hB9zTnDQxBG
	NBNbDH0zlxSq78FuHbkFe85OcsCzjyAS7Budj5LiP6Vgn6aTdET9qsWAg69vqmN0363V6J/6L87mN
	ay51pjDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWkO-0000000DR3Q-0wVv;
	Mon, 24 Feb 2025 11:35:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWWZ-0000000DKqT-1RSf
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:21:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DEAC45C6B8A;
	Mon, 24 Feb 2025 11:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F26C4CEE6;
	Mon, 24 Feb 2025 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396082;
	bh=XgZyEzzciGjy60AFUBlWPe47W/YLjQPWkEQxUW590gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWCiVebP2DF5IQXLs0tH7/X8UX45ulS0t8KPZ/oGnRYOBcV9oUcd2V0D3AzTQnFGm
	 XvOOAsQ72T8PdM/torTuWT6ukc7nTI8l7alqgB3pNieKNxfWSXZDK9rPtfd8xO1+Y4
	 qjB2mTHXfC3nz9gJ5CbLc+1keebXcLYTww9wDYQvErrdK1LLLOjgM4zF5mkcpUZKp0
	 d4JkIO6dz6MFcvQP241QNoZjsWgl9xnFfth4p3IB+pG8Pm5pxYEbqbv8JViRUxhHob
	 T9lWqMHZYWRGvnySEaglzjbMo8Rzyy5M5RcRX2Oeg1+cR0dvKAtBQxcSOz8pr2+Psd
	 pcJWTl/IbKN5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 4/4] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:21:12 -0500
Message-Id: <20250224112115.2215137-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112115.2215137-1-sashal@kernel.org>
References: <20250224112115.2215137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_032123_422662_83B8AFBF 
X-CRM114-Status: UNSURE (   9.22  )
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
index a841fd4929adc..1ba0c25a7c5b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -351,8 +351,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
-- 
2.39.5


