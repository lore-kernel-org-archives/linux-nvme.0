Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B28C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wN0V3GACbIS8Mo2Qofdh6tu/+edw+5+w+NvBy3Yjc3A=; b=GSR86rs0ceOpTUiqHyri5iDoHB
	l8WNF6LdC1JSfHyleit8U8bmK/kKXwJTdm6JOngYGZGtkvuQuyEP6Fk9HezdVsL2OnBwRWJ5uuHEF
	5fi5K3mzEm/yeP1Z4l8hHgA8CyTGlHqxOSPHHYr99Xi51hK//cdQJE5gaxa5Pv6Bx+tddd9R9Xmum
	02MrB/etnnfDmul1Zn6dWhkILvbYfhwuDTPoLt7oPDM8bEuF1AgXFgzobB6pddR/r3fHy8zEZTTXA
	dGWcSDrKH8CxYfkvjeqJufFs7Q4OOAv/nRX1ZNYwMZm7HX6oqCowjSxeN/ha6Tbf88veTRc+hxeti
	80N79xmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiluO-009mST-6x; Thu, 13 Oct 2022 00:17:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiluJ-009mOs-E7
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:17:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1F9ACB81CBE;
	Thu, 13 Oct 2022 00:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CCAC433C1;
	Thu, 13 Oct 2022 00:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620220;
	bh=SbOlvIFkuyxyhYg20Cv9c7JE7j32qJ/p3yVbNpY/YwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbLOjpX8SwzcE+BmVmRt56gUlrgH5wwO+/yY0wsRQ+jmerL+/vtUN7SEqhAHofLc6
	 Lq7ookL6zKZaM9DXlIELbUQiPAakmyW1ioZ07n+tPRiQ80vG5qZwjPhjeYx0xrIGvn
	 Sk/pElPPEWFZH++nFjGBQdmpJr+i6R7V01DeDfoiTosvKZk2WlkSIrwoxVeyZDtJx7
	 ExRMe9DWMCCclmGGdQozDx9XRLiVwpmoWIt6KZ1oIjhZIADotcKPoIMyNzNCnLjfo9
	 pFPajDOmFy3qeylS8PGpM/koNTjnfkaI23+xQR+d2vKM+4hjzBgc9wO8tHGloLroG3
	 udQQ3Y2vbB8QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jackie Liu <liuyun01@kylinos.cn>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 26/67] nvmet-auth: clean up with done_kfree
Date: Wed, 12 Oct 2022 20:15:07 -0400
Message-Id: <20221013001554.1892206-26-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001554.1892206-1-sashal@kernel.org>
References: <20221013001554.1892206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_171703_672032_E9ACF1CC 
X-CRM114-Status: GOOD (  11.83  )
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

From: Jackie Liu <liuyun01@kylinos.cn>

[ Upstream commit 42147981561c3344d2c6781fe7029e5900daa9fb ]

Jump directly to done_kfree to release d, which is consistent with the
code style behind.

Reported-by: Genjian Zhang <zhanggenjian@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index ebdf9aa81041..8458ec40340b 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -229,10 +229,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	}
 
 	status = nvmet_copy_from_sgl(req, 0, d, tl);
-	if (status) {
-		kfree(d);
-		goto done;
-	}
+	if (status)
+		goto done_kfree;
 
 	data = d;
 	pr_debug("%s: ctrl %d qid %d type %d id %d step %x\n", __func__,
-- 
2.35.1


