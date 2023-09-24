Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2ADCE7A8A
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Sep 2023 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Xa0Io692KrvNspSZDbDCs/izFawHMgsr//X69SYqYtg=; b=QFqOu613jRfZgH2sdszSHZKNKx
	tq8k4ggpkWRY+7Eq7jX+fZAPuoEjORnFzSAEkloCKpfuvx8Mo4yDxbGtl/339YZTtH1gtgiBxM4Lq
	NK75CYjv76Sl6Z5ogEfieZOufwFRQ1txSnAq/EAtCN+hMyGv4U5pmxIRlWGspU+0NTYI+6Zn8NTa+
	Wr9ug4g5aVag7FYqLCemqJqOng10HBbzCq+hfhh9vRJOh2p39Z7MZWvrfKBjv3N0fOO1catD9u64i
	yyr4e+vljwtP+y9Qqi+hjP1gtLP1qgNurJh/zT1egRE9t3TEaByNqSmUZo4I+kO3mK5zY3nYyY26q
	Q0HjqneA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkOzi-00CIBI-0u;
	Sun, 24 Sep 2023 13:17:54 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkOzf-00CI9j-17
	for linux-nvme@lists.infradead.org;
	Sun, 24 Sep 2023 13:17:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id E156CB808BB;
	Sun, 24 Sep 2023 13:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CFAC433CC;
	Sun, 24 Sep 2023 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561469;
	bh=7qx6tClLTt0813NcUQL4Qop7X18L1CzP2lAWaIgHtLs=;
	h=From:To:Cc:Subject:Date:From;
	b=jn/oOWtXPxzK3wyQFVq9jlmZlUO7qfUYDVlrU/SOq9LD/Ec+q47tjiKX3ZBHbNStS
	 6NDcpIuwIxu9thx6qjITyKfeYJLuRZ6Ae1OkVKILD8NCti7NzaYdnqcTdsvURvn+19
	 i3msN4SVC2UWDwpQ4YVH3Glumiks2wIcpXAtwQc8EvvBMVfedVwdGfJfd2VI+qWu8h
	 DKnva/tbrntoIuitx6UUZP6YLD9Kz/UrRdwfwl+j8eGzHlla6WuCVq3RY4ePm5mOgf
	 mqrVrQBhhV1hhQnRctIO9d5mDvZbxBSxE6J7r8xsclZF9Te83DmJ25gpgo30zTb4fL
	 AzLn3q8LAbwcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nigel Kirkland <nkirkland2304@gmail.com>,
	James Smart <jsmart2021@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 01/28] nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()
Date: Sun, 24 Sep 2023 09:17:18 -0400
Message-Id: <20230924131745.1275960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230924_061751_538972_A24AA2A7 
X-CRM114-Status: GOOD (  10.92  )
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

From: Nigel Kirkland <nkirkland2304@gmail.com>

[ Upstream commit 8ae5b3a685dc59a8cf7ccfe0e850999ba9727a3c ]

The nvme_fc_fcp_op structure describing an AEN operation is initialized with a
null request structure pointer. An FC LLDD may make a call to
nvme_fc_io_getuuid passing a pointer to an nvmefc_fcp_req for an AEN operation.

Add validation of the request structure pointer before dereference.

Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6c3d469eed7e3..177a365b8ec55 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1911,7 +1911,7 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
 	struct request *rq = op->rq;
 
-	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq || !rq->bio)
 		return NULL;
 	return blkcg_get_fc_appid(rq->bio);
 }
-- 
2.40.1


