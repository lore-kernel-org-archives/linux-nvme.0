Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27938C10F05
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HvifziDC7Cmc6xpikxOVQVX2lFSCNWxAlkAC6i4Tcc=; b=eAI8tqL0QvjfVI1XHoTrUgGAjj
	FpCr7E36lf9pRfFE3zDJZFEdQ07x7j5PrXJEk8HD2y3KcHuxyG8CnkTrPatGPO6CYQ7i8GWGfWuzJ
	Lmd2Bdus1KR4cNa2YFjeKRgE8MYMbTJINj1G8P0N8alDLSP6HaNQu+h/gJ0EK9P0VGbg0HDoam++M
	cieK7uBKfrHbLQdm+i7LWblbs6YEcI8KWvVZtHsBa0YVyqu+9gn+hD3b6cmotFSuwr2bMHujw57uO
	ZwLft9tR4VGdzuETe3QGhw3E3oKGXmxOHXol6CH1FfwRZWOLE3npxc0AeJ6tGw+5sRdMjxoi1Fy5e
	G6R4an5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgsT-0054zD-0b;
	Mon, 11 Dec 2023 14:03:21 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgrv-0054qJ-1b
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 14:03:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 152D4B80E6A;
	Mon, 11 Dec 2023 14:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8F4C433C9;
	Mon, 11 Dec 2023 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303365;
	bh=W0dgYjgyezEIWv6mifXWfWGlfmcw5yAAe0M93lsc+24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpzgFko5YP2lxus8lYeUTt+hjwV5feJwNdEzAfFufiKtBwasccaZb49z4Gx2hLm9u
	 m4yT1ljHnx79K69H1c0j32NDs6Nn1BfQPWdOS3b6uUhizCLeqx+Rx2lZ6KVrtlO/oj
	 3kSyraF7GCKjvG+ZrZLZfJW4sqd8JRAFexnK0EAZhv1ON8CUawON/G1/F2jGz5MSwR
	 8SC6YkIWv9L5XLKKnuC3KcYn+EwSzaOB5xt591lNTQKoxJT9tRX1u95xsq0RrocsG1
	 5SAyKGcA69HVWUKHoc+PqDltIWNzepJu7146El7eIgrFBf6WVnbD/OPrm4G0R0bRHo
	 HqGROUogD7coA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 10/12] nvme: introduce helper function to get ctrl state
Date: Mon, 11 Dec 2023 09:02:03 -0500
Message-ID: <20231211140219.392379-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140219.392379-1-sashal@kernel.org>
References: <20231211140219.392379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.263
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
index 17c0d6ae3eeeb..c492d7d323987 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -292,6 +292,11 @@ struct nvme_ctrl {
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


