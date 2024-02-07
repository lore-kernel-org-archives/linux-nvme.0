Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6D3C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7QqqBvNakcXF84WK0b37SoIyPsLoHKb63qT0o2dVyXU=; b=jJu0+Ek0Vo18aY1G3fnsmnpnHl
	zhV20CG+SkVBIPASE33EkVKZmkV6ncAyCECQSdtty6axIAFDk14NKmtxu6RJwJiCzReyXbLm+rCTs
	+lFdrTYh0NPjAYcwQ6r+uIMfxHG5HRpIQeYMFaoVDqSuiuSQlTKL41r6QCTveJ2bM0NJCCxAWxnle
	HRlqxBieDZnqLRf7hwjsWGFhmMRfOZSLj8O72JRgyaSBJmrm1Cn27YYN+Vej1iIMjEy46Y1C6br/E
	qHsU/6eZNWWAnaUMCPtKNZfFLA1rp5x/9XwPY/2xYA81QFjGGjXSNrVh1DVwnE0zsxWU39lnr66Pq
	zZGUxq9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRx-0000000BtXz-07OL;
	Wed, 07 Feb 2024 21:27:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRt-0000000BtUE-0Ytq
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:27:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7QqqBvNakcXF84WK0b37SoIyPsLoHKb63qT0o2dVyXU=; b=LSgPZjA61byOx3C0/Q/NDJwPKX
	23FhvUPZzcbxeJFZyJkTC8botMWh4GN9iQ033EjYqpoenKgBsTTBajWttfSD8G7S8vGH8ORXakqr+
	/Y7Ig/AP/Sa9sFcc9qy3J+7SuwXit+eOGTifnQcjYfqJuzxRVjP35Qyji4Kgkjks2WQb+dfAeUBzU
	XS70AxfKVVqRPy9t5zEEIi4JD9oC3XgkDqYSZBfQgSK/xb2Lv6mwZL2V5AU4QiQOaNT0OpzISqfZ1
	LrjkAE+WO5aChYpWIfiTUxako80jWChoi82h/Cp0dqFWfO02Av4sN1xleOaxoL1FikE+Wt+NbhTPx
	b8rrYXWw==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRp-0000000D8HT-0xpW
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:27:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C518361AC6;
	Wed,  7 Feb 2024 21:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275D4C433A6;
	Wed,  7 Feb 2024 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341231;
	bh=PtluBwb/hTPum/AkxPGIjQDPKHKLJXdNLqHDtulcw1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Esfgsvt47P4fJl4pTFUAfKeDhBRVZuk6+I0kg5LjssptfcRjeeYnazAppcwRCez6v
	 bmxsks1nnLyJxIB5mght8eZ5rXhNUsf+9mMdE65L+VJrcz85AqZNxco5iDE5JeLAk+
	 hP4X7kzqIYE28rwVSsRoFM8U5NL96mV0TswAFP4XW73h55kSdV+MBXTX3k6KhxA6gY
	 Auyt34cQ17/sv647UHsqp8YUAgrX6vYhqlUiEhd9UhOvYZnP9cqclvX1bq8b29QsAj
	 /ACXsACgYPooTCWauUVXPNbCZE+D/xMmGnQ5G54lJdApsfc5P+t9jk4Klq7ByqW/BD
	 RVoG9SEr3dvOg==
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
Subject: [PATCH AUTOSEL 5.10 06/16] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:26:46 -0500
Message-ID: <20240207212700.4287-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212713_957176_C9251FEA 
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
index 116ae6fd35e2..d70a2fa4ba45 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1852,6 +1852,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_scheduled_work();
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


