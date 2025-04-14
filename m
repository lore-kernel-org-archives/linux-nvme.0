Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B7FC369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MiuPyZsr2cnIWip1FswD7hXRECFlWuoNV8OglhgQ1do=; b=wuRaMtCLGMvdIKlu4moscAc9wQ
	Zi6QiFcSydUBC/bp6a58lnSdjBmgfN1qXpvCza1HXsxiC+Poh/FdI1UJSQd8MnSg5prWOspXKCYmv
	j34MMI1R+8ejVLDTjCU7sAS8xWo3ZJp4FzKww2dIw/tUARurWh7IDx/bnGKXGcJcvHTZ4yyAgJoOc
	NueumO4HF21itaJeSPznmxELYmzZU+hYlPG5Z53GTo0+umkOP1gZcu020jjSzN+URQKOwZjcQO9Xi
	orQQx4HO0Frp/cwPfJNCmvnzMhMRmi4mZ+WpndHZ8KnrMuJFqPiOzUIURnPxZLxihXrg88R+0+Z7w
	PSGFvwEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtX-0000000298V-3MPM;
	Mon, 14 Apr 2025 13:30:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtW-0000000297v-2eYV
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:30:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6FD23614C0;
	Mon, 14 Apr 2025 13:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B92AC4CEE2;
	Mon, 14 Apr 2025 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637437;
	bh=zoXg8WRJFTRy7RmDZZQNLt3wyDVJhYSJ5hgWVHuxyK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oo7mQHt/OsSU6wWlRM32rlaBNjJNTlJXTeHHYgnYXZnQnNGrT1MExZsyXjpR8itto
	 5M5pmrB5lzgFKKr/7aJxiL7ZBfOYC3aDIDHsyBhjGtiGkOilSOSMIfTn6Lmzafa3Jv
	 zouw0i7aQtoFzTQqoVQflq2b+4mlUhmjkUaDVvJWteRv9YPf5eDkG/2jdWnCv8tNud
	 xB0bcMaa5yZSQieUM20wAQHnVXtc/koApkOOYfyB9QZnkFQs8Ah33pVMTDN15oe6eb
	 fy3XT19UZHgBUFOkHy5M7hcaSJx2TzUwn1N2jMupgiHvHfbbeDPRJhQnni3i5pHyfs
	 o3Bw1MO1MgAbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 19/24] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:29:52 -0400
Message-Id: <20250414132957.680250-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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

[ Upstream commit 70289ae5cac4d3a39575405aaf63330486cea030 ]

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 50953e0f9772d..ad43d36c537be 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1105,7 +1105,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *
-- 
2.39.5


