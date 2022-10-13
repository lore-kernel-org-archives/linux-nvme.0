Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA02C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BMMIRGmMxLAr2rFGaqrgJiyfdU/BDDW4K7szMeY6Kcc=; b=fACMxx8w/spoXxRSWFCC76MGas
	2xrdXZDllFEiPRXxbdJFZDzzIRlPS0JMsbba+fjXzrYKTRtWTHkbIlvlMWd34dd0XspwCezdcrXR5
	+7qD260rjRKUNvbDVCHfHTnH2e3gZgGLK5j7mETf4Vrt7GZTpF5JcnyPMwif6C/FnmyZ+DDjNb3T/
	HVFz+NvJTVySAbWOEaQmE5SqaAuKFLXgubzFLPYAQamskecmfqTHqMk8Shshhx/SH8n0xytAl6NSi
	1mmhkh0TaycAdsEgIqlOQeCFTZnKOUYJLiaz4uaxIlueg0qAObj3vYOwRa3CglGv7HOoy5txuiD/U
	Oz3xYUPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oimBx-009v6S-33; Thu, 13 Oct 2022 00:35:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oim0M-009pY4-1b
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:23:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 77975616F9;
	Thu, 13 Oct 2022 00:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D298C433D6;
	Thu, 13 Oct 2022 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620597;
	bh=z6CmzjKVk4PY69fRH9ipg6espvL9nETdxiwJhXO51/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkMpCmfh2ZJInJsmU+6FQ+/MBB97yUgfv12hWOIaN2IDSmaIc5V4PECoYwTq589mV
	 nKjyijsnNFC2Kc1XBAV1ebCQNfUDHdfamKxE8y+HbwojNhNYxM6NAOS0qF4Lo655ec
	 WC7m+Mungbk79JgPAkqVC9UrvZYqYqGJNPAO0RNylUukNNi1B3aIFiqjmydTNpYTc2
	 1548Ct8dIk31EYAtRHEcTv6e++O4UTrGjQQJYHpYDIdUf/yUcSiSCfdWRD2sgoXCz2
	 QTGwdxnqFr+Q+BB1xi2HcgV0wAmJ5vWo8qkZZk8odYNXELferHmm4zGMZKqHpkqHWZ
	 Th+DBJsQ0r5ZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Varun Prakash <varun@chelsio.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 42/47] nvmet-tcp: add bounds check on Transfer Tag
Date: Wed, 12 Oct 2022 20:21:17 -0400
Message-Id: <20221013002124.1894077-42-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013002124.1894077-1-sashal@kernel.org>
References: <20221013002124.1894077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_172318_195426_50025E6D 
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
index fba5a77c58d6..2add26637c87 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -934,10 +934,17 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
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


