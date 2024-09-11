Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F09EE4989
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j8lgyS5dMPeO2qFkYi30AkvOg4jJMB6frjU0fmtL/DI=; b=QJDb/UyuW81nAx5mn9FUSjib2s
	VHVbDsaTRcJAmeapsd+HJkYVsEnxNYA7zL6BWD9SfJV87cP8H5ORyqvIojSY72cOhMZEfXhyAtgAD
	Vpb2b8FCMZyoPNtxEIsibvblccYSnSdmOP47u9QxBKqXWTbnCEUiFmk0mQkpJ5b2aftq6YyAfqKS/
	I1C2KsxITIHfDwqItAa0lcfJF+z2IJjnvs1oFeywF3GHaKnzvElimmPqh0aBtbPZhxX32sA8U3umE
	tsJXsr9uk5Lg3HuQ/yPhDWw29sL3auyMj3dKvqlF/G200KJBKgfJq7BQeQub8SAVPs5u0kWkZNkex
	D3Wa4sAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soK0f-00000008zSv-0zZU;
	Wed, 11 Sep 2024 09:51:37 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soK0M-00000008zMo-1ih4
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 09:51:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EDB0DA44B86;
	Wed, 11 Sep 2024 09:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3861C4CEC6;
	Wed, 11 Sep 2024 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726048277;
	bh=+gdjB79noZuxpKg7Fo8CxJSoz0h+b+eS39KuQFoFvps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7cAYSLolGq6KhrdwnWerzqurY+rdOuVYpXQyDCvN4/ZvQanSRkqUSeh3csDpiuBS
	 m9T1E4kKQMkmt5jqdwJVQWLALhU4Fcvn32MV3LDBnmQMaVbJgtv/ME9DsaguSAwPxE
	 dqS4Nxu68msFF1UeFvvu2oZubNEAEbhjStuW/sCbUH69rmQtjye4DlllRZq3qNKwF1
	 xDJnxquiCOM0QGfP6serzi9W94S9VEQrYju8mTL2dbH9FBPXY3AZbbd1eNsavda8aB
	 oNKMe3Y4NxHncbTq1nCbAPOVxACBfjrjckoBJoK+faYRZmBwisaWIlD7PhgLsqXcx8
	 evogQfU6ztlXw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-multipath: fixup typo when clearing DISK_LIVE
Date: Wed, 11 Sep 2024 11:51:05 +0200
Message-Id: <20240911095107.121688-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240911095107.121688-1-hare@kernel.org>
References: <20240911095107.121688-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_025118_534059_005E5B54 
X-CRM114-Status: GOOD (  10.75  )
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

NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
'struct nvme_ns'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..c9d23b1b8efc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -646,7 +646,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
 		if (rc) {
-			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
-- 
2.35.3


