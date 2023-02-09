Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDDDC05027
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lB9xL7yRUpzDMKzlI8IOohzw4mHgCufxXReGFtMsfAY=; b=1PsYMo3x3LuMAmd54ro9+5/eMG
	4fRorO6Yb65vTd1l4IpeD+mJIHGeQkp3eIGfOvXty3MMc/Mb1VVH6SGEnmlrOYDnQn4Uhp/AgZBrl
	HsoyX4wYv6jxws4RjbfwioiKzIHMpZU9MQko5oQzAoqA1PYwtEL2yB+1JikTWRUpe2B8yJC51cwov
	jVRf0Zku1O4Cl25qQ78sRBrcF5aRFOsMHrpwCPodRfabQ9YokmPX67B578ew3OjtZTBuTW7igDR1/
	PgXrvzKHi1+y4c6WmLHgW8+t2drdo6nQ/mLzYPgkpq/L3W3qUOS9m+3Oz3ASpgimVLZDXRaaiycYy
	Hiz3Z47g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4yT-001GKt-TV; Thu, 09 Feb 2023 11:20:22 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4yA-001G8m-24
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 11:20:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7BFA0B82107;
	Thu,  9 Feb 2023 11:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D23C4339B;
	Thu,  9 Feb 2023 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675941599;
	bh=VlimYip4QmXbNgZABISrBU9lsnrR4iu0EX/ecs3U5oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCLrI7AuPZQ5/ufgW3f++XnRaSnzo3cJJMYJ84LCh5W4J96pWqhAkCQWxyq7QYSbg
	 Aavsfd10guOEoDwKQWTtPhqdTcJRt6pgXmVVRo9+X9ThkXFKuSYLrNxXtBDmkK7J0v
	 aIahj9XX4QZIfNk7NNb7SiAM/rMdukvl6wmE04sPE0rZy1RpVwUSSoV+VCL+DR26Kd
	 msi7MyjsHGpq/ipvAn6Yhvbww9U/9R89xw75HkFrI4gb6WEkUIjOjiZ1WAVslRpX/y
	 BX+c9m2BrR+BSsB3AUtZdIg2oEgyDtQ2bvCW0k/RRkeDthP/ibky+EXP+4jRusrNF0
	 LWw34izElFiYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amit Engel <Amit.Engel@dell.com>,
	James Smart <jsmart2021@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 10/10] nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association
Date: Thu,  9 Feb 2023 06:19:19 -0500
Message-Id: <20230209111921.1893095-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111921.1893095-1-sashal@kernel.org>
References: <20230209111921.1893095-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_032002_298519_4FA308B1 
X-CRM114-Status: GOOD (  13.58  )
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

From: Amit Engel <Amit.Engel@dell.com>

[ Upstream commit 0cab4404874f2de52617de8400c844891c6ea1ce ]

As part of nvmet_fc_ls_create_association there is a case where
nvmet_fc_alloc_target_queue fails right after a new association with an
admin queue is created. In this case, no one releases the get taken in
nvmet_fc_alloc_target_assoc.  This fix is adding the missing put.

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 9b07e8c7689ab..f74fc6481731d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1362,8 +1362,10 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 		else {
 			queue = nvmet_fc_alloc_target_queue(iod->assoc, 0,
 					be16_to_cpu(rqst->assoc_cmd.sqsize));
-			if (!queue)
+			if (!queue) {
 				ret = VERR_QUEUE_ALLOC_FAIL;
+				nvmet_fc_tgt_a_put(iod->assoc);
+			}
 		}
 	}
 
-- 
2.39.0


