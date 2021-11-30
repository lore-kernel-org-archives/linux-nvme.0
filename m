Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3466C43217
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GuAQo64w2knwbj/zrGkxPkgVUws84sOVSqm1/iqrP+0=; b=TV24KL1g3J2KQgUizTAZNx+DPv
	LJ6kQ3zKFNYdEPpHdlzF0ScelGpbqLmbY9+zv5H7dpvrTi+7CD666Vv1k5lyvZlrH9lWkwT0X8m+F
	97XHQ5DOxsICILO0P/MUbpqKC0nvQdTQCOG9tcW8NMZZTVeS69DaTdXIZJwONwSB74wA4Q7kb5+ep
	bIZmLrHOSYyQ4iQEMMdiTjAoLRdf5qiMrkYrOzyMfZCkrNtbinU9+eZdj40YLNqiUSTrWlNxKrQKc
	xq/84Kmx7J/N4v4Xy00TthZ4y5bOYsyI5pFwEZZFby0ngLmS2Wf1ThRD1kMW5XrbZz+WCh1lf78F7
	G4PPavpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4fD-005ltW-Nm; Tue, 30 Nov 2021 15:03:23 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Th-005hUS-9o
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:51:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C2C15B81A4C;
 Tue, 30 Nov 2021 14:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834BBC58324;
 Tue, 30 Nov 2021 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283887;
 bh=JiZ5FO+CZFnSjMYSDii2CX5Y6+gDB7DmWLQaiPPoI2k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KgdyX9/RvQVU97mqrnQ8/RDLQRXNppSScDm9Jy79LFyu/6YQ9YZPLFnS7R4pmr/6d
 SDK/3yQRQ9f1nJ4pggBcBnJGpjjLD5uqjJnuB9PZnv7OQY5HDH9He1GytQEbyhi5Pt
 jb4GYC3gqPf31IsaheRtPwfOLpW2efW07CoqlaV8EeoXP5euKrK/F4keZ2/wMbY+LT
 vNV0TVYdmgMdsMeFPrBrhb14ku4RKFg17yjabDhffqGgGQ5qPPCjJHsEAbc0T7n/X+
 /pIuNEm8Vr3momaRKPHdj23yiPay5oRM+gxixK6ph9sy/QLcMvZ1XdN7+rgRk65Tge
 VX8cw+sBS002w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 29/43] nvmet-tcp: fix memory leak when performing
 a controller reset
Date: Tue, 30 Nov 2021 09:50:06 -0500
Message-Id: <20211130145022.945517-29-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065129_553979_792A33FB 
X-CRM114-Status: GOOD (  15.46  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit af21250bb503a02e705b461886321e394b300524 ]

If a reset controller is executed while the initiator
is performing some I/O the driver may leak the memory allocated
for the commands' iovec.

Make sure that nvmet_tcp_uninit_data_in_cmds() releases
all the memory.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f1b9b0c3a3a63..8d669db40251b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1397,7 +1397,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_finish_cmd(cmd);
+			nvmet_req_uninit(&cmd->req);
+
+		nvmet_tcp_unmap_pdu_iovec(cmd);
+		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
-- 
2.33.0


