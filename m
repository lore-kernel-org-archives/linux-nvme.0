Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E46C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yH6gOincvsiKmch9+0hgn1KSeHgofDTqEPYXFfmAqDA=; b=locM9hA9SgdwfYd0AGJTHqrw0m
	xZBXhY5suViqYj+Q9wE65MRgVpl5GTYee5Xg+6Q/WobhgDYOGU8eB66w7FWJQWaLfR6Do+LA+XfEF
	ONWzeqV5r/Nv2WcbzMyobG8/rp0ugjnNFjWROgcaoDgqQS7fkw65prQlzwcMPVbK65Vh4DUoyupUj
	Lw14D0ZpbUMvxOkKgns/K9hwH/lkw2coA0O96E+jGCIJaKC+juXWKua5lWvIPrpfGNpthvbP2167t
	hpW98LqH4VIgJQIs5WbJOyaQIu8UzsUTuZRvsjruNY2Ly0fnCcLcBOiSp9IVxByfD7QyKxMl9rqae
	nxTtnclA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpMw-0000000BqD0-2Awu;
	Wed, 07 Feb 2024 21:22:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpMu-0000000BqCN-1jYU
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:22:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C1BAB61AC6;
	Wed,  7 Feb 2024 21:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B57CC433C7;
	Wed,  7 Feb 2024 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340927;
	bh=lZyhELCGofUNRqQmKhsc0dA6pzAI1lJzPtX2LcPIwsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWCSPIPGT8knF9Qq0Sy4N71HGH8cCfYhIWbSuNmJOlkOyg27MuNpfuRjyrQzGkZjB
	 sGDesl5LHwSvM6AJ1pGLLcJuI/bvBHTn1AUCL5GynIbwrAOeR5WDoHrfF2NlaamB6p
	 1waIcGeA4C4HS74J2SG/9+HKHPQ7iaI/VFKpiNP9WC7ieorPgi92IBh7M4gmKq/78K
	 QsF4pHE/3dvBMkDKjKcbL0UcJZvd6IkAQcYKZ5KRV5wByppHuSilx6VIT1fi4Tiw6s
	 5d9guY5h+yTCxdGldq0W2eoCBuj9N9GgnfdY7RnlabeAS5q8pGyVuS/5+udhS4EBlq
	 b4HvYrs6Apefg==
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
Subject: [PATCH AUTOSEL 6.7 13/44] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:20:40 -0500
Message-ID: <20240207212142.1399-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132208_517847_F81AB70C 
X-CRM114-Status: UNSURE (   9.63  )
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
index 80db64a4b09f..bb42ae42b1c6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2204,6 +2204,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


