Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41A4C4829A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QQdQp0B4MSZ3FO53M39TFqJwPq68e9PhrUp/WP6MHBU=; b=NVD23RBFTW3g2W4uNtSHanvXCO
	R5QaJz8qh1u0MkN6cDZNJli5+YSMb/t/FaARTHvPvmTZ/1ZAcOmUiGarDrd4xXCDNGj+aP8+W8zT9
	nVed4AFPPgk+Klo5LUQdb6akYBqzALQclPz5iXZEXHgrofqpWyjnjmpa1m4Naj5ZwLtOwyvAdvwbN
	Dj9xk85nNfk6vE4nnOdiOkNcuGyqjX1J1w7ZAFZC8QiSqdEb8Qnf5rXnBZWMoRNPgBj+tHZ2YaYL6
	8dEJGCtBgiUmifyPLIvbECvPntggkpRGJzteAMg9h/AnjCZ8Qi7phPmrpAwS4lC4O0fOK6agq+jWB
	5StEcZsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqS8-0000000C6yJ-1Ph5;
	Wed, 07 Feb 2024 22:31:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRA-0000000Bsxq-22YA
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:26:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QQdQp0B4MSZ3FO53M39TFqJwPq68e9PhrUp/WP6MHBU=; b=nWRANk9qkXTQFvzmPNGs6xcRdC
	ZtnjMRA7zPesUuvIa3gok9IhZru/t8EJj/bodBEpiJotw3xoBG4WQQGPlcRRZEIW7hp0AdpUgmcq/
	ZssnmUzV3uW4uI6rkZL7nSU7tEPx+7FT3M04QIn98ivR3fKBUOFb1SSE0fHXCdI5Qxu6MTV5Sz6pO
	bCp16TVHvFGV6gSCQYqpT/79VWRZGqu6DPOqWFM3uKbIqKiDsbDT7q11eciJn9I4bdII/9gvamb7R
	4C6jakV9tgIfV7hAWbEWDPwckKG33gY1g/jFWm/yBCnbW24IJoXc1CCCu06Hj1sBL8TyqVDQyJHgS
	8Ilm906A==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpR4-0000000D88I-44so
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:26:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0234CCE1B23;
	Wed,  7 Feb 2024 21:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19520C43399;
	Wed,  7 Feb 2024 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341183;
	bh=imuON0HVbiYuzTa5eEKSxtopIt0kcfoSoaAmegeTGEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mrc5cFTGtnmKa9IFYVh97EfK8MnK9uhP+A4zqJhtJ4R0hsS39DIBOR6Xaj4ULywCb
	 hyODUrbg/HW7ahAQkaHgvgZpM9Irlfnjt0OQAc/+ZpjFhSIFpuT4W49OFeos2TJTGH
	 e10DTX9iq7S+tcbzrGiTciH7ui5S50dPfW1NjRPDtuuSvjG9o7xDrd0pZs4lqu+Dm2
	 A6hekCQS7Necxj8KJe7Vm2StiZ8LESaj+QSRyL046gx/traCZCQ1xLvq3Lvhmgoj7Y
	 HLmlCPf/FDI0F3WloiLvXbqACnFlVVLuuL+Dih+RBvUsy2bbx5iw7pOIO0UCoZdxvV
	 7Wf+ZeqY2iNag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 07/23] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:25:48 -0500
Message-ID: <20240207212611.3793-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212628_806956_7DBC38F2 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
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

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 47c5dd66c1840524572dcdd956f4af2bdb6fbdff ]

The nvmet_tcp_queue_ida should be destroy when the nvmet-tcp module
exit.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4f2164a3f466..8468a41322f2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1884,6 +1884,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


