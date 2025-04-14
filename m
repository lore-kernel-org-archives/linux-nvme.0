Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CED6C369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MiuPyZsr2cnIWip1FswD7hXRECFlWuoNV8OglhgQ1do=; b=tGB+KygIUNkMMKqBTl7KpvZNHB
	kdyJxmI/tvm/MILFxlVK9F9zlx0qjPLtixlC4wRUso9/dQoBzhMigmvDPtLTjBoow875cvX+4JwLN
	O1+2bIOPplPmezbCItNl/Tqk1a9fBa7F1x0sDafpq9yYmCGpShFdojgrypA4yzegaTqWRJXoxngSZ
	56BJbhPXe5fPI6B+eNzK87kRLC1UPPrgwTQqob3kjZ00IGOP7yCEXjnysbXZsFQhF2d8fkRQ6j6Vg
	73+vYjNdnvrKsJprHtoIFDzfJwkBOMfRl0Zi38/mz/Yd7CfS998bQ4VoGnLVpjollEO9Gf1BSUeDO
	NqgzYjeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JuE-000000029mz-3fLA;
	Mon, 14 Apr 2025 13:31:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JuD-000000029lf-3l1Q
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:31:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ADEEB61568;
	Mon, 14 Apr 2025 13:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E08C4CEE2;
	Mon, 14 Apr 2025 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637481;
	bh=zoXg8WRJFTRy7RmDZZQNLt3wyDVJhYSJ5hgWVHuxyK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3JJpQLZkYcvfQyXGG37YBTbOVVqdtcwsztWaFRT8nnSXK7AQoW+vLGVvLVLRD4pg
	 tcDbwVGkDirEhtLUAk6IZvyN4GaZti+8blzp4hBz+gOBPCECWp8UeE5et8p+Wpq7Lj
	 xJw8bpj2FyzQ67RPjW2QrWBilvMlMcFjx+eqxk06HYYvpUOxHIc2P9M0b1WyRZE+kC
	 XXc+lbGsLSACLT9M4OG6i+wZDLm85o6OnRLbvLJkz4dw9J52dVnL23OSaHrbRLXlHX
	 WRpHThlZNBzldIcrcA10FCK/NjW+zqzj3qY5gOquAojY++9NIgaoeDi3K8PjtC2iJk
	 m24ggwf6eZkhg==
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
Subject: [PATCH AUTOSEL 6.1 15/17] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:30:46 -0400
Message-Id: <20250414133048.680608-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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


