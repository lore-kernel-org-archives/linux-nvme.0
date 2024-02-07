Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52C9C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h51u08wSB1Zfy9HJuKAmHvblmvuvcP9z+oV2+oz+p/E=; b=St6cbZsxEPkFzvowyn7/d9FNM1
	JIXeVKxZrTWDoz5dYUFC9OdgsQNoKTc9gnw33EMhhVEcZXbHYQCwUi770jIP3uzibavWNp1jzsTCf
	s2oift/W4tYne8aM9VVfHfBAvqhQ+S1T7u9CwjDXNy7Ct5q204MF7M0HVuge00LGKM4fxL6nM/Hpj
	i3Hd7GZpKc9CWTbHYyTMf84Pfp1GDW31uZa+hM1LZ1wT6fnM1ss8nRxBxu206zoKeBOfTq/N8mc9M
	O73HXSwxOsxsKIQKCiDyouuy30Ex3sdOp+QzzUrzLJrwX88OqqgMmOBQZtDSOX8RIKoDlqcg0eU4T
	2H0l2SOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQ8-0000000BsEF-3IXU;
	Wed, 07 Feb 2024 21:25:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPz-0000000Bs7i-323k
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:25:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F01F061AC6;
	Wed,  7 Feb 2024 21:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B92C433C7;
	Wed,  7 Feb 2024 21:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341118;
	bh=puyYeSo2l4KlFnf4mF8m+ZlwEJOPxG5a5Ms/4Hho2Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOc+r8aFoEh2xdcecRSDybQz1c2PzM0Fg63cZD6a9YV3sOKkRxYaPh7fHIRluckWi
	 VUMvw4NQjKVtsGY5sNQGBnPYeq2TXucDQEmsIdgS3aVwaEPW2CSFOcZkK1RzxPcDIJ
	 RdoPS1S7kP2COGkCDRYM3phShA4aES169nFBAsihAMmVSrJFqnqFMM0uMWcrBqvf7o
	 mBUQIlVPcFBmM8STwmyuzOqCn7Agi8YtZZRlDuMH2P1DRJhcGNoWl2GAlWbhrYEZSm
	 mzCGLuSzvAIVulZCCbjo/3fLKooum2VGjBReq7RQ9I2BQ/A/h8bf/K1SV5sfPGsj4G
	 8WBI3JXgvb7+w==
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
Subject: [PATCH AUTOSEL 6.1 08/29] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:24:33 -0500
Message-ID: <20240207212505.3169-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132520_194611_578DD0DF 
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
index ce42afe8f64e..348076827469 100644
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


