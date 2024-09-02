Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337AECD342A
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95oSKhCn9Ok1L9cZ3ceg5jvwgxCEMxqUiDh2dHeeB/Y=; b=fyfZzB8K8EMuJs2tF36JCM7GTi
	P88tJ7zZSeqWE1GPoB65TwEh8+GaSGfrXtE0u0zazL8VgDlQvVd+dw6FZVBibLKmcpRUp9Oy52kBz
	VB/a4wcBrtBXjGHCQbVupGTXbr0VWa9iFKWINHZ0curGJ1ExLSyZ5JzUgR4TWFDAK3Eyyicy50Rcl
	B+yiTYaU2sG3oKC8ZG0uVkJcUyQLciB31xz76Um3gltFKgJwoPKh/LsPNeiD5PXqifNGSsfEiSePz
	bHhbNx38gA7NNy32E0KvHcIcwt5316mFmhB5guR2MSbJS9XucLKih8eLGRVLdH2mKHhfmBA79Bc2Q
	lSsAE5RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52O-0000000E58B-35Dn;
	Mon, 02 Sep 2024 11:16:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52L-0000000E55r-1ebb
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 11:15:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7064E5C580D;
	Mon,  2 Sep 2024 11:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4968FC4CEC2;
	Mon,  2 Sep 2024 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275756;
	bh=mMoetDuL4AftFgJnR2xE+u6kHumcy1hs7+fLbZMsKIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMOIeHBZt3BtwLgo1TDAdIZbBhWKCrVkVcVU2xj3A/7RMrVxK7V4kMinqPNcH6FeP
	 8zErBUU4hpM/4uBWrFLASYEFD2FmOJ5kcyU/Osny4FPWklJ52/PIUXWKRewY0vJDan
	 Yz7cnBgWV1TeDRaByOR7L6XQ6qaWuAubNGgthTThzo8/GTv5DDLFhBOsZlQddm4jXj
	 YMohJPaX9WRdtEN+SlKY7hv+5ZPtTgv4ynZyng5Nyd4b4sznbA5wxUR5dmH9X0QQxL
	 0nRzoAeDM253dnXnRYRHuunZIENzKkCq9RcFzfMGVG3EUT16q1sOKaPMw12zrqhDUQ
	 uLOti8UUsUyNg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/4] nvme-multipath: clear 'NVME_NSHEAD_DISK_LIVE' bit on shutdown
Date: Mon,  2 Sep 2024 13:15:46 +0200
Message-Id: <20240902111548.41430-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240902111548.41430-1-hare@kernel.org>
References: <20240902111548.41430-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_041557_497232_752162BE 
X-CRM114-Status: GOOD (  12.30  )
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

When calling 'nvme_mpath_shutdown_disk()' we should be clearing
the 'NVME_NSHEAD_DISK_LIVE' bit to be consistent with
nvme_mpath_set_disk_live().

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c9d23b1b8efc..01dbbe866d61 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -968,7 +968,7 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 	if (!head->disk)
 		return;
 	kblockd_schedule_work(&head->requeue_work);
-	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		del_gendisk(head->disk);
 	}
-- 
2.35.3


