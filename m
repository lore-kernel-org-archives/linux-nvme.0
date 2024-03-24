Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B788C6FD1F
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Mar 2024 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bNduY4Ih8d8bhnz5u68G8BnYjS7AouTGO7dwdAfcjyE=; b=FFXXUHwA8EerOQ2IBYvorY3x8Y
	KIIadTyOhavOBmn3BZ/o+xajhc2kynWzQDTbU8LF3kwae5aysZe+wrG6h8advR4+xPgOBmVa3E+vR
	RX4S+h5F0UeQeVLDi+5tGLGBAMvb0lNo1lbjPi2D9yIOQlc94ZqMDcMusRk2FaMHW3K0/7um3Fn7u
	pixh/vJDY2x0gZL7aI/xgHpLuTx4IkSCMNgqC4Y9Dzsb3K0bPZDlKZXSfDQfhd5twsTjzBMsHVROh
	cN+nMbQBkZ1duz8Wnu7HbNMZJjBqr863oTsZg4ur04wFhfZIxmYWUWMfHp788Ng+3iS3Ro5hSeTq5
	AoqCzswA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRJ0-0000000D1Y7-2JmD;
	Sun, 24 Mar 2024 17:06:46 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRIx-0000000D1Wf-2O2h
	for linux-nvme@lists.infradead.org;
	Sun, 24 Mar 2024 17:06:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3E24CCE0B50;
	Sun, 24 Mar 2024 17:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14607C433F1;
	Sun, 24 Mar 2024 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299999;
	bh=EMTz2DrqA4rESU7pXmXjgPYgY3R8oMc/rZtnvteLh48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liJCm0D/mQLvvuuZPykc2X1Pxmq+b0vN6kFQ9mS0dyeMZUaD+Bm3j3+rMMqc4DT/3
	 cxxQmayqLUIvUBtxNXptot4cvY8nbPdLmSUWhQ9qCCaXkWK6HqqYZS6JNWYpxw1JZ4
	 Ez2qid8xXyu5fmNxNfc/DmFch+eld82ONBg8asOlaOpEsumAwCVbAZ9U2Ij8JIWMsK
	 vacZmQhk8Z3Qumbc0q3zYAcat20tUlfCyJQk0apZgnbAH21hlYR6e8p7rdg8SYY8IT
	 SjQOiBApWDb9w/C7R8YSpalzqDDXrzZJmRypHI9eor+kmCIKW+6BNegXjjM9ZlFqPi
	 9I7+RnLRvgqyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 11/11] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:06:14 -0400
Message-ID: <20240324170619.545975-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170619.545975-1-sashal@kernel.org>
References: <20240324170619.545975-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.10
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_100643_877967_BBCA8E70 
X-CRM114-Status: GOOD (  12.61  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 7e80eb792bd7377a20f204943ac31c77d859be89 ]

The memory allocated for the identification is freed on failure. Set
it to NULL so the caller doesn't have a pointer to that freed address.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 86149275ccb8e..ab90b8a118351 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1341,8 +1341,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1471,6 +1473,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
-- 
2.43.0


