Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF5FC43217
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2rjujWWhfgfG5tiQA0YDLR0d/ewQAf1OGHqtKrMnW4=; b=F4xdLKDL7VLdBhP3uGxvYsIp+l
	K871LRoAm6vnITRAwUgOPU3rDQNmIVhCesNsj9KrRBwZ3rz5Vzj4cU0Kp/Y6O8J2Yw1ox+zewdHGe
	WUbbjTGH3CSt9VtsYza3VDy7fnuId2GKY3HyDojH8bJtm8tSloYF2k4RbcHOKQRSRPmVQve4+S7y7
	whj0lM56h0TOzLzQryLoSeZ8sii6u/AyJLG1zxoKmns609EvyvoswmMhYG4tIzBYrf8Zhzm1ClhXT
	7o+lovr2SMZPS1TVLRT1mXsUvJ8SZWSh2fWc5X4FWTRc6+F9IIzZ544KTwajmyEiWomzUVVmsRz5l
	pJ4U87hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvg-009nBM-4z; Thu, 13 Oct 2022 00:18:28 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvM-009mzi-Ii
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:18:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4995EB81CC2;
	Thu, 13 Oct 2022 00:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F61C43142;
	Thu, 13 Oct 2022 00:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620286;
	bh=dwDcdLbwsITSd0znTm2jm+ojffy7JRp4bA5tasq8cI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qt1xltwIPH+NrxZy16OvHb0z+arvl73HuTj0joaQsnuKIt0WfVBIpgC78ssj18OKS
	 v4mOyVvyI9OgUs5yfKK4Z5712RkjjZZgmSLf3a+6DO8DEBN1U7gtJ34FGGZoclTn8a
	 DilvVNQoueAw8xvFTKjAh2kjVF5IlpBtsjesJsfXRNXV+5yz45ExSTGVpQvHcTBORb
	 OoLdanxM78oy9yoY5prOzpEl8V9zdguadFaM2n8ivTOPY8P6UxVgE10ZFWxN+nBIAq
	 Y+U6MiLG0AutwoZiTzfvaI82more/T2UjowMxe3cLJCZXANHkK8YTzJUfsmCzHhlc4
	 P/BLguT2qTtMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Varun Prakash <varun@chelsio.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 54/67] nvmet-tcp: add bounds check on Transfer Tag
Date: Wed, 12 Oct 2022 20:15:35 -0400
Message-Id: <20221013001554.1892206-54-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001554.1892206-1-sashal@kernel.org>
References: <20221013001554.1892206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_171808_820058_04F5DE77 
X-CRM114-Status: GOOD (  13.32  )
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

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit b6a545ffa2c192b1e6da4a7924edac5ba9f4ea2b ]

ttag is used as an index to get cmd in nvmet_tcp_handle_h2c_data_pdu(),
add a bounds check to avoid out-of-bounds access.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a3694a32f6d5..7dcf88cde189 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -935,10 +935,17 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
 
-	if (likely(queue->nr_cmds))
+	if (likely(queue->nr_cmds)) {
+		if (unlikely(data->ttag >= queue->nr_cmds)) {
+			pr_err("queue %d: received out of bound ttag %u, nr_cmds %u\n",
+				queue->idx, data->ttag, queue->nr_cmds);
+			nvmet_tcp_fatal_error(queue);
+			return -EPROTO;
+		}
 		cmd = &queue->cmds[data->ttag];
-	else
+	} else {
 		cmd = &queue->connect;
+	}
 
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
-- 
2.35.1


