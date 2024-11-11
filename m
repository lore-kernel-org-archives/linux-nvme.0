Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55F1D2E9D5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ANaj5cw0dJXBW2aHUxAtiqksuPuFswPm45+aKlClaSI=; b=ZagF6tG8RoRUegjsaVJwvvB6M4
	k6PobLUUlGBfREE3ASghEfnut5wyod8C3Nnl/NE3C+W3+bJ3qUR635LUoDhLhbyiYYLzQDH7cKMI5
	rIN6lj44JDKX7hi0TMjejRC+ch4tB0jzfJDMgf4gccOt3xJp1bICDdiEPI1D8LL8TMg2HHVb3JrXn
	0VSi2nUL87kfMNtZwwrwuVcL6GM3BaGGe2tORJ9Qrbu02oLGwXsFJx+ftOe6p5LALPg892TrKoUGg
	MKZXmhAUvmG9Ou4CB3dmAKlhJ8YiDU0ySEYkXgFCkOTmTUpo1+3eNcH9jUP4xX6wHz64ySd8Mbp4C
	QGL7wm8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARrr-0000000HKEI-1h4v;
	Mon, 11 Nov 2024 10:41:59 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARqg-0000000HK3s-1uAb
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731321643; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ANaj5cw0dJXBW2aHUxAtiqksuPuFswPm45+aKlClaSI=;
	b=wNwIdVsKTBjfNWTBd6Oj9X7vnlOFRVhBCoCO9Cu4SPt54Kf5pfbNQ2TO77V2yWjIDCf58yGW+MVtHTKNLD4/0lXYajlui44shoWbsfEO3iVBsFau0NlUS3KVfzgNwc6Yc+wRj05SPDCIpvqQCjKZs+b7iANUBTUiU7piRh6yL/0=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJ9qBV4_1731321635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 18:40:40 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-nvme@lists.infradead.org,
	oe-kbuild-all@lists.linux.dev
Subject: [PATCH] nvmet: fix the error of point math issue
Date: Mon, 11 Nov 2024 18:40:35 +0800
Message-ID: <20241111104035.31770-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_024046_966465_DA4EDD49 
X-CRM114-Status: GOOD (  11.87  )
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

Fix the wrong place of parenthesis of ctrl_eds and data point in
nvmet_execute_pr_report(), switch to "void *" first and then do
the addtion.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/pr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index bef82135a0e7..550effcfb9ad 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -848,8 +848,8 @@ static void nvmet_execute_pr_report(struct nvmet_req *req)
 		/*
 		 * continue to get the number of all registrans.
 		 */
-		if ((void *)(ctrl_eds + sizeof(*ctrl_eds)) >
-			(void *)(data + num_bytes))
+		if (((void *)ctrl_eds + sizeof(*ctrl_eds)) >
+		    ((void *)data + num_bytes))
 			continue;
 		/*
 		 * Dynamic controller, set cntlid to 0xffff.
-- 
2.43.0


