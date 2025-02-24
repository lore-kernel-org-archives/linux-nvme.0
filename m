Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EACC021B3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAkALFkjbm07yjbOTekY/5/H6MhCz8lGFqEnQf+Tq3A=; b=X0QDnyAEfaxefN514XqnHSO9c/
	KZOmBO0ZSCzemOW3+SMA+nCqkH/XDVxYk2LcHzruM0dAfPnEq7Gknej7OV7Pg4K+ggrbXWNS4fcCN
	f0tHz3NyR5yZoaq8VXmY0eiKpQ7K22q9oEDgu3mlZd3kvjEkLBxrcKTVVxwOdozcpRefnBSVcGYVu
	PxuCPQblOLXo2D8HAV7/u7KHnGEe/slVCWrxxLResmmYsTTiLfkGfJQAPNcSTCfYpBasqaic6GY79
	6glm5y8GSjwBH0b0c6b3Jpa3AUs2abkJKRZlG/WcEcoHCu5SZqWTU2tDuTlF01tKN305jX6MmApV4
	tyDmcqsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmVRL-0000000D4Aj-1U84;
	Mon, 24 Feb 2025 10:11:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmVG4-0000000D1KJ-1L7L
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 10:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 166FF6118D;
	Mon, 24 Feb 2025 10:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EFCC4CEE6;
	Mon, 24 Feb 2025 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740391215;
	bh=A9uQN4pgxmAPTKbOEg1GKq42g3z8N6rW3R0Aq49Zw20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kviluAb3twh1PVkiWcvpyCDARNe8MqrrYLW2h9yUrUrTn0pZuxFzbRasUoA7YNfA+
	 4NcigM7MZHIHxgohf/pvmh8bTMswk+qy+cOjP+09JtX31wZJkMQ8kMLtOZSYgVb5YE
	 yZpKlXTIPXdd/x02BnXhFBbk3h1dGL+4kFp02pRiWpnUKOOerGvOt5QOjAe77KMWEn
	 beuBiIkJcxm+hsnXQfArXZv46IR/pOLedE/n26LtuWcQ+cvBDssv6gQR9xy3NuVCYw
	 jUrfb/X/mdPaEXSPtWPfweAz/V0LFd636YsbjCo2Rs3g8ng5NW/j9fe2FoB7ULeX3x
	 7Msv0TPr4OQfw==
Date: Mon, 24 Feb 2025 20:30:10 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 6/8][next] nvme: target: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ef7a6920384ab2f8f83c0f630f94edc73cd65997.1739957534.git.gustavoars@kernel.org>
References: <cover.1739957534.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739957534.git.gustavoars@kernel.org>
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

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Change the type of the middle struct members currently causing trouble
from `struct bio` to `struct bio_hdr`.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure `struct bio`, through which we can access the
flexible-array member in it, if necessary.

With these changes fix 38 of the following warnings:

drivers/nvme/target/nvmet.h:455:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/nvme/target/nvmet.h:462:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvme/target/nvmet.h    | 4 ++--
 drivers/nvme/target/passthru.c | 2 +-
 drivers/nvme/target/zns.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4be8d22d2d8d..13ee8026d3d8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -452,14 +452,14 @@ struct nvmet_req {
 			struct work_struct      work;
 		} f;
 		struct {
-			struct bio		inline_bio;
+			struct bio_hdr		inline_bio;
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
 		} p;
 #ifdef CONFIG_BLK_DEV_ZONED
 		struct {
-			struct bio		inline_bio;
+			struct bio_hdr		inline_bio;
 			struct work_struct	zmgmt_work;
 		} z;
 #endif /* CONFIG_BLK_DEV_ZONED */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 26e2907ce8bb..bff52252ffb9 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -268,7 +268,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 		return -EINVAL;
 
 	if (nvmet_use_inline_bvec(req)) {
-		bio = &req->p.inline_bio;
+		bio = container_of(&req->p.inline_bio, struct bio, __hdr);
 		bio_init(bio, NULL, req->inline_bvec,
 			 ARRAY_SIZE(req->inline_bvec), req_op(rq));
 	} else {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 29a60fabfcc8..afedbd984d39 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -570,7 +570,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	}
 
 	if (nvmet_use_inline_bvec(req)) {
-		bio = &req->z.inline_bio;
+		bio = container_of(&req->z.inline_bio, struct bio, __hdr);
 		bio_init(bio, req->ns->bdev, req->inline_bvec,
 			 ARRAY_SIZE(req->inline_bvec), opf);
 	} else {
-- 
2.43.0


