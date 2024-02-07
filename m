Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAFCC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PmEVV07U3g4Ske6lZ2bNYdk4NQmB+Dubh0YjunhbabE=; b=Z9/Bv+Sl/wWhB1G71/YB0EbbDz
	vwlcyBK0j8r7Rb6kwAQPDme4Ijm6EJFz3ix4xo1NuY8vUjqwCO81ydRX6tt2eQEwNg1sT3FQqw5eN
	CvXFVvAmNSBA7Le+SjQ08fLSkIUbzbh5xgJEvPWQppo7aEucYuR0sss54CYSuLZ6IVa/KRm3WlZ+x
	3kGFpIZhLoy6x9IG2QCxnqImoZw6iGO45M1cahn0YJnwn0iOkmMuGLvZmCWo0DODjnzBIZAFR4KFu
	IKHIPtCu7RcFsBNo5ICiwgXKW4Vob3NGuJ2YfbfC9c6mTo/no/VPHaj0jaATmgMHW6EDVNB4hNWaX
	RBdf9FOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpO1-0000000Bqj0-3Y9K;
	Wed, 07 Feb 2024 21:23:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpNu-0000000BqcN-2TaB
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:23:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 17C2A61ACA;
	Wed,  7 Feb 2024 21:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DDBC43390;
	Wed,  7 Feb 2024 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340989;
	bh=jn8CVBM55Gc4xDsM9BKIXkqAVUal6LD7IM+rOMVXPYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfnrQX6hZjT+JS5EwAdbjFho9pLJC65ElJZQL+EBiXX2oBgEB6aRc6FdeSGvODf8R
	 fsX1xBE08ILpJb/t6bjU1+v1zO/TqMpuaFzC+PCvjUT1mmfrdn7/lOin+Zg3vOG9t3
	 BWQqa3T/Jmb+Mzr/nEuE2rRCUHesetx+iq4gUKnzQlh7ikQySACCLUc436CGdQkcmT
	 SDBR/AsekV0QVf9I90Ymbl0WbKkEAc7mr9kIVcScFi3OBY6kOQhKoJccLBZF0Fn6Nj
	 mPD7o21bvyZrytOdlGTS5aFFLrWy194K3EurbbC1o9IvghxCPo/3/AEqLKXsAIKea2
	 GlixnMH7L+law==
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
Subject: [PATCH AUTOSEL 6.7 36/44] nvmet-fc: hold reference on hostport match
Date: Wed,  7 Feb 2024 16:21:03 -0500
Message-ID: <20240207212142.1399-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132310_865785_E3ADEE03 
X-CRM114-Status: GOOD (  10.86  )
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

[ Upstream commit ca121a0f7515591dba0eb5532bfa7ace4dc153ce ]

The hostport data structure is shared between the association, this why
we keep track of the users via a refcount. So we should not decrement
the refcount on a match and free the hostport several times.

Reported by KASAN.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 5fd37e989106..6d111b03d371 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1068,8 +1068,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		/* new allocation not needed */
 		kfree(newhost);
 		newhost = match;
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
 	} else {
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
-- 
2.43.0


