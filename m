Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0722EC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJysPI4Dke5oSXkk/rBXtMZVX/8MT+TfDD6txgTUSnE=; b=TPBxDjntlLE77Vt2flHNEft4os
	wdbEpiD+bknYWgDwL7uoEVR4SM1rYQZ1KyXigbwes8sbQEYfOIzPhzba+r+ekFEOW/Yn7QhmK8zCN
	6DXBB9zKVdngXqfaGpvzjausYYU7c0PLnwK+QVUtDK50OdAfzoqVgwlz3IOw93mv7DjenNJtcwjTu
	9xP16yxTYHy3eIFsMo8LDDamRzp9khisKoPEcfX1dGRH5cg/YXs/ol5MKq3a/OgLSPjsHtR6gH56m
	hm0mUDRiLWr9m8v55ALddbw9VpOn1t/7A765BhjMV7MyrZxYVqXZeMv0GAxYLvxGzIG6TuwfH6KPN
	7geEAWTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpSZ-0000000BtwM-0fpQ;
	Wed, 07 Feb 2024 21:27:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpS2-0000000Btc0-1UQA
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:27:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8FFF661AB3;
	Wed,  7 Feb 2024 21:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C21C43394;
	Wed,  7 Feb 2024 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341245;
	bh=QOfzfBWnSePPrn3EU/czqjpW8X2ZbStvoN5lzrDArKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqGgRgZiFF7NOR55bEjMMgxIC5FY+6mPPpK8Wd7NhVkN8VgilQlLOO4RuAPCp11tB
	 j/kHl31U7cnfKgYlvcIFwvhuI6vdGH8sgZbx+NlIQr4u5SRytYA8Su7J3l5LymEaHZ
	 QiCAk4JisXokGU8jqvc2d2Ul/sY7wUf+tWjGvRQj/UrnDbL4GOXHofGCP1uLf9L+KJ
	 X+oOW/Mou0SftLETm1pTf8z8fsCOtMIe4wQ/quaTqgmNPfQOIOVp9vPv6Id4pO1WrO
	 AziBPjY5eGy5BKpZ7ezSmyuv2hmsuz57N3u0czl/wiEq2SXv0FDCAI84JpfOj9bZwa
	 QjMOySDjK4pqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 13/16] nvmet-fc: do not tack refs on tgtports from assoc
Date: Wed,  7 Feb 2024 16:26:53 -0500
Message-ID: <20240207212700.4287-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132727_074941_B6820E1A 
X-CRM114-Status: GOOD (  11.37  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 1c110588dd95d21782397ff3cbaa55820b4e1fad ]

The association life time is tied to the life time of the target port.
That means we should not take extra a refcount when creating a
association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 18a64a4fd8da..ebbc513682e1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1110,12 +1110,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (idx < 0)
 		goto out_free_assoc;
 
-	if (!nvmet_fc_tgtport_get(tgtport))
-		goto out_ida;
-
 	assoc->hostport = nvmet_fc_alloc_hostport(tgtport, hosthandle);
 	if (IS_ERR(assoc->hostport))
-		goto out_put;
+		goto out_ida;
 
 	assoc->tgtport = tgtport;
 	assoc->a_id = idx;
@@ -1145,8 +1142,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 	return assoc;
 
-out_put:
-	nvmet_fc_tgtport_put(tgtport);
 out_ida:
 	ida_simple_remove(&tgtport->assoc_cnt, idx);
 out_free_assoc:
-- 
2.43.0


