Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F829C27C53
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=icRdAs3+JbAxP9pPPp+MxWZYif+CXdy+xKMXW+fOgfk=; b=dJuLGU9OdXeIfxS4beCpi/GbTg
	wozKbGUY3e+sNMiAeyQRDmp9X4Nzr+nI/TFUq2b9IT9nd5tBkOUW0E6t1cjCJJa6Ikt4Q/MN3Rp6y
	EXYTQcXp6J+jmnyUwAJm520YeU2at8xheyNlIcdMJKr3K4M2YTSE37W3d03DzBKDuGxzSljiXg99a
	oVODPIO8hoZV1/A7veBel0/c22KvGccko2j0f1tPyOxw9HA9PlYGIH8wn2mT/jKGS1kkBsm14qjRb
	qiBz+vxnpNR0OdI383VJy6FUM9FXkJQJcDeINcfPVk/lfQ4+dpkq8kaW8EBNpEAzK8yOQZ1l4BZQU
	KU1goRxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpPK-00000005sI7-2sgB;
	Wed, 05 Jun 2024 12:06:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpP6-00000005s9W-28hr
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:06:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A9B7E61835;
	Wed,  5 Jun 2024 12:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F16C32781;
	Wed,  5 Jun 2024 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589167;
	bh=0Q8eaGMyTpjn7ZtOcjGlTiOA+wWWTJCHK9F63KK14yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+oCLBIxUQKg9xV6MmTht1tGp/E+zETplYS3BHj5314VDAo2F6/0krI1gOn2qFvg+
	 JS/narjJIzjKoaPUNSAB7SR7yvjEDfOwXXcxyEG1HuVqvksoT/IRyr2FQAP901nfXp
	 jQ0z6hzvQ9kOR3T0pSI9KKCRqfs0iTplBrGK7XJbBaBKyP4D9S4UWHSxJnf5thJDHu
	 imSU3alepTZ8G20oDNHc1IegD192eQ4HV4mVl0khoxT5c5oCqaaJh5G6FG4mQOq8xO
	 jqaLgHzt9zIqTAstDwkPK73LXrc7vjepjEWQcG8NJJU7qK95lAYCDSVQjttBnmSr/y
	 BK9TGnDqq4lew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Alex Turin <alex@vastdata.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 7/8] nvmet: fix a possible leak when destroy a ctrl during qp establishment
Date: Wed,  5 Jun 2024 08:05:50 -0400
Message-ID: <20240605120554.2968012-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120554.2968012-1-sashal@kernel.org>
References: <20240605120554.2968012-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_050609_156277_FE1B5703 
X-CRM114-Status: GOOD (  15.05  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit c758b77d4a0a0ed3a1292b3fd7a2aeccd1a169a4 ]

In nvmet_sq_destroy we capture sq->ctrl early and if it is non-NULL we
know that a ctrl was allocated (in the admin connect request handler)
and we need to release pending AERs, clear ctrl->sqs and sq->ctrl
(for nvme-loop primarily), and drop the final reference on the ctrl.

However, a small window is possible where nvmet_sq_destroy starts (as
a result of the client giving up and disconnecting) concurrently with
the nvme admin connect cmd (which may be in an early stage). But *before*
kill_and_confirm of sq->ref (i.e. the admin connect managed to get an sq
live reference). In this case, sq->ctrl was allocated however after it was
captured in a local variable in nvmet_sq_destroy.
This prevented the final reference drop on the ctrl.

Solve this by re-capturing the sq->ctrl after all inflight request has
completed, where for sure sq->ctrl reference is final, and move forward
based on that.

This issue was observed in an environment with many hosts connecting
multiple ctrls simoutanuosly, creating a delay in allocating a ctrl
leading up to this race window.

Reported-by: Alex Turin <alex@vastdata.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 59109eb8e8e46..a04bb02c1251b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -795,6 +795,15 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
 
+	/*
+	 * we must reference the ctrl again after waiting for inflight IO
+	 * to complete. Because admin connect may have sneaked in after we
+	 * store sq->ctrl locally, but before we killed the percpu_ref. the
+	 * admin connect allocates and assigns sq->ctrl, which now needs a
+	 * final ref put, as this ctrl is going away.
+	 */
+	ctrl = sq->ctrl;
+
 	if (ctrl) {
 		/*
 		 * The teardown flow may take some time, and the host may not
-- 
2.43.0


