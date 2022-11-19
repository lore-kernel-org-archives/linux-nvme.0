Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA395C4321E
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Nov 2022 02:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sUaI3jU8qrPRLLKSqUHH5g9VELtyzAawDkgmnlgHQB8=; b=fbgrSWG/CCunfr64/O8+OvoWZ3
	hdrhA8PLSMkT1cl/pF3a5cBIQBrjhgL0eF88mG2QHixCYSntS65R4L2vTmQGHQ2Gx0oS675QZrYId
	2SqdC0NnJhyYZZDGrBbMWZ9ZX66OUYm1dDHQVGrbVclWWQUVS1IkgUo/lG+qzwdIMx5oNi8W0JHXf
	SChayGeEuR3KlC67sWg+GOaTH7kaVSktKCcpna0vb0ValxBQk7xcY41rgaq/6ICdWKDo9Xkg7cSFz
	b6jBK4qRzC6p0ykaJ8TXvitsh7COHXq0PTev41OJ0JH6acSVL80qtvQwWeSd4JqMghW/hxHUq1D+j
	W932qmgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owDLg-00AFYB-Bl; Sat, 19 Nov 2022 02:12:52 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owDLQ-00AFPr-Gw
	for linux-nvme@lists.infradead.org; Sat, 19 Nov 2022 02:12:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 0684ACE2237;
	Sat, 19 Nov 2022 02:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47176C43151;
	Sat, 19 Nov 2022 02:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668823950;
	bh=wx+cZ/J7M+blFaEXEUjPx5yDIGj7Mpl3HkIHjrXyaCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+xmA3DaNldruGzJHXNpnkiATecUqV0L/mMQ/UZstivvSE2w0+PErLQgNhCMPFjfz
	 l8kGG3dfjdF+9vYBuEriYV85g5cAJxiZz0HtDabiWaaq8PjPm2YSy1zoYhLFi5XTcn
	 pxvKSHQpnOohdRgPQ39ZR6xnZS1MLXbZQyQ8qWXYjjFkFgSFuMK4r9DXmuvwxPmiLF
	 AOipWX3Qn5XhfKKsmo5Bzb4jU0I49Lm3L/CR6MAoEEGoWM7nvw6ZZNw2HsVNxvR1Wi
	 wMvocyzliGKCBOaodArdGtdqxzpu5/uh3g4OzZbkMR5C01mheas+OhNL5iOYqVWf0n
	 8aUMnW/7bl/8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Miloserdov <a.miloserdov@yadro.com>,
	Konstantin Shelekhin <k.shelekhin@yadro.com>,
	Dmitriy Bogdanov <d.bogdanov@yadro.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 32/44] nvmet: fix memory leak in nvmet_subsys_attr_model_store_locked
Date: Fri, 18 Nov 2022 21:11:12 -0500
Message-Id: <20221119021124.1773699-32-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221119021124.1773699-1-sashal@kernel.org>
References: <20221119021124.1773699-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_181236_772859_B03E929A 
X-CRM114-Status: GOOD (  13.15  )
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

From: Aleksandr Miloserdov <a.miloserdov@yadro.com>

[ Upstream commit becc4cac309dc867571f0080fde4426a6c2222e0 ]

Since model_number is allocated before it needs to be freed before
kmemdump_nul.

Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2bcd60758919..962b64b7447e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1215,6 +1215,7 @@ static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 		const char *page, size_t count)
 {
 	int pos = 0, len;
+	char *val;
 
 	if (subsys->subsys_discovered) {
 		pr_err("Can't set model number. %s is already assigned\n",
@@ -1237,9 +1238,11 @@ static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 			return -EINVAL;
 	}
 
-	subsys->model_number = kmemdup_nul(page, len, GFP_KERNEL);
-	if (!subsys->model_number)
+	val = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!val)
 		return -ENOMEM;
+	kfree(subsys->model_number);
+	subsys->model_number = val;
 	return count;
 }
 
-- 
2.35.1


