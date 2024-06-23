Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB9DC2BBCA
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jun 2024 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulkMiGN3BVdbzrq0H77BoxeWwuLMFyMQEMLbN84RxXE=; b=OldtD/SdbKExHASt7b8cVWtPg8
	IvWsk0+qppw0/BBPS7XZNqJS560Aw4A6CCMsAK1ck+WcpA2fk70YrszbzkCZNVmJhaD++Iejy7aIr
	dGS9H+IS3BwzK+GAJ4AbM0T42uj5p7bsAd2k+mVNdFYhU+NTsQ5lhkBkJjhKAXHtoAtKG6JvV0Nw/
	u9+jbwFW0gC70WflP0V5Fx3tKeeEt22r6aWvuAz8vd90jNcCK+fx2WnVwWVZRWXZ2YFFW+mwaDmNY
	e9+uFNlLKN4La0o+ulAzCp6k12LDYNyd4cMtbWPbtSvXk9SYG0p81xjKiGqTJ0MPyuUCWy0UiRzc0
	P3+oYrAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNXb-0000000E63a-32Z9;
	Sun, 23 Jun 2024 13:45:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNXM-0000000E5rU-1Kiz
	for linux-nvme@lists.infradead.org;
	Sun, 23 Jun 2024 13:45:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6B404623D2;
	Sun, 23 Jun 2024 13:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD73C4AF07;
	Sun, 23 Jun 2024 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150343;
	bh=/9xR0m08+eK08nMnV1XouuDRAiT3dPoGZes7iFkvC7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ/j+G0AwEEcS+FlnbzlhpoGBGtJy1RboiqhTnJrqK5bEqfTdGEoYnFgWfr2wZzdE
	 qiNsZzxa2O2+NcWhHzkP2nBna+j0UtXrZ52hohE77H6yt39h/M7nQxEhaTSg0R7z4f
	 ZJhTvO50YQZ3lCfTJx1Metw5SsAOqPSNGlwJAZlclm45XJQB5whoQv41N46kOlOcMc
	 paxd+TrO3oXQUuWMviBVLZfH7ul9zdAiChpaVRvgMarvCAccvMHDe3aJwOe3xaS0Kv
	 QbXYCdu1rhW3JnKm9c8NOhdn1cEYqHFtXQrFelxUuATfpWATZPZan6uUOGVrFGiGuB
	 koyEloTR/jqWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 3/3] nvme: avoid double free special payload
Date: Sun, 23 Jun 2024 09:45:37 -0400
Message-ID: <20240623134538.810055-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134538.810055-1-sashal@kernel.org>
References: <20240623134538.810055-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_064545_050641_9CCB1839 
X-CRM114-Status: UNSURE (   8.50  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit e5d574ab37f5f2e7937405613d9b1a724811e5ad ]

If a discard request needs to be retried, and that retry may fail before
a new special payload is added, a double free will result. Clear the
RQF_SPECIAL_LOAD when the request is cleaned.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 960a31e3307a2..93a19588ae92a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -981,6 +981,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.43.0


