Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDE1C369B8
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DGTX7NOwigDelt+FRBHT/NNqB/fRDeGpXZjlEqav6eQ=; b=skqyNnnT/ZMHZX5Bf3VeDqAEzj
	efoUrZw/4fr52hrtiMnMBMiHxLs9uMVl9i98bYdtN9N9OxEvleueBcwTf8WCMA9tC3IRs9VgINQtk
	f8gYwS98g8kvbmO+xJRiFH+TUVaWORLbn/r7i7L9mBmULd1AC7OKvjX+IB1KwkNzirLlC5lKLq3AV
	UYFTac7anDH9TUO1nZ8qca8GDxCGOEE9L1Z40hCUD3N4uRr3JeRNhk8R2h4wxkw1FbUtEFPXpvuyP
	g/oOUK9vfy92llecs5n2ThNt8bY7s3EXxgemPb+kJtK1eSna7wcgl3xoj6EDC2HSmO6aN1LNmMY0J
	PQ4JJiTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jua-00000002AAt-2HeY;
	Mon, 14 Apr 2025 13:31:44 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JuX-00000002A7q-34pK
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:31:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9F915A49E30;
	Mon, 14 Apr 2025 13:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C983C4CEE9;
	Mon, 14 Apr 2025 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637500;
	bh=6Q6vcdSjw/C5L40fa3MSw3GHDhL1p1g+Cc+qUbskpE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNflNOq3HuCHv8i78in5evv7N10jHlqvQESJmuLqW+vPWOwGEUbwF2qcMm43QLtNR
	 iwb1xdQc6Q1ZRI2/V+wG2s4K8gfByKJa9gv5Nt58tWLJQ5xZMnVryH5YqPeAx31A70
	 My83BEhjFk1Ze2D99N1TFG8gUwiThweu5YpcdFVSDOSGrLWwcJLTQwCjgYN8x4/r01
	 ZWnoDM3Y6zgMDimBNCPqNerks4AccxsEoMcFnr1EjFfXsBMVkumQd5jHHRyGhEVlZd
	 zJ9ZjdlvYIjXL/GgBrbFk2dzHOdAraW0X9iQfT82j3L2uFBo0laWcGsUjpGCFnnQIg
	 5HTQ6aSqYfzDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 07/15] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:31:17 -0400
Message-Id: <20250414133126.680846-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_063141_851370_173A574F 
X-CRM114-Status: GOOD (  12.14  )
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 62baf70c327444338c34703c71aa8cc8e4189bd6 ]

When scanning for new namespaces we might have missed an ANA AEN.

The NVMe base spec (NVMe Base Specification v2.1, Figure 151 'Asynchonous
Event Information - Notice': Asymmetric Namespace Access Change) states:

  A controller shall not send this even if an Attached Namespace
  Attribute Changed asynchronous event [...] is sent for the same event.

so we need to re-read the ANA log page after we rescanned the namespace
list to update the ANA states of the new namespaces.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85d965fe8838c..68d4546dda3bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4225,6 +4225,11 @@ static void nvme_scan_work(struct work_struct *work)
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
-- 
2.39.5


