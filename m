Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AEFC54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ekpZ9wbCOE8rKV3aautbkLop5viZ14Lgrr6RDyps9Lo=; b=lTF31hm1lSqDuzwtQ7UpQsUgJZ
	Pe0yD8o2Tc60Wv88bae5gQW48Fa8X7LXSSlXijEnEQCrxgVFPTvfgVQhbYUlwXVrjk2oVwOthv1l8
	lEkr8vNvF4riZILme0/3x7+L9WKBnX1IvDWIR1G7yHm0nKr9IjsI/XsjLavu3oX+ZlCH934GGVE3j
	7gbR1B98Y9OQ8Qy6moc7LYsYgZcrznLIi53A5Wg+Li+e0o7b4+ibz8TI2HsbsWJ7OpYqdGNel0wnm
	oURr4V/HLb8LushES12XOyUwNKRRO8fC0jtpyDjT0XOWFAtLi0UtnEO6v8FnFr++U1+YZOqi2Wgmx
	xdsmIYBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1xS-00000007egc-2IUL;
	Wed, 29 Jul 2026 10:56:18 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1xP-00000007efQ-4310
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 10:56:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785322572; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ekpZ9wbCOE8rKV3aautbkLop5viZ14Lgrr6RDyps9Lo=;
	b=Pcqq/cXOGua9TYVhG1rr1hz+QqI6CV8REiZtdE9d1uHBMKBq4C3S5z7hCXLLSxkrve1RiNPwP1wMSA4Y63LG139hxDM6ZTNUy7g33yS7C8qOY7Ixgc5e25A/o6BBspIxBXGu2Gts13UyN+daZiiXYEBe/wBw2oMnGGW1d2BCuhs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X82000-_1785322571;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X82000-_1785322571 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 18:56:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvmet: fix return status of RMI log page on allocation failure
Date: Wed, 29 Jul 2026 18:56:07 +0800
Message-ID: <20260729105607.1398478-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_035616_205692_6EDAB238 
X-CRM114-Status: GOOD (  10.81  )
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

nvmet_execute_get_log_page_rmi() leaves 'status' holding NVME_SC_SUCCESS
(set by the successful nvmet_req_find_ns() call) when the kzalloc() for
the log buffer fails. It then jumps to the out label and completes the
request with a success status, so the host is told the command succeeded
while no data was transferred.

Initialize 'status' to NVME_SC_INTERNAL, matching the smart log handler,
so an allocation failure is reported as an internal error.

Fixes: 5fd075cdaf36 ("nvmet: implement rotational media information log")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 01b799e92ae6..0b24d31f966d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -309,8 +309,10 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 	}
 
 	log = kzalloc_obj(*log);
-	if (!log)
+	if (!log) {
+		status = NVME_SC_INTERNAL;
 		goto out;
+	}
 
 	log->endgid = req->cmd->get_log_page.lsi;
 	disk = req->ns->bdev->bd_disk;
-- 
2.43.7


