Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46E7C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2rjujWWhfgfG5tiQA0YDLR0d/ewQAf1OGHqtKrMnW4=; b=foaM0g4LkC1V1zpS+y3PpYYcx8
	pCmex618f6xVDc299EzwZXznDSiILktm25wbO9tKV8BvSSgqMdYZELOe9UIr9aH3ra12aigYqX97G
	hlx8zAxKm0Ak5ciMr0dwThwLdEf9+O4Z8hjWGoWdG1F2gQ59mJKOVzWIqw0TyM4ShpdCUxpRDECHy
	lPywagGawJJqK5FaSDdZ5QSnphSle4Ogq8U4HReyqblK92tbDBig+w2ukUSCeHNtfwzKx/AAaYBHw
	kRd2HoKhepzn3EnE+SdxOMKThwdmVK7nNl/7pg0NAVRZknnHYjLV1FsiSF8ABLfm0CF6DuFvYjP4j
	D1j3aDHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oim4d-009rbi-As; Thu, 13 Oct 2022 00:27:43 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oily4-009oRC-5s
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:20:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BE54EB81CD8;
	Thu, 13 Oct 2022 00:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2A4C43142;
	Thu, 13 Oct 2022 00:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620453;
	bh=dwDcdLbwsITSd0znTm2jm+ojffy7JRp4bA5tasq8cI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWPV9d89eMZuC82yit4y6Bp+2Zx4oB/rz9HVoq+sYIlqw7XIzPjx8iqFtdXk4rMwW
	 gk453Qp01XKUj5sXzPMIb68pnuaswPbnMLxnOCU+G1/oNtFt76JvgXMnROy8q476ss
	 7OP0vHZnZLJIdBjsT+00IPGqtPJbIeTQMy/aJ+UJu0vHfu6bkkgM3+cr0pgNbkcEZ6
	 N58I9XAHnPTghCu6O3KKmt0o3jC8ri3HBEc0gsYC6HpjKFcT1L5iq6S5xkiWQ1TVXe
	 AbRWMazsch4zwxEbgzOn2HefEaFFKJnlR6AKZTrJIiYCdmEUTbpczWI2WH0Onk45pi
	 17ZD/TR0ncBBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Varun Prakash <varun@chelsio.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.19 52/63] nvmet-tcp: add bounds check on Transfer Tag
Date: Wed, 12 Oct 2022 20:18:26 -0400
Message-Id: <20221013001842.1893243-52-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001842.1893243-1-sashal@kernel.org>
References: <20221013001842.1893243-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_172056_387771_4208DFBC 
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


