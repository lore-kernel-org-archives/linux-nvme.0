Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D1DC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7DxRvWtqyC9FvWnrNSveKfbAvdAYOxjGUjBJR53R608=; b=FHBw8S4xUVSF2gWQcCtPjQIF1y
	mnOYIErnDQTlopB0P8nyo66miRakqZq0aUmgOxVcD+6LUSOxnfk9Hv4A+YwtYY4qw3Pkk+wOCqOAk
	D9mgx6AysScO4S1Fdn2G6QSyI6RW4qz1RuzETttdhbmw3ijQKxEB9zq05ZhAFS8XGSGsYMWkUkFm+
	zMiFeGDeSkZbpTeWT4qD9FYOoYjb1tNQrDGJmUfjZZwig6shOL6W7LXcQsFj69UV28xu5XPKOjuaI
	6CrPH2LHvgYcHx/ypUq3yMzjiHqiYdL/3SaRCkq0x5wnzYeMj2JzCy0q87D44MWey9ERnAkOcLAeo
	zA6zOGGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oimJN-009yjL-QM; Thu, 13 Oct 2022 00:42:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oim37-009qsj-56
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:26:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 73875615BE;
	Thu, 13 Oct 2022 00:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE43C43141;
	Thu, 13 Oct 2022 00:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620768;
	bh=j+67didnIPF+xzyve6MvUXmjz4nmKeBUiydpiwCnhUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmcsQZWXdC+C1VleaBDwW39O+UhK1kDH9cWUoLlk+zpIWQpR9efcCwpyHl9FXjsT5
	 UGyWfAyb0EfpS0H+qIN0jv44S2ocbHzAE6qxzXqx8QX3ZYx9WBzzOKLYzGuU0O93g9
	 O86qAxZQdZ9yhI2sFmkLQh3uGSog5iGp85ptYlTYxrME8J0oFui5oY8n7AjoJFXYa1
	 I4iyPlr+/e3dOArI10n7DRmRb0BQtWOKvEJPKpXyVGloB3bE1lXKA6uaXEXrp3gqqQ
	 O+L1ZC0manfD9cpxF7T8o6AsRmmbF0/ZROffjWVHiLByVGw0NmTVzUdBFqyIQz+WF2
	 C6VjJUJuory1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Varun Prakash <varun@chelsio.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 23/27] nvmet-tcp: add bounds check on Transfer Tag
Date: Wed, 12 Oct 2022 20:24:55 -0400
Message-Id: <20221013002501.1895204-23-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013002501.1895204-1-sashal@kernel.org>
References: <20221013002501.1895204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_172609_311899_85E59AC2 
X-CRM114-Status: GOOD (  13.53  )
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
index eb5b39c2bba8..df7a911d303f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -858,10 +858,17 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
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


