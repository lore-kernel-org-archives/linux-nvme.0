Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3A4C369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LIVw+TFUxVosMrcjI+0567BdjQZjhjRWN3g4xwKcQVQ=; b=txEQZdgthnSoPlKzQVKAMmiLjw
	Gg0gkrPCMDuf5j6UpXs9aAb8AiJnFKOYFeEdcKnCh+00H8+C+12y80pbxd9jjWg7oEwj9JLf4TFFU
	p9xS+4YfWKWBz4sYlJJhLtFGx9aL4wXLSoHMWs2vDGSL2Z7lBTtAwL6gvbateqTM7PuSqXmHP9EN0
	QmG/X1Pq10HhK1+r1MjvC0my+3DUmYq9askZ1T0YOxqCuGfx3ssM3DYkBZutrAuJA/A2kvi3JjvMR
	Nf5Oo46B1pDeiHTDWJoVmz1NE0q5ggy70qm8I1n2Nc+XVC7cfj/GSqRx+TiCTtCjIjI2DzBK0Obsz
	AX6cRGsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4L1l-00000002RWO-1EDt;
	Mon, 14 Apr 2025 14:43:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jup-00000002ARB-0NyD
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 13:31:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LIVw+TFUxVosMrcjI+0567BdjQZjhjRWN3g4xwKcQVQ=; b=Onhm3ca7S0zGq6xotfoy0PO9z+
	ZlihjMERtEZktyqfX6DXxj5rf0RGy5/oe1ooSO9UeHfBSvPs5+iLKdouTBXsUPexW3wd00wHKIfbG
	/oGaT1aD890D8OCLdwFUtLac/AMvbSb/R01dCWkfw820jre8CW/MgRGAMopob03AEQ+07eqQHR3dF
	1tl8wpqoSrYOU/Qd+wi1GQ0XLvefhmCk12zW8g3DxPDHDqNUY/syHTVHc4lnie9Jya5e7m2I7m9PL
	L7Fa85fC583u55+uzaYBkXA0rmJujTtcr++aFxiGhAYcI5Gfb/lPdJx+PAGQsMXyR3MwhcBDNUJEO
	2hbD3LQQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4Jum-00000009hJN-0i5Q
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:31:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 953E25C1365;
	Mon, 14 Apr 2025 13:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6BCC4CEE2;
	Mon, 14 Apr 2025 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637514;
	bh=gXYkN7rIv/AIE5AOvfkahXaOoDQRUBOAvs6q5iGHMvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3nclsR7PDreZn/D/u6/AneajT/sEAAjOizUSyN0hOmp93SjxhDdMsjA/hzCh+vnL
	 xSNPiGhyyIsrO+hrQ+gYZo5u9FXw8+QnaOmuBzYqbvD/if8U7tYZlQm+w75XXT188w
	 L6remtz+dlKh/rwlUPisuIqOMnc+PdPQ0K0GqrwvfUn1S1kks0dYV1dOD1iZ4PAAkF
	 1XTUsDSEb1DWC8DFS8mk7d/iYpzkAxOpUC6YgoK9lFiOUIbsqZYS8fFQ1gZFn4y/5j
	 L4j7acqCe6hty+ZZVBCXtVYBDZeNWz13vjmwxB8aFszYD3Q1pVoUh7p37DMYx9xfFF
	 HCVQHU2LmtLHA==
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
Subject: [PATCH AUTOSEL 5.15 13/15] nvmet-fc: take tgtport reference only once
Date: Mon, 14 Apr 2025 09:31:23 -0400
Message-Id: <20250414133126.680846-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_143156_448616_1DD119D4 
X-CRM114-Status: GOOD (  13.91  )
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

[ Upstream commit b0b26ad0e1943de25ce82a7e5af3574f31b1cf99 ]

The reference counting code can be simplified. Instead taking a tgtport
refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
if not a new hostport object is allocated, only take it when a new
hostport object is allocated.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d3ca59ae4c7af..606fdde21d629 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1044,33 +1044,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
+	/*
+	 * Caller holds a reference on tgtport.
+	 */
+
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/*
-	 * take reference for what will be the newly allocated hostport if
-	 * we end up using a new allocation
-	 */
-	if (!nvmet_fc_tgtport_get(tgtport))
-		return ERR_PTR(-EINVAL);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	if (match) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (match)
 		return match;
-	}
 
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
-	if (!newhost) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (!newhost)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
@@ -1079,6 +1070,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);
-- 
2.39.5


